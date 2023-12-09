## Un objetivo de sistemas distribuidos es mejorar la confiabilidad mediante la replicación
- Dos propiedades de un sistema confiable
	- Inocuo ante fallas: si las fallas no producen daños al sistema o a sus usuarios
	- Tolerante a fallas: si continua cumpliendo con sus exigencias aun si hay fallas
![[Pasted image 20231008124843.png]]

---
## Cómo lograr consenso en un sistema distribuido (sin recurrir a una entidad central confiable)
- Cada nodo elige un valor inicial
	- y requerimos que todos los nodos se pongan de acuerdo en uno de esos valores
- Si no hay fallas en el sistema, entonces lograr consenso es casi trivial
- Consideramos dos tipos de fallas:
	- Fallas simples o por caída: un nodo simplemente deja de enviar mensajes
	- Fallas bizantinas: un nodo puede enviar mensajes arbitrarios
---
# El problema de los Generales Bizantinos
- Un grupo de ejércitos bizantinos rodea una ciudad enemiga
- El balance de fuerzas es tal que si todos los ejércitos atacan juntos, entonces pueden capturar la ciudad. De lo contrario, deben retirarse para evitar la derrota. A menor cantidad de ejércitos atacando menores chances de capturar la ciudad.
- Los generales (nodos) de los ejércitos tienen mensajeros (canales) confiables que entregan correctamente cualquier mensaje enviado de un general a otro
- Pero algunos de los generales pueden ser traidores (nodos que fallan) empeñados en conseguir la derrota de los ejércitos bizantinos (peor caso).
- Debemos diseñar un algoritmo de modo que todos los generales leales lleguen a un consenso: atacar o retirarse.
### La decisión final debiera ser casi la misma que un voto de mayoría de las decisiones iniciales
- Así el algoritmo será aplicable y no producirá una solución trivial (e.g. siempre atacar, siempre retirarse, etc.)
#### E.g. Supongamos 10 generales, dos de los cuales son traidores. Suponga que la votación de los generales leales es
- 6 a 2. Entonces los traidores podrían hacer creer a algunos generales que la votación fue 8 a 2 y a otros les pueden hacer creer que fue 6 a 4. Como en ambos casos el voto de mayoría sigue siendo atacar en ambos casos, entonces el algoritmo debe asegurar que esta será la decisión alcanzada
- 4 a 4. Entonces los traidores pueden afectar el resultado final de una votación por mayoría. Si los leales llegan a 4 a 4 seguramente da lo mismo cual es el resultado. Cuando la proporción de traidores aumenta, aumenta lo que estos pueden afectar
#### Consideramos fallas simples y bizantinas
Fallas simples (caídas de nodos):
- Un nodo (traidor) simplemente deja de enviar mensajes en cualquier momento durante la ejecución del algoritmo
- Suponemos que sabemos qué nodo falló, e.g., con un timeout.

Fallas bizantinas:
- Un nodo (traidor) puede enviar mensajes arbitrarios, no solo los requeridos por el algoritmo
- Son más difíciles de manejar que las fallas simples
- Hay que considerar traidores que envían exactamente los mensajes que hacen fracasar al algoritmo
---
## Algoritmo simple de una rueda
En este algoritmo y en los que siguen:
- Si la votación queda empatada, entonces la decisión es retirarse
- Los algoritmos corren concurrentemente con la computación subyacente, cuando hay necesidad de llegar a consenso con respecto al valor de algún dato. Los conjuntos de mensajes usados son disjuntos
- Cada nodo envía un conjunto de mensajes y luego recibe *replies* a esos mensajes
![[Pasted image 20231008131032.png]]
- Pongámonos ahora en el caso de 2 leales y 1 traidor
![[Pasted image 20231008131115.png]]
- Aprovechando que hay generales leales, Leo debiera dar más peso al plan de Zoe que al de Basil
- En un sistema distribuido, un nodo puede no saber (directamente) quienes son los traidores
	- pero lo que importa es asegurar que los traidores no impidan que los generales leales lleguen a consenso
---
## Algoritmo de dos ruedas de los generales bizantinos
![[Pasted image 20231008131401.png]]
En el mismo escenario anterior pero con este algoritmo
![[Pasted image 20231008131535.png]]
Ahora otro escenario donde
- Basil envía todos sus mensajes de la primera rueda y uno de la segunda rueda a Leo antes de fallar
- Hay solo un mensaje que no es enviado: el segundo mensaje de Basil a Zoe, sobre Leo
![[Pasted image 20231008131658.png]]
El algoritmo es correcto para fallas simples con tres generales, dos leales y uno traidor
![[Pasted image 20231008131816.png]]
Si incluimos fallas bizantinas, estos algoritmos no logran consenso
- En una rueda tampoco funciona para fallas simples
### Consideremos ahora cuatro generales: tres leales y un traidor
- En la primera votación, para decidir qué eligió cada uno de los otros generales, cada general recibe dos informes leales y uno de un traidor
	- Los generales leales llegarán a acuerdo
- El traidor no puede evitar que los generales leales lleguen a consenso:
	- aunque podría influir su decisión
- Si los generales leales han elegido el mismo plan, entonces la decisión final será ese plan
	- independiente de las acciones del traidor
![[Pasted image 20231008132310.png]]
![[Pasted image 20231008132400.png]]
### Es clave entender que esto ocurre por que dos generales leales (50%) llegan a la misma conclusión sobre el otro general leal y sobre el general traidor
- Consideremos un general leal Leo
	- El plan que Leo elige, A, lo transmite correctamente a los otros generales
	- Las otras generales leales se reportan correctamente entre ellas esta elección de leo
	- en cambio, Basil lo reporta arbitrariamente como A o como R
- Las generales leales Zoe y Theo reciben dos reportes de que Leo eligió A
	- por lo tanto, los mensajes de Basil no influyen
- Si Basil envía mensajes de primera rueda con los planes arbitrarios X Y Z
	- los tres generales leales recibirán exactamente un mensaje X uno Y y uno Z 
	- y todos llegarán a la misma conclusión sobre Basil
---
## El algoritmo puede ser extendido a $n$ generales
- Por cada traidor adicional, hay que enviar una vuelta adicional de mensajes:
	- e.g. en una tercera rueda, Leo enviaría a Theo lo que Basil le dijo sobre Zoe y lo que Zoe le dijo sobre Basil
	- Además envía mensajes a Basil y Zoe
- El número de generales debe ser $n\geq 3t+1$ donde $t$ es el número de traidores
	- En la primera vuelta cada general envía $n-1$ mensajes
	- En la segunda vuelta cada general envía $(n-1)(n-2)$
	- En la tercera vuelta cada general envía $(n-2)(n-3)$
$$n[(n-1)+\sum\limits_{k=1}^{t}{(n-k)(n-k-1)}]$$
- Así, el problema es que el número de mensajes crece rápidamente, pasando de 36 mensajes para 4 generales con un traidor, a más de 5400 para 13 generales con 4 traidores
---
## Volvamos al caso en que sólo hay fallas simples
- An $f$-resilient consensus algorithm for simple failures
- Suponemos que la falla de un nodo (que simplemente deja de transmitir) es detectable por los otros nodos
![[Pasted image 20231008134124.png]]

Algoritmo de inundación para fallas simples
- Así, si solo hay fallas simples, un algoritmo eficiente es que cada general envíe una y otra vez el conjunto de planes que ha recibido
- Basta que uno de estos mensajes de un general leal llegue a todos los otros generales leales
	- Cuando un general leal ha determinado el plan de otro general leal, retiene esa información
	- si hay $t+1$ ruedas de envío/recepción de mensajes y a lo más $t$ traidores, debe haber al menos una rueda en la que ningún nodo falle para que todos los nodos activos hasta el momento envían y reciben correctamente los planes
![[Pasted image 20231008134441.png]]
#### E.g. cuatro generales: dos leales y dos traidores
Supongamos que Leo elige A
- Primera rueda: Leo envía este plan a los otros tres generales
- Segunda rueda: Basil y Theo envían el plan de Leo a Zoe
- Tercera rueda: El plan de Leo está almacenado en las variables plan de Basil y Theo, quienes se lo envían nuevamente a Zoe
¿Es posible que a lo más dos entre Leo, Basil y Theo, dejen de transmitir y Zoe no pueda determinar el plan de Leo?
- Supongamos que Leo envía al menos un mensaje
	- si fue a Zoe, entonces Zoe conoce el plan de Leo
- Supongamos que el mensaje de Leo fue a Basil
	- si en la segunda rueda Basil envía un mensaje a Zoe entonces Zoe conoce el plan de Leo
- ¿Qué pasa si Basil envía el mensaje de Theo y luego falla antes de enviarle el mensaje a Zoe?
	- ya tenemos a ambos traidores: Leo y Basil
	- Theo es leal y le envía el plan de Leo a Zoe
---
## El algoritmo del Rey
- Queremos disminuir el número de mensajes que se pasan
- Soporta fallas bizantinas
- Usa menos mensajes que los generales bizantinos pero con un *tradeoff* de que el número $n$ de generales debe ser  $n\geq4t+1$ con $t$ traidores
	- si hay 4 generales leales y 1 traidor y la votación es 4-0 o 3-1 entre los generales leales ocurre que el traidor no puede influir en el resultado.
- En cada rueda un general tiene un status especial (rey) y su voto es más importante que el de los otros generales
	- la identidad del rey no es conocida por los otros generales
	- cada nodo sabe si es o no el rey en una rueda particular
	- el rey también puede ser traidor
- Es necesario que si dos generales asumen el rol de rey uno después de otro, al menos uno de ellos debe ser leal
- Cuando un general leal es rey, hace que los otros generales lleguen a consenso
	- si es el segundo rey (el de la segunda rueda) la votación será de acuerdo a ese consenso
	- si es el primer rey, los generales leales tendrán una mayoría abrumadora a favor del consenso, tal que si el segundo rey es traidor entonces no puede hacer que los generales leales cambien sus planes
- La elección del rey es decidida por un algoritmo arbitrario pero fijo ejecutado por todos los generales
	- e.g. por orden alfabético
- El algoritmo ejecuta $t+1$ ruedas: cada una tiene dos fases
	- Inicialmente, cada general elige un plan
	- En la primera fase, cada general envía su plan a cada uno de los otros generales y luego recibe los planes de los otros generales
		- cada general entonces almacena el voto de mayoría y el número de votos correspondientes
	- En la segunda fase, solo el rey de la rueda envía su plan a los otros generales
		- cuando un general recibe el plan del rey, mira su número de votos de mayoría
			- si es abrumador ($>n/2+t$) entonces ignora el plan del rey
			- de lo contrario cambia su plan al plan del rey
### E.g. 5 generales: 4 leales 1 traidor
- Supongamos que inicialmente Basil y Theo eligen A y Leo y Zoe eligen R
- Supongamos que en la primera rueda Michael, traidor, envía A a dos generales y R a los otros dos
- Al final de la primera fase, 
	- Basil y Zoe calcularán una mayoría de 3 votos (no abrumadora) a favor de R
	- Theo y Leo calcularán una mayoría de 3 votos a favor de A
- Supongamos que la reina de la primera rueda es Zoe, leal
- En la segunda fase Zoe envía R a todos los generales
	- y como ninguno había calculado un voto de mayoría abrumador, entonces todos cambian sus planes al de Zoe: R
- En la primera fase de la segunda rueda todos los generales leales envían R a todos los otros generales leales
- Así, al final de la primera fase, todos los generales leales calculan una mayoría de al menos 4 votos (abrumadora) a favor de R
- Por lo tanto, independiente de si el rey de la segunda vuelta es traidor, el plan enviado será ignorado
	- y todos los generales leales logran consenso: R
#### Supongamos ahora que el rey de la primera rueda es Michael, traidor
- Como al final de la primera fase de la primera rueda las votaciones de mayoría no eran abrumadoras, en la segunda fase todos los generales leales cambian sus planes al plan enviado por Michael
	- R a Basil y Zoe
	- A a Theo y Leo
- En la primera fase de la segunda rueda los generales intercambian estos planes y recalculan las votaciones
	- en todos los casos, las votaciones son 3-2, es decir, no son abrumadoras
	- por lo que, el plan que envíe subsecuentemente el rey de la segunda rueda (que debe ser leal por supuesto) será el plan adoptado por los generales leales
#### Corrección del algoritmo del rey: 5 generales uno de ellos traidor
- Si un rey es leal, entonces los planes de cada general son iguales para todos los generales leales al terminar cada rueda:
	- se demuestra caso a caso, según los planes de cada general al inicio de la rueda correspondiente (4-0, 3-1 o 2-2)
- De aquí se deduce que si el segundo rey es leal, entonces el algoritmo del rey logra consenso 
- También se deduce que el primer rey es leal, entonces los planes de cada general serán iguales al finalizar la primera rueda (y al comenzar la segunda)
	- por lo tanto, todos los generales leales van a calcular la misma mayoría abrumadora al final de la primera fase de la segunda rueda
	- y el plan enviado subsecuentemente por el rey traidor será ignorado
---
# Material adicional
1. [Part 2: Fault-Tolerance - Distributed Systems 2012 ETH Zurich](https://disco.ethz.ch/courses/hs12/distsys/lecture/chapter01Consensus_4.pdf)
2. [Lección 12: Algoritmos de Consenso - Programación de Sistemas Concurrentes y Distribuidos Universidad de Zaragoza](https://webdiis.unizar.es/asignaturas/pscd/lib/exe/fetch.php?media=contenidos:leccion12.pdf)