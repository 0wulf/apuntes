# Sistemas Distribuidos
Es difícil definir un sistema distribuido. Un sistema distribuido es una colección de entidades independientes que cooperan para resolver un problema.
* Uno sabe que está usando un sistema distribuido cuando la caída de un computador del que nunca ha escuchado hablar impide que hagas tu trabajo
Un sistema distribuido es una colección de procesadores en su mayoría autónomos que se comunican a través de una red de comunicaciones y que tienen las siguientes características:
* no hay un reloj físico común: 
	* introduce el elemento de la distribución
	* da origen a la asincronía inherente entre los procesadores 
* no hay memoria compartida:
	* se requiere del paso de mensajes para la comunicación
* hay separación geográfica:
	* no es necesario que estén conectados a través de una WAN. puede ser LAN
* hay autonomía y heterogeneidad:
	* procesadores débilmente acoplados
		* pueden tener diferentes velocidades y estar ejecutando diferentes OS
		* no son parte de un sistema dedicado
![[Pasted image 20230810110048.png]]

## Índice
[[213-01-Un Algoritmo Distribuido]]

## Temario
1. Arquitecturas: Arq. centralizadas, descentralizadas e híbridas; el rol del middleware
2. Procesos: Threads, virtualización, clientes, servidores, migración de código
3. Comunicación: Protocolos, RPS, comunicación orientada a mensajes, comunicación orientada a streaming, multicasting
5. Nombres: Nombres, identificadores y direcciones; nombres planos; nombres estructurados; nombres basados en atributos
6. Coordinación: Sincronización de relojes; relojes lógicos; exclusión mutua; posicionamiento de nodos; algoritmos de elección
7. Consistencia y replicación: Modelos centrados en datos; modelos centraos en el cliente; gestión de réplicas; protocolos de consistencia 
8. Tolerancia a fallas; seguridad

## Evaluaciones
* i1 miercoles 6 de septiembre 16,67%
* i2 lunes 30 de octubre 16.67%
* examen miércoles 6 de diciembre 33.33%
* ~4 tareas escritas en Go 33.33%
* Criterios de aprobación: promedio tareas>= 3.7 y (Ex+I1+i2)/3 >= 3.7