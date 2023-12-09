Además de comunicarse (RPC, paso de mensajes), los procesos deben 
- sincronizarse:
	- asegurar que un proceso espere a que otro complete su operación
	- o asegurar que dos conjuntos de datos sean el mismo
- y coordinar sus acciones:
	- administrar las interacciones y dependencias entre las diversas actividades
	- la coordinación envuelve a la sincronización

- Relojes (sincronización de relojes físicos, **relojes lógicos**)
- **Exclusión mutua**
- **Algoritmos de elección**
- Sistemas de localización
- *Matching* de eventos (sistemas publicación-suscripción)

---
## Algoritmos de elección
- Muchos sistemas distribuidos requieren que un proceso (no importa cual) actúe como coordinador, iniciador o que juegue un rol especial
- Como lo hemos dicho antes, si todos los procesos son exactamente iguales, sin características distintivas
	- entonces no hay cómo seleccionar a uno de ellos para que cumpla un rol especial
- Como lo hemos hecho antes, supondremos que cada proceso tiene un identificador único
	- y que también cada proceso conoce el identificador de cada uno de los otros procesos
- Los algoritmos de elección tratan de encontrar al proceso con el identificador numéricamente mayor para designarlo como coordinador
- Lo que los procesos no saben es cuáles procesos están actualmente funcionando y cuáles han dejado de funcionar o están caídos
- El objetivo de un algoritmo de elección es que al finalizar, todos los procesos estén de acuerdo en cuál es el nuevo coordinador
---
### Algoritmo del Bully
Cuando cualquier proceso `k`se da cuenta que el coordinador no está respondiendo, inicia una elección
1. `k`envía un mensaje `election` a todos los procesos con identificadores $>k$
2. Si nadie responde, entonces `k` gana la elección y se vuelve coordinador, enviando un mensaje `coordinator`
3. Si uno de los procesos responde, entonces ese proceso se hace cargo (enviando el mensaje `coordinator`) y la tarea de `k` está terminada
![[Pasted image 20230927111330.png]]
---
### Algoritmo basado en un anillo lógico (pero sin uso de token)
- Cada proceso sabe quién es su sucesor
- Cuando un proceso se da cuenta de que el coordinador no está funcionando, construye un mensaje `election` que contiene una lista con su propio identificador y lo envía al sucesor
- Si el sucesor no está funcionando, entonces el emisor lo salta y va al siguiente proceso en el anillo, y así hasta encontrar un proceso que esté funcionando
- Cada proceso que recibe un mensaje lo reenvía a su sucesor (o al sucesor de su sucesor, etc.), agregando su identificador a la lista (debe haber una forma de que el proceso sepa el sucesor del sucesor, etc.)
- Finalmente, el mensaje vuelve al proceso que inició la elección, que reconoce su propio identificador en la lista.
- El proceso cambia el mensaje a `coordinator` y lo envía nuevamente, para informar a todos quién es el nuevo coordinador y cuáles sol los procesos funcionando.
![[Pasted image 20230927111828.png]]
---
### Implementación de broadcast enviando el árbol de cobertura de la red
![[Pasted image 20230927112137.png]]
> The main job of both types of probes is to talk to your network devices and bring back answers. Once the probe *tests* a device, it'll receive whatever data the vendor of that equipment has made available.
---
### Implementación de broadcast cuando cada nodo conoce solo a sus vecinos
![[Pasted image 20230927112221.png]]
El último `for` es para que no queden mensajes dando vuelta.

---
### Determinación de la topología de una red tipo árbol
Donde cada nodo conoce solo a sus vecinos
![[Pasted image 20230927114302.png]]
![[Pasted image 20230927114313.png]]

---
### Determinación de la topología de una red en general (Lamport)
- Inicialmente, todos los nodos conocen solo a su vecinos
- La topología de la red es recolectada en dos fases
	- primero, cada nodo envía una sonda (probe) a sus vecinos
	- más tarde, cada nodo envía una respuesta (echo) con información de la topología local, al nodo desde el cual recibió la primera sonda
- Finalmente, el nodo iniciador habrá juntado todos los echo, y por lo tanto, la topología.
- La red es conexa -> todo nodo va a recibir una sonda
- No hay deadlock, ya que cada sonda es respondida (a través de un echo):
	- la primera, justo antes de que el proceso del nodo termine
	- las otras, mientras el proceso espera a recibir respuestas a sus propias sondas
	- el último echo enviado por un nodo que contiene la topología de su red de vecinos
![[Pasted image 20230927114551.png]]
![[Pasted image 20230927114604.png]]

---
### Elección de un líder en entornos inalámbricos
- en que la transmisión no es confiable y la topología de red es dinámica
- Un nodo cualquiera, llamado el nodo fuente, inicia el algoritmo enviado un mensaje `election` a sus vecinos inmediatos
- Cuando un nodo recibe un mensaje `election` por primera vez, designa al emisor como su padre y luego envía mensajes `election` a todos sus vecinos inmediatos, excepto a su padre
- Cuando un nodo recibe un mensaje `election` de un nodo diferente a su padre, simplemente hace `ack`
- Un nodo R, que ha designado a Q como su padre, envía mensajes `election` a sus vecinos inmediatos, excepto a Q, y queda a la espera de todos los `ack` antes de enviar su propio `ack` a Q
	- los vecinos que ya tienen un padre responden inmediatamente a R
	- si todos los vecinos ya tienen un padre, entonces R es una hoja (del árbol) y puede responder a Q rápidamente, incluyendo información sobre su capacidad (e.g. tiempo de vida de su batería)
	- esta información le permitirá a Q comparar las capacidades de R con las de otros nodos "aguas abajo" y seleccionar al mejor nodo para la coordinación
- Q había enviado mensajes `election` solo porque su padre P lo había hecho primero, así que cuando Q responda a P, le envía también el nodo más idóneo que conoce.
- El nodo fuente finalmente va a saber cuál nodo es el mejor para ser elegido coordinador y va a hacer broadcast de esta información a todos los otros nodos.
![[Pasted image 20230927120106.png]]
![[Pasted image 20230927120122.png]]

---
## Arquitecturas descentralizadas P2P (*Peer-to-peer*)
Desde una perspectiva de alto nivel, los procesos que forman un sistema P2P son todos iguales:
- las funciones que deben ser llevadas a cabo están representadas por cada proceso
- la mayor parte de la interacción entre procesos es simétrica
- cada proceso actúa como cliente y como servidor al mismo tiempo
### Red superpuesta u *overlay network*
- **los nodos son los procesos**
- las conexiones representan los posibles canales de comunicación
- ¿Cómo organizamos los procesos en una overlay network?
	- es posible que un nodo no se comunique directamente con otro nodo arbitrario
		- si no que deba enviar mensajes a través de los canales disponibles
- Dos tipos de overlay networks
	- estructuradas
	- no estructuradas
- En los sistemas P2P no estructurados cada nodo mantiene una lista *ad hoc* de vecinos
	- el overlay resultante forma un grafo aleatorio
	- un nodo generalmente cambia su lista de vecinos casi continuamente
	- al buscar un dato, no se puede seguir una ruta predeterminada, si no que se utiliza
		- *flooding*: Un nodo $u$ que busca un dato envía una solicitud a todos sus vecinos:
			- el nodo $v$ que recibe la solicitud la ignora si ya la recibió antes
				- de lo contrario $v$ busca localmente el dato solicitado
				- si no lo encuentra entonces reenvía la solicitud a todos sus vecinos
				- de lo contrario, responde directamente a $u$ o al nodo que haya enviado la solicitud el que a su vez responde a $u$...
			- Es muy costoso en términos de comunicación
				- las solicitudes tienen asociado un *time-to-live* TTL
				- el número máximo de veces que la solicitud puede ser reenviada de un nodo a otro
		- *random walks*: Un nodo $u$ que busca un dato envía una solicitud a un vecino $v$ elegido aleatoriamente
			- que si no tiene el dato reenvía a su vez la solicitud a un vecino aleatoriamente:
				- implica un menor tráfico de red
				- pero puede demorarse mucho en llegar al nodo que tiene el dato
				- por lo que en muchos casos $u$ inicia $n$ *random walks* en simultáneo lo que en la práctica reduce el tiempo de búsqueda en un factor de $n$
---
### Nodos *super peers*
Procesos de larga vida y alta disponibilidad
![[Pasted image 20231009142430.png]]
#### Elección de *super peers* en sistemas de gran escala
Requisitos para la elección de *super peers*
- los nodos normales o *weak peers* deben tener acceso con poca demora a los *super peers*
- los *super peers* deberían estar distribuidos de manera pareja en la red *overlay*
- debería haber una proporción predefinida de *super peers* relativa al total de nodos en la red
- cada *super peer* debería tener que atender un número máximo fijo de *weak peers*
Una posibilidad: Posicionamos los nodos en un espacio geométrico de dos (o varias) dimensiones
- Si necesitamos disponer de $N$ *super peers*:
	- asignamos $N$ *tokens* aleatoriamente a $N$ nodos (un *token* por nodo) en que cada *token* representa una fuerza de repulsión que hace que otro *token* trate de alejarse
	- si todos los *tokens* ejercen la misma fuerza de repulsión, entonces se van a alejar unos de otros hasta distribuirse uniformemente por el espacio geométrico
- La idea es que cuando un *token* determina que el total de fuerzas actuando sobre él excede cierto límite, lo pasa a otro nodo
	- en cambio, cuando un nodo mantiene un *token* por un cierto tiempo dado, el *token* se promueve a si mismo a *super peer*
![[Pasted image 20231009143238.png]]
Otra posibilidad, en casos como chord, en donde cada nodo tiene un identificados de m bbits, se reserva una fracción del espacio de identificadores (e.g. los k bits más a la izquierda) para los *super peers*
- k debe ser igual al $\log_{2}{(\text{\# de super peers})}$
- e.g. si suponemos $m=8$ y $k=3$
	- entonces cuando buscamos al nodo responsable de una clave $K$ específica, enviamos una solicitud de búsqueda al nodo responsable del patrón $K\wedge11100000$ que es considerado el *super peer*
		- cada nodo con ID puede chequear si es un *super peer* buscando $ID\wedge11100000$ y viendo si la solicitud es dirigida a si mismo
		- si hay $N$ nodos, entonces el número de *super peers* es $2^{k-m}N$ en promedio
![[Pasted image 20231009143749.png]]