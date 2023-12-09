Las **arquitecturas de memoria distribuida** son comunes hoy en día.
Los procesadores tienen su propia memoria privada
Acá hay que diseñar un algoritmo en base a traspaso/intercambio de mensajes en vez de compartir memoria.
![[Pasted image 20230810110048.png]]

# ¿Cómo escribimos programas para arquitecturas de memoria distribuida?
* `read/write` requiere utilizar busy waiting explícitamente. Podemos hacerlo mejor
Definiremos **operaciones de red** que incluyan sincronización:
* Operaciones básicas de paso de mensajes
* si comparamos con memoria compartida extienden el concepto de los semáforos para transmitir datos además de emplear sincronización.
Los procesos comparten **canales**:
* Rutas de comunicación entre procesos.
* Abstracción de la red de comunicaciones
Los canales son los únicos objetos compartidos por los procesos:
* Cada variable es local a un proceso
* Las variables no están sujetas a accesos concurrentes - no se requieren mecanismos de exclusión mutua en el acceso a las variables
* Los procesos deben comunicarse para interactuar

# Declaración de un canal
Un canal es una cola de mensajes enviados pero aun no recibidos.
`channel <ch>(<tp1> <id1>, ..., <tpn> <idn>)`
* `<ch>` es el nombre del canal
* `<tpi> <idi>` son los datos obligatorios y los nombres opcionales de los campos del mensaje transmitido
#### Ejemplos
```
channel input(char)
channel diskAccess(int cylinder, int block, int count,  char* buffer)
channel[n] result(int)    // Arreglo de canales 
```

#### `send <ch>(<expr_1>, ..., <expr_n>)`
* `<expr_i>` son expresiones cuyos tipos deben corresponder con los tipos de los campos en la declaración de `<ch>`
El efecto de ejecutar `send`:
* Evaluar las expresiones
* Agregar un mensaje con estos valores al final de la cola asociada con el canal `<ch>`

`send` para el emisor: 
* no produce demora y
* es NO bloqueante

#### `receive <ch>(<var_1>, ..., <var_n>)`
* `<var_i>` son variables cuyos tipos deben corresponder con los tipos de los campos en la declaración de `<ch>`
El efecto de ejecutar `receive`:
* El proceso se suspende hasta que haya al menos un mensaje en la cola del canal de `<ch>`
* entonces el proceso saca el mensaje que está al comienzo de la cola y asigna sus campos a los `<var_i>`
Es una operación bloqueante: el proceso no necesita utilizar busy waiting.

### Supongamos que los canales se comportan bien:
* El acceso a un canal es atómico.
* La entrega de un mensaje es confiable y libre de errores
* Todo mensaje que es enviado a un canal es entregado y sin ser corrompido
* Los canales son colas FIFO.

# El problema de la sección crítica
Queremos asegurarnos que el acceso a la sección crítica se haga bajo exclusión mutua y otras propiedades
```
process p[i]:
	while (true):
		<protocolo de entrada>
		<sección crítica>
		<protocolo de salida>
		<sección no critica>
```
En SSOO+Redes nos interesaba este problema bajo memoria compartida.

El desafío es diseñar protocolos de entrada y salida de modo que se cumpla
Propiedades de seguridad (1-3) y de progreso (4)
1. Exclusión mutua: a lo más un proceso a la vez está ejecutando su sección crítica
2. No hay deadlocks: si dos o más procesos están tratando de entrar a sus SCs, entonces a lo menos uno tendrá éxito.
3. No hay postergación innecesaria
4. Entrada: un proceso que está tratando de entrar a su SC eventualmente tendrá éxito.
## Algoritmo de sacar número (bajo memoria compartida)
Dos pasos fundamentales:
* Un proceso que quiere entrar a su SC primero saca un número uno más grande que el número que tenga cualquier otro proceso
* luego espera hasta que todos los procesos con números menores hayan pasado por su SC
```
int number <- 1
next <- 1
int[n] turn <- {0...0}

// process p[i]:
while (true):
	turn[i] <- FA(number,1)   // FA es una operación atómica
	while (turn[i] != next);
	<sección crítica>
	next++
	<sección no crítica>
```

## Algoritmo de la panadería (bajo memoria compartida)
Un proceso le pide permiso a todos los otros para entrar a la sección crítica.
* Un proceso que quiere entrar a su SC primero mira los turnos de todos los otros procesos y luego define su propio turno como uno más que el de cualquier otro proceso.
* El proceso luego espera comparando su turno con el de todos los otros procesos hasta que el suyo sea el menor de todos (exceptuando los 0s)
```
int[n]<-{0...0}

// process p[i]
while (true):
	turn[i] <- 1
	turn[i] <- max{turn[1],...,turn[n]}+1
	for (j<-1..n, st j != i):
		while ((turn[j] != 0) and ( (turn[i],i) > (turn[j],j) ));
	<sección crítica>
	turn[i] <- 0
	<sección no crítica>
```

## Algoritmo de Ricart-Agrawala
Usaremos dos procesos por nodo (comparten memoria y variables)
* `main` proceso que quiere entrar a la sección crítica
* `receive` el proceso que recibe y procesa solicitudes de otros nodos (en particular cuando `main` está ejecutando su protocolo de entrada)
```
int my# <- 0
set deferred <- 0

process main:
	while (true):
		<sección no crítica>
		# protocolo de entrada
		for (all other nodes i):
			send rqst[i](myID, my#)
		await replies from all other nodes
		<sección crítica>
		# protocolo de salida
		for (all nodes in deferred):
			nodeID <- deferred.remove()
			send rply[nodeID](myID)

process receive:
	int nodeID, rqst#
	while (true):
		receive rqst(node,ID, rqst#)
		if (rqst# < my#):
			send rply[nodeID](myID)
		else:
			deferred.insert(nodeID)
```
La solución anterior tiene tres problemas:
1. Los procesos podrían elegir números iguales 
2. Los procesos deben elegir números monótonamente crecientes
3. Algunos procesos podrían no querer entrar a la SC aún estando en su turno y estancar al resto.
Corrijamos el algoritmo:
1. Desempatarlos con el número único de proceso: el operador `<<` primero compara los operandos, si son iguales entonces compara los números nodeID de los procesos
2. Cada proceso actualiza una variable local `highest` asignándole el número `rqst#` más grande que ha visto hasta el momento.
3. Variable que indique si quiere o no entrar a su SC

```
int my# <- 0, highest <- 0
set deferred <- vacío
bool rqstCS <- false

// process main:
while (true):
	<sección no crítica>
	rqstCS <- true
	my# <- highest + 1
	for (all other nodes i):
		send rqst[i](myID, my#)
	await replies from all other nodes
	<sección crítica>
	rqstCS <- false
	for (all nodes in deferred):
		nodeID <- deferred.remove()
		send rply[nodeID](myID)

// process receive:
int nodeID, rqst#
while (true):
	receive rqst[myID](nodeID, rqst#)
	highest <- max(highest, rqst#)
	if (!rqstCS or (rqst# << my#)):
		send rply[nodeID](myID)
	else:
		deferred.insert(nodeID)
```

Este algoritmo puede ser ineficiente si hay muchos nodos:
Cada vez que un nodo quiere entrar a su SC debe enviar $n-1$ mensajes y recibir $n-1$ mensajes, incluso si nadie más quiere entrar: $O(n)$.

## Algoritmo de LeLann (token circulando en un anillo)
La solución es descentralizada y justa.
Como los procesos `user[i]` tienen otro trabajo que hacer, empleamos procesos adicionales, `helper[i]` que son los que forman el anillo y se preocupan de enviar y recibir el token:
- Circula un token -un mensaje nulo- entre los procesos `helper`
- cuando `helper[i]` recibe el token, ve si `user[i]` quiere entrar a su SC, en cuyo caso se lo permite. de lo contrario solo hace circular el token.
```
channel[1..n] token(),
	enter(),g(),exit()

process helper[i=1..n]:
	while true:
		receive token[i]()
		if (!empty(enter[i])):
			receive enter[i]()
			send go[i]()
			receive exit[i]()
		send token[i+1]()

process user[i=1..n]:
	while true:
		send enter[i]()
		receive go[i]()
		SC
		send exit[i]()
```

## Algoritmo de Ricart-Agrawala, versión tokens
Usamos dos arreglos en cada nodo para decidir si hay solicitudes pendientes:
- `granted`, número `my#` de cada nodo (proceso) la última vez que se le concedió permiso para entrar a su SC
	- va incluido en el mismo mensaje que se usa para enviar el token
	- solo la copia que está en el nodo que tiene el token es significativa
- `request`, números `my#` que acompañan a los últimos mensajes `rqst` de cada uno de los otros nodos
El token no se pasa a menos que se necesite:
Si el nodo `i` que tiene el token que que
```
request[j] > granted[j] and request[k]>granted[k]
```
para los nodos `j` y `k` entonces:
- si `i` no está en su SC, entonces envía el token a uno de `j` o `k` 
- si `i` está en su SC, entonces envía el token al salir de la SC
- al enviar el token,  `i` también envía su arreglo `granted`
```
int[] request <- [0..0]
int[] granted <- [0..0]
int my# <- 0
bool inCS <- false
bool haveToken <- true en nodo 0, false en otros

process main:
	while true:
	NCS
	if !haveToken:
		my# <- my# + 1
		for all other nodes i:
			send rqst[i](myID, my#)
		receive token(granted)
		haveToken <- true
	inCS <- true
	SC
	granted[myID] <- my#
	inCS <- false
	sendToken

process receiver:
	int source, req#
	while true:
		receive rqst[myID](source, req#)
		request[source] <- max(request[source], req#)
		if (haveToken and !inCS):
			sendToken

sendToken:
	if (exists p such that request[p] > granted[p]):
		for (some such p):
			send token(p, granted)
			haveToken <- false
```
