- Cómo funciona `make`: revisa la hora de cada archivo fuente y si ésta es mayor que la hora del archivo objeto correspondiente, entonces recompila el archivo fuente.
- Pero, ¿qué podría pasar en un sistema distribuido en que no hay acuerdo global sobre la hora y el editor y el compilador corren en computadores diferentes?
![[Pasted image 20230911184004.png]]
---
### La base de muchos protocolos de sincronización es una ordenación total de los eventos de comunicación
Dos tipos de acciones de los procesos en un programa distribuido:
- Acciones locales, e.g. escribir y leer variables, que no tienen efecto sobre otros procesos
- Acciones de comunicación, e.g., enviar y recibir mensajes, que sí afectan la ejecución de otros procesos
Las acciones de comunicación son los eventos de un programa distribuido:
- `send`
- `broadcast`
- `receive`
---
### Los eventos relacionados causalmente se pueden ordenar
![[Pasted image 20230911184456.png]]
- Hay un orden total entre eventos relacionados causalmente, pero solo hay un orden parcial entre todos los eventos en un programa distribuido
![[Pasted image 20230911184602.png]]
### ¿Podríamos llegar a tener ordenación total?
- Si hubiera un único reloj central, podríamos ordenar totalmente los eventos de comunicación, asignándole a cada uno un timestamp único
- Pero estamos en sistemas distribuidos 
- Es imposible sincronizar los relojes físicos
---
# Relojes Lógicos
- Un reloj lógico es un contador que es incrementado cuando ocurren eventos:
	- ejecuciones de `send`, `broadcast` y `receive`
- Suponemos que cada proceso tiene un reloj lógico, que inicialmente vale 0
	- y que cada mensaje contiene un timestamp

![[Pasted image 20230911185059.png]]
... acá se inicializa en 0, se ejecuta `send` así que se incrementa, luego se recibe y se ejecuta `receive` así que incrementa de nuevo, luego se ejecuta `send` así que se incrementa, luego se recibe y se ejecuta `receive`, as'que se incrementa.
## Podemos asociar una hora con cada evento
Para un `send`/`broadcast`:
- la hora es el timestamp del mensaje, es decir, el valor local de `lc` al comienzo del `send`/`broadcast`
Para un `receive`:
- la hora es el valor de `lc` después de asignarle el máximo entre `lc` y `ts+1`, pero antes de incrementarlo
![[Pasted image 20230911185449.png]]
---
## Podemos tener ordenación total
Ahora podemos usar un identificador único por proceso para desempatar cuando dos eventos tengan la misma hora y así obtener una ordenación total. 

---
## Ejemplos funcionamiento de relojes lógicos de Lamport
![[Pasted image 20230911185659.png]]

Ejemplo multicasting totalmente ordenado:
![[Pasted image 20230911185719.png]]

---
## Los relojes lógicos de Lamport están en el middleware
![[Pasted image 20230911190429.png]]

---
# Multicast totalmente ordenado
Consideremos un grupo de procesos haciendo multicasting entre ellos:
- cada mensaje tiene un timestamp con la hora lógica actual del emisor
- los mensajes también son enviados al propio emisor
- los mensajes enviados por un mismo emisor son recibidos en el orden en el que fueron enviados
Cuando un proceso recibe un mensaje, lo pone en una cole ordenada según el timestamp del mensaje:
- el receptor hace multicast de un acknowledgement (`ACK`) a los otros procesos
- (siguiendo el algoritmo de Lamport) el timestamp del mensaje recibido es menor que el timestamp del `ACK`
- todos los procesos van a tener finalmente la misma copia de la cola local
Un proceso puede entregar un mensaje de la cola a la aplicación que está ejecutando solo si el mensaje está al comienzo de la cola y ha sido acknowledge por cada uno de los otros procesos:
- entonces, el mensaje se saca de la cola
- se le pasa a la aplicación (los `ACK`s correspondientes simplemente se sacan de la cola)
- como cada proceso tiene la misma copia de la cola, todos los mensajes son entregados en el mismo orden en todas partes -> multicasting totalmente ordenado
---
## Paréntesis: Semáforos distribuidos
En sistemas de memoria compartida, representamos un semáforo `s` como un entero mayor o igual a 0
- La ejecución de `P(s)` espera hasta que `s` sea positivo, a lo que decrementa `s`
- La ejecución de `V(s)` incrementa `s`
En todo momento, el número de operaciones `P` terminadas es a lo más igual al número de operaciones `V` terminadas más el valor inicial de `s`
#### Para tener semáforos distribuidos, necesitamos tres cosas
1. Una manera de contar el número de operaciones `P` y el número de operaciones `V`
2. Una manera de postergar la ejecución de operaciones `P`
3. Que los procesos cooperen para mantener el invariante `s >= 0` (aun cuando el estado del programa sea distribuido, es decir, cuando no exista una variable `s` global)
#### En cada proceso:
- Una cola local de mensajes `mq`
- Un reloj lógico `lc` que cumple con las reglas que vimos recién
#### Para ejecutar una operación `P` o `V` un proceso hace *broadcast* de un mensaje a todos los procesos, incluyéndose
El mensaje contiene tres campos:
- Identidad (número) del proceso emisor
- Una etiqueta `P` o `V` que indica el tipo de operación
- Un timestamp: el valor actual del `lc` del proceso emisor
Cuando un proceso recibe un mensaje `P` o `V` lo pone en su cola `mq` en orden creciente de timestamp
---
## *Broadcast* no es una operación atómica
- Si los procesos recibieran todos los mensajes en el mismo orden creciente de *timestamps* 
	- entonces todos los procesos sabrían en qué orden fueron enviados `P` y `V` y cada uno podría contar el número de operaciones `P` y `V` y mantener el invariante del semáforo
- Pero los mensajes enviados por dos proceso distintos pueden ser recibidos por otros procesos en diferente orden (es decir, *broadcast* equivale a la ejecución concurrente de `send`)
	- incluso, un mensaje con un *timestamp* menor podría ser recibido después que otro mensaje con un *timestamp* mayor
entonces...
## *Multicast* totalmente ordenado
- Todos los mensajes son entregados en el mismo orden a cada receptor
- Consideremos un grupo de procesos haciendo *multicasting* entre ellos:
	- Cada mensaje tiene un *timestamp* con la hora lógica actual del emisor
	- Los mensajes también son enviados al propio emisor
	- Los mensajes enviados por un mismo emisor son recibidos en el orden en que fueron enviados
- Cuando un proceso recibe un mensaje, lo pone en una cola ordenada según el *timestamp* del mensaje
	- El receptor hace *multicast* de un `ACK`
	- (siguiendo el algoritmo de Lamport) el *timestamp* del mensaje recibido es menor que el *timestamp* del `ACK`
	- Todos los procesos van a tener finalmente la misma copia de la cola local
- Un proceso puede entregar un mensaje de la cola a la aplicación que está ejecutando solo si el mensaje está al comienzo de la cola y ha sido `ACK` por cada uno de los otros procesos
	- Entonces el mensaje se saca de la cola
	- y de le pasa a la aplicación (los `ACK`s correspondientes simplemente se sacan de la cola)
	- Como cada proceso tiene la misma copia de la cola, todos los mensajes son entregados en el mismo orden en todas partes
#### *Broadcast* equivale a la ejecución concurrente de `send`
Los mensajes enviados por un proceso serán recibidos por los otros procesos en el orden en que fueron enviados:
- y tendrán *timestamps* crecientes
#### Mensajes totalmente recibidos y prefijos estables
- Si la cola `mq` de un proceso `R` contiene un mensaje `m` con *timestamp* `ts` y `R` recibe un mensaje con *timestamp* mayor al `ts` de cada otro proceso
	- entonces `R` sabe que nunca más recibirá un mensaje con *timestamp* menor
	- es decir, `m` se ha vuelto **totalmente recibido**
	- y todos los mensajes delante de `m` en `mq` también se han vuelto totalmente recibidos
- La parte de `mq` que contiene los mensajes totalmente recibidos es un **prefijo estable**.
#### Mensajes `ACK` de recepción
Cada vez que un proceso recibe un mensaje `P` o `V`, hace *broadcast* de un `ACK`
- Tienen *timestamps* normales
- El propósito es apurar la determinación de cuando un mensaje regular `P` o `V` se ha vuelto totalmente recibido
#### Actualización de los prefijos estables
- Cada proceso `R` tiene una variable `s` que representa el valor del semáforo
- Cuando `R` recibe un `ACK`, actualiza su prefijo estable de su cola `mq`
	- por cada mensaje `V`, `R` incrementa `s` y elimina el mensaje
	- `R` revisa los mensajes `P` en orden de *timestamp*: si `s > 0` entonces `R` decrementa `s` y elimina el mensaje
- Todos los procesos toman la misma decisión acerca del orden en que finalizan las operaciones `P`
#### Como en otros casos, cada nodo `i` tiene un  proceso `user[i]` y otro `helper[i]`
![[Pasted image 20231003100506.png]]
![[Pasted image 20231003100520.png]]
![[Pasted image 20231003100547.png]]
## Relojes Vectoriales
Cada proceso $P_i$ mantiene un vector $V_i$ con dos propiedades
- $V_i[i]$ es el valor del reloj lógico local en $P_i$. Este valor se mantiene incrementando al ocurrir cada evento en $P_i$
- $V_i[k]$ es lo último que $P_i$ sabe acerca del reloj lógico local de $P_k$. Este valor se mantiene enviando los vectores como *timestamps* de mensajes
El vector $V_i$ constituye la vista que tiene $P_i$ del tiempo lógico global
#### Los procesos siguen las siguientes reglas para actualizar sus relojes
![[Pasted image 20231003101016.png]]
![[Pasted image 20231003101028.png]]