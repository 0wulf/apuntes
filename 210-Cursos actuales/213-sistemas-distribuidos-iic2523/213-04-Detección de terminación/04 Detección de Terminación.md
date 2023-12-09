Es simple detectar cuando un programa secuencial ha terminado.
Es simple detectar cuando un programa concurrente, corriendo en un único procesador, ha terminado:
- Cada proceso está bloqueado o terminado y
- no hay operaciones de I/O pendientes.
---
Por su parte, no es simple detectar cuando un programa distribuido ha terminado:
- El estado global no es visible para ningún procesador
- incluso si todos los procesadores están desocupados, puede haber mensajes en tránsito entre procesadores.

Sin embargo, hay varios algoritmos para hacerlo:
- [[Circulación de un token]]
- [[El grafo de nodos es un árbol]]
- Dijkstra-Scholten
- Recuperación de crédito
---
# Circulación de un Token
## Los procesos forman un anillo y toda la comunicación viaja alrededor del anillo.

Cada proceso `T[i]` recibe mensajes solo de su propio canal `ch[i]` y envía mensajes solo al próximo canal `ch[i+1]`

En cualquier instante, cada proceso está o activo o desocupado:
- Está desocupado si ha terminado o está suspendido ejecutando una operación `receive`
- después de recibir un mensaje, un proceso desocupado se vuelve activo
---
## Condición de terminación: Todo proceso está desocupado y no hay mensajes en tránsito
Vamos a superponer un algoritmo de detección de terminación a una computación distribuida arbitraria en que los procesos se comunican como si estuvieran dispuestos en un anillo.

Terminación es una propiedad del estado global:
- la unión de los estados de los procesos individuales más el contenido de los canales
- los procesos tienen que comunicarse entre ellos para determinar si la computación ha terminado
---
## Supongamos que circula un token en mensajes que no son parte de la computación misma
El proceso que tiene el token lo pasa cuando se desocupa
- un proceso que ha terminado su computación está desocupado, pero sigue participando en el algoritmo de detección de terminación

Los procesos pasan el token usando el mismo anillo de canales de comunicación que usan para la computación misma:
- cuando un proceso recibe el token, sabe que el emisor estaba desocupado al momento de enviarlo
- él mismo tiene que estar desocupado
- y no volverá a estar activo hasta recibir un mensaje regular de la computación misma.
---
## ¿Cómo detectamos cuando toda la computación ha terminado?
Al recibir el token
- un proceso se lo envía a su vecino
- y luego se queda a la espera de recibir otro mensaje

Cuando el token ha dado una vuelta completa al anillo, sabemos que todos los procesos estuvieron desocupados en algún instante.

Miremos al proceso que tiene el token:
- ¿Cómo se puede determinar si todos los procesos están aun desocupados y no hay mensajes en tránsito?
---
## Suponemos que, inicialmente `T[1]` tiene el token
Cuando queda desocupado, inicia el algoritmo pasando el token a `T[2]`

Cuando el token vuelve a ...

---
## El algoritmo para un anillo
Asociemos un color con cada proceso:
- azul si está desocupado
- rojo si está activo

Inicialmente, todos los procesos están activos: rojos

Cuando un proceso recibe el token, es porque está desocupado:
- Se pinta de azul a si mismo
- pasa el token y
- espera a recibir otro mensaje

Si el proceso recibe más adelante un mensaje regular
- se pinta de rojo a si mismo

Luego, un proceso que está azul
- se volvió desocupado
- pasó el token y 
- ha permanecido desocupado desde que pasó el token

Cuando `T[1]` recibe el token, si está de azul, entonces anuncia terminación y se detiene

---
# Estructura de comunicación general
## En general, la estructura de la comunicación forma un grafo direccional arbitrario
Los nodos son procesos y las aristas las rutas de comunicación:
- Hay una arista de un proceso a otro proceso si el primero envía a un canal desde el cual el segundo recibe

Supongamos que el grafo es completo:
- hay una arista desde cada proceso a cada uno de los otros procesos
- cada proceso `T[i]` recibe a través de su canal privado de input `ch[i]`
- cualquier proceso puede enviar mensajes a `ch[i]`
---
## El algoritmo para un anillo no funciona en general (e.g. un grafo completo de 3 procesos)
- Los procesos pasan el token solo de `T[1]` a `T[2]` a `T[3]` y de vuelta a `T[1]`
- Supongamos que `T[1]` tiene el token, se vuelve desocupado e inicia el algoritmo pasando el token a `T[2]`.
- Cuando `T[2]` queda desocupado pasa el token a `T[3]`, pero justo `T[3]` le envió un mensaje a `T[2]` antes de recibir el token
- Cuando el token vuelva a `T[1]` este no puede asumir que la computación ha terminado, aunque haya permanecido desocupado.
---
## Detectar terminación en general es más difícil: los mensajes pueden llegar por cualquier arista
La clave del algoritmo anterior es que toda la comunicación viaja alrededor del anillo:
- y por lo tanto el token "hace avanzar" los mensajes regulares
- en particular, el token viaja por cada arista del anillo

Podemos extender el algoritmo anterior si aseguramos que el token viaje por cada arista del grafo:
- aunque visite cada proceso muchas veces
- si cada proceso ha permanecido desde que vio el token por primera vez
- entonces podemos concluir que la computación terminó
---
## El algoritmo para un grafo completo- Cada proceso está pintado de rojo o azul, con todos los procesos inicialmente rojos.
- Cuando un proceso recibe un mensaje regular, se pinta de rojo.
- Cuando un proceso recibe el token --está bloqueado esperando a recibir el próximo mensaje:
	- se pinta de azul (si no está azul)
	- y pasa el token
- Todo grafo direccional completo contiene un ciclo (ciclo de Euler) que incluye a cada arista (exactamente una vez):
	- sea $C$ el ciclo y $nc$ su longitud
- Cada proceso sabe el orden de sus aristas de salida en $C$
	- al recibir el token por una arista, el proceso lo envía por la próxima --asegurando que el token viaje por cada arista
- El token tiene ahora un valor --un número entero:
	- el número de veces consecutivas que ha pasado por procesos desocupados
	- y por lo tanto, el número de canales que podrían estar vacíos.
- El token está inicialmente en cualquier proceso y vale 0.
- Cuando ese proceso se desocupa por primera vez:
	- se pinta de azul
	- y pasa el token por su primera arista en $C$
- Al recibir el token:
	- si el proceso está rojo, se pinta de azul, pone el valor del token en 0 y lo envía --es decir, reinicia el algoritmo.
	- si está de azul, incrementa el valor del token y lo pasa.

```
// La acción de T[i] al recibir un mensaje regular
color[i] <- rojo

// y las acciones de T[i] al recibir el token
if (token == nc):
	anunciar terminación y detenerse
if (color[i] == rojo):
	color[i] <- azul
	token <- 0
else:
	token <- token+1
j <- índice de canal próxima arista en C
send ch[j](token)
```
---
# Algoritmo para detectar terminación basado en un árbol de cobertura
- $n$ procesos son los nodos de un grafo no direccional
	- cuyas aristas representan los canales de comunicación
- El algoritmo emplea un árbol de cobertura fijo (un subconjunto de aristas del grafo):
	- el proceso `T[1]` es la raíz, es responsable de detectar terminación.
- `T[1]` se comunica con los otros procesos para determinar sus estados:
	- los mensajes empleados para esto los llamamos tokens.
---
## Una versión simple... pero no segura
- Todos los nodos hojas se reportan a sus padres, si han terminado
- Similarmente, otros nodos se reportan a sus padres cuando han terminado sus ejecuciones y todos sus hijos han terminado.
- La raíz concluye que ha ocurrido terminación si ella misma ha terminado --quedó desocupada-- y todos sus hijos han terminado.
- Sin embargo:
	- un proceso puede recibir un mensaje regular de otro proceso que no está en su subárbol
	- después de que el primer proceso le ha enviado un token a su padre
	- y puede volverse activo nuevamente.
---
## Una versión segura basada en colorear tokens y procesos
- Todos los tokens en las hojas son inicialmente blancos
- Si un proceso ha enviado un mensaje regular a otro, al terminar envía un token gris a su padre
	- de lo contrario, envía un token blanco.
- El padre, al recibir el token gris, sabe que su hijo ha enviado un mensaje a otro proceso
	- y cuando el padre a su vez termina, envía un token gris a su padre
- Finalmente, la raíz sabe que ha habido envío de mensajes cuando recibe un token gris de alguno de sus hijos
	- y pide a todos los nodos reiniciar el algoritmo de terminación.