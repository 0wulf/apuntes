Tenemos dos razones principales para replicar datos:
1. Confiabilidad
	- Se puede pasar de una réplica a otra si la primera falla
	- Se puede considerar que el resultado devuelto por la mayoría de las réplicas es el correcto
2. Desempeño
	- Cuando el sistema necesita escalar en tamaño (debido a un mayor número de clientes)
	- o cuando el sistema está lejos y queremos replicar más cercamente a nivel geográfico poniendo una copia de los datos físicamente cerca a 

Sin embargo, el tener múltiples copias lleva a problemas de consistencia
- Cada vez que una copia es modificada, se vuelve diferente al resto
- por ende, los cambios deben hacerse en todas las copias
- El cuándo y el cómo determinan el "precio" de la replicación
#### e.g. Cómo mejorar el tiempo de acceso a páginas web
- Si no se hace nada, cada solicitud va al servidor
- en cambio, los *browsers* pueden guardar copias localmente (una caché de páginas web)
	- el usuario percibe un excelente tiempo de acceso pero la página está desactualizada
- Si el servidor se encarga de hacer replicación, podemos tener de nuevo el problema original si no se ponen réplicas cerca del usuario
	- o si el servidor se encarga de invalidar o actualizar las copias en la caché, siguiendo la pista a todas las cachés y enviando mensajes, se puede tener nuevamente una degradación del desempeño
---
## La replicación como técnica de escalamiento
Colocar copias de los datos cerca de los procesos que los van o están usando, puede mejorar el desempeño vía la reducción de los tiempos de acceso, 
- aunque mantener las copias actualizadas requiere más ancho de banda de la red:
	- si la frecuencia de acceso es mucho menor que la de actualización, estamos malgastando los recursos de red
	- más aún, mantener múltiples copias consistentes puede presentar por sí mismo problemas serios de escalabilidad

- Intuitivamente, cuando se ejecuta una actualización en una copia
	- la actualización debe ser propagada a todas las otras copias antes de que ocurra otra operación
	- es decir, la actualización debe llevarse a cabo en todas las copias como una única operación atómica (e.g. usando un lock mientras se actualiza)
	- lo que es inherentemente difícil de lograr en la práctica si además las operaciones deben ejecutarse rápidamente
---
# Modelo de consistencia *data-centric*:
![[Pasted image 20231011111751.png]]
- Pero sin un reloj global, es difícil definir cuál operación `write` es la última
	- definiciones alternativas: un rango de **modelos de consistencia**
- La replicación de datos presenta problemas que no pueden ser resueltos eficientemente de una manera general
	- soluciones eficientes: hay que relajar la consistencia
	- qué inconsistencias se pueden tolerar: depende de la aplicación
- Tres ejes independientes para definir inconsistencias 
	- desviación en valores numéricos entre réplicas
	- desviación en desactualización entre réplicas
	- desviación con respecto a la ordenación de las actualizaciones
![[Pasted image 20231011112556.png]]
- Podríamos especificar reglas de consistencia:
	- e.g. que el *order deviation* no sea mayor a un cierto valor máximo
- Requiere que una réplica sepa cuánto se está desviando de las otras, bajo el supuesto de que comunicar esta información es menos costoso que mantener las réplicas sincronizadas
- Debemos tener protocolos y que los programadores deben especificar los requisitos de consistencia para sus aplicaciones:
	- muy difícil
	- por lo tanto, requerimos interfaces de programación simples y fáciles de entender
### Notación
![[Pasted image 20231011113113.png]]
## Consistencia secuencial
El resultado de cualquier ejecución es el mismo que si las operaciones de todos los procesos se ejecutasen en algún orden secuencial y las operaciones de cada proceso individual aparecen en esta secuencia en el orden especificado por su programa
- Cualquier intercalación válida de las operaciones es aceptable, pero todos los procesos ven la misma intercalación
- no se hace referencia al `write` más reciente
- un proceso "ve" los writes de los otros procesos solo a través de sus propios reads
![[Pasted image 20231011113915.png]]
![[Pasted image 20231011114017.png]]
![[Pasted image 20231011114608.png]]

## Consistencia causal
- Más débil que consistencia secuencial
- Los writes que están (potencialmente) causalmente relacionados debe ser vistos por todos los procesos en el mismo orden
	- si el evento $b$ es causado o influenciado por un evento anterior $a$, entonces todos deben ver que primero ocurre $a$ y luego ocurre $b$
- Las operaciones que no están relacionadas causalmente son concurrentes
	- los writes concurrentes pueden ser vistos en diferente orden por diferentes procesos
![[Pasted image 20231011115429.png]]

## Consistencia de entrada
- Asociamos locks (o variables de sincronización) con los datos, y usamos los locks bajo consistencia secuencial 
	- la obtención de un lock tiene éxito solo cuando todas las actualizaciones al dato asociado han sido completadas
	- el acceso exclusivo a un lock (que permite la ejecución de operaciones `read` y `write` a un solo proceso) tiene éxito solo si ningún otro proceso tiene acceso exclusivo o no exclusivo a ese lock
	- el acceso no exclusivo a un lock (que permite que varios procesos puedan leer el dato asociado) tiene éxito solo si cualquier acceso exclusivo previo ha sido completado, incluyendo las actualizaciones al dato
	![[Pasted image 20231011151054.png]]

## Sistemas MIMD
- ¿Cómo pueden combinarse múltiples CPUs independientes para formar sistemas más grandes?
	- MIMD (multiple instructions multiple data)
		- multiprocesadores
		- multicomputadores
- Existen desde hace décadas, pero su uso generalizado en todo el rango desde aplicaciones embedded hasta servidores de alto desempeño... y su modelo de programación (paralelismo a nivel de threads) ahora empleado para aplicaciones de propósito general son mas bien recientes
![[Pasted image 20231016110904.png]]
- En un sistema MIMD, las CPUs, que trabajan en distintas partes de una misma tarea, deben comunicarse para intercambiar información
	- multiprocesadores y multicomputadores se diferencias porque en los multiprocesadores existe una memoria compartida (y por ende, un único espacio de direcciones para toda la memoria)
	- ... mientras que los multicomputadores (en donde cada computador tiene su propio espacio de direcciones de memoria) deben enviar y recibir mensajes
	- esta diferencia impacta como son diseñados, construidos y programados
- Ahora nos vamos a enfocar en los multiprocesadores
![[Pasted image 20231019184916.png]]
- Los multiprocesadores están formados por muchos procesadores estrechamente acoplados:
		- su coordinación y uso es controlado por un único sistema operativo
		- comparten memoria -> el espacio de direcciones es copmartido
- Rango de tamaños:
		- varios cores o núcleos (e.g. 8) en un chip (multicore con memoria compartida centralizada) o multiprocesadores simétricos (SMP)
		- múltiples chips (e.g. 4-16) en que c/u es un multicore (e.g. 8 núcleos) con su propia memoria (memoria compartida distribuida, DSM)
- Dos clases de multiprocesadores, dependiendo del número de procesadores involucrados...
- ... que a su vez dicta la organización de memoria (que a su vez usamos para referirnos a cada clase)
- ... y a la estrategia de interconexión
		- multiprocesadores de memoria compartida centralizada, o multiprocesadores simétricos (SMP)
		- multiprocesadores de memoria compartida distribuida (DSM)
- En ambos casos, la comunicación entre threads tiene lugar a través del espacio de direcciones compartida (por esto, memoria compartida):
		- cualquier procesador puede hacer referencia a cualquier ubicación de memoria
- Desafíos del procesamiento paralelo
		- el paralelismo disponible en un mismo programa es limitado
		- alto costo de comunicación
			- 35-50 ciclos entre cores de un mismo chip
			- 100-500 ciclos entre cores de distintos chips
- El nivel de dificultad de estos desafíos depende tanto de la aplicación como de la arquitectura
		- se podría estar ejecutando tareas independientes que no se comunican
		- ... hasta programas genuinamente paralelos en que los threads deben comunicarse para completar las tareas
### Multiprocesador SPM o UMA
- Varios subsistemas procesador + caché comparten la misma memoria física (uno o más "bancos")
- ... y un nivel de caché en el multicore
- La propiedad arquitectónica clave es el _tiempo de acceso uniforme_ a toda la memoria desde cualquiera de los procesadores (UMA: uniform memory access)
	- utilizamos protocolos como MESI para la consistencia de las cachés
- En un chip multicore individual, la red de interconexión es simplemente el bus de memoria
![[Pasted image 20231016111856.png]]
- El uso de un único bus limita el tamaño de un multiprocesador UMA a (actualmente) unas 32 CPUs
- Para multiprocesadores con más de 100 CPUs (hoy incluso multiprocesadores de dos chips de más de 64 núcleos), abandonamos la idea de que todos los módulos de memoria tengan el mismo tiempo de acceso desde cualquier CPU
	- pasando a nonuniform memory access NUMA
- Todos los programas para multiprocesadores UMA corren sin cambios en multiprocesadores NUMA
	- pero el desempeño es peor a la misma velocidad de reloj
### Multiprocesador DSM o NUMA
- Un conjunto de chips multicore, cada uno con memoria y con I/O y conectado a una red de interconexión  (que conecta a todos los nodos entre sí)
- Cada núcleo comparte la totalidad de la memoria (único espacio de direcciones para todos los procesadores)
	- pero el acceso a los módulos de memoria locales, a través de un bus local, es mucho más rápido que el acceso a los módulos de memoria remotos a través de la red de interconexión
![[Pasted image 20231016112630.png]]
- La ausencia de una estructura de datos centralizada para seguir la pista de las cachés es tanto la ventaja principal de los esquemas de *snooping caches* como su principal desventaja al tratar de escalar:
	- e.g. un multiprocesador de 4 multicores de 4 núcleos cada uno capaz de manejar una referencia a memoria por ciclo de reloj a 4GHz
		- las aplicaciones podrían requerir hasta 170 GB/s de ancho de banda del bus
		- pero el máximo ancho de banda en el i7 con dos canales de memoria DDR4 es sólo 34 GB/s
- El desarrollo de los procesadores multicore ha obligado a ir hacia memoria distribuida para soportar las demandas de ancho de banda de los procesadores individuales
- Veamos primero el caso de multiprocesadores NUMA sin cachés
#### NC-NUMA
- Cuando la MMU recibe una solicitud de acceso a memoria, revisa a ver si la palabra requerida está en su memoria local
	- En caso afirmativo, se envía solicitud por el bus local
	- De lo contrario, la solicitud se envpia a través de la red de interconexión al componente (CPU+memoria) que tiene la palabra (y se demora mucho más en ser respondida que en el caso local)
- No hay cachés -> la coherencia en memoria está garantizada
	- cada palabra está en exactamente una localidad
		- por lo que, no hay peligro de copias obsoletas (no hay copias)
- Es muy importante cuál es la página está en cuál memoria
	- se requiere software especial para mover las páginas de una memoria a otra para maximizar el desempeño
- E.g, un proceso *page scanner* que corre cada unos pocos segundos examina las estadísticas de uso
	- si una página parece estar en el lugar equivocado, la página es invalidada, de modo que, la próxima referencia a ella produzca un _page fault_
	- cuando ocurre un _page fault_, se toma la decisión de dónde poner la página, posiblemente en otro módulo de memoria
	- para evitar _thrashing_, una página puesta en una memoria permanece allí por lo menos un determinado tiempo
- Ningún algoritmo particular de *page scanner* es mejor siempre
	- el mejor desempeño depende de la aplicación
- Debido a la ausencia de cachés, estos sistemas no escalan bien
#### CC-NUMA o DSM (sistemas de memoria compartida distribuida por hardware)
- Al tener cachés, estos sistemas también deben asegurar la coherencia de las cachés
- *snooping caches* + bus de sistema es técnicamente simple, pero, de nuevo, no escala bien -> requiere comunicación con todas las cachés en cada *cache miss* ya que no hay una estructura de datos centralizada que le siga la pista al estado de las cachés
- La solución actual es usar un directorio distribuido
	- una base de datos dividida entre todos los nodos que dice dónde está cada línea de la memoria y cuál es su estado (válida=1 no=0)
	- es consultado por cada instrucción que hace referencia a la memoria -> debe ser almacenado en hardware especializado extremadamente rápido
![[Pasted image 20231016114334.png]]
![[Pasted image 20231016114353.png]]
![[Pasted image 20231016114408.png]]
![[Pasted image 20231016114417.png]]
- Notas
	1. Vemos que, aún tratándose de un "multiprocesador de memoria compartida", hay mucho paso de mensajes por debajo (transparente para el programador)
	2. ¿Cómo podemos hacer que una misma línea de memoria pueda estar en varias cachés al mismo tiempo, como en el caso UMA?
		- Una posibilidad es que cada entrada del directorio tenga $k$ campos de 8 bits cada uno, permitiendo que cada línea de memoria pueda estar en $k$ cachés simultáneamente
		- Otra posibilidad es que cada entrada del directorio tenga un bitmap con un bit por cada nodo. En el ejemplo, esto significa entradas de 256 bits en vez de 9 (demasiado! ya que cada directorio tiene $2^{18}$ entradas, a lo mejor podemos relajar las condiciones de consistencia)

