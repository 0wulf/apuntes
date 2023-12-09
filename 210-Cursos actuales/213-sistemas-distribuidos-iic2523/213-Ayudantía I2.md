Relojes Lógicos
Explicar por qué es importante que los relojes lógicos se encuentren en el middleware
- al tratarse de canales aseguran que los mensajes se contabilicen en el reloj
- el middleware ve todos los mensajes

En multicast totalmente ordenado los mensajes de la cola los ordenamos por timestamps de los relojes lógicos
Los ACK son importantes para asegurarnos que todos han recibido el mensaje que enviamos. Una vez todos han hecho ACK, sabemos que todos tienen la misma información, entonces ahí puedo sacar el mensaje de la cola.
Cuando esté libre y quiero ejecutar una operación, necesito saber que todos tienen la misma información para que to

Es super importante saber cómo funcionan los relojes lógicos
Sirve harto ver las ayudantías y rellenar las tablas de cómo va cambiando el reloj

¿Qué representa cada valor en un reloj vectorial?

Consenso


Coordinación
como mandar la topología completa una vez determinada? (en lamport)