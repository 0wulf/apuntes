# Los mensajes asíncronos no son siempre la mejor opción
- Los mensajes asíncronos son apropiados para programar (procesos de tipo) filtros y pares interactuantes -> la información fluye por los canales en una dirección:
	- e.g. los procesos en el algoritmo de Ricart-Argawala.
- pero no son apropiados (los mensajes asíncronos) para (procesos de tipo) cliente-servidor:
	- el flujo de información en ambos sentidos entre unos y otros tiene que programarse con dos intercambios de mensajes usando dos canales diferentes.
	- cada cliente necesita un canal de respuesta diferente.
- (Los mensajes asíncronos) no ofrecen transparencia de acceso.

# RPC es mejor para programar interacciones cliente-servidor
![[Pasted image 20230821111204.png]]

# Modelo RPC
- Programa está compuesto por módulos. E.g. un módulo cliente y un módulo servidor.
- Un módulo contiene procesos y procedimientos:
	- Los procesos pueden compartir variables y llamar a los procedimientos
	- Un proceso en un módulo puede comunicarse con procesos en otro módulo solo llamando a los procedimientos exportados por el segundo módulo

## Forma de un módulo
```
module <name>:
encabezados de operaciones exportadas
declaraciones de variables
código de inicialización
procedimientos para operaciones exportadas
procedimientos y procesos locales
```
- Los procesos locales corren en el background
- En RPC se declara un procedimiento para cada operación y se crea un proceso para cada manejar cada llamada al procedimiento.
- Para distinguirlos de los procesos que resultan de las llamadas a las operaciones exportadas

# Implementación de una llamada remota intermódulos
1. Un nuevo proceso -un servidor- atiende la llamada.
2. Los parámetros son pasados como mensajes entre el proceso que llama este nuevo proceso servidor
3. El proceso que llamó se suspende mientras el servidor ejecuta el procedimiento que implementa la operación
4. Cuando el servidor termina la ejecución de la operación, envía los parámetros del resultado y el valor de retorno al proceso que llamó, y termina su ejecución
5. Después de recibir los resultados, se retoma el proceso que llamó

## Ejemplos
### Un módulo servidor de tiempo
![[Pasted image 20230827184406.png]]
![[Pasted image 20230827184414.png]]
![[Pasted image 20230827184422.png]]

### Un sistema de archivos distribuido
![[Pasted image 20230827184456.png]]
![[Pasted image 20230827184507.png]]
![[Pasted image 20230827184515.png]]
![[Pasted image 20230827184544.png]]
![[Pasted image 20230827184554.png]]

# Operación transparente de RPC
Supongamos que un programa tiene acceso a una base de datos que permite agregar (`append`) datos a una lista, y luego devuelve una referencia a la lista actualizada `newlist <- append(data,dbList)`
- En un sistema tradicional, `append` es tomada desde una librería por el `linker` e insertado en el programa objeto.
- Así luego es llamada de la manera habitual -> colocando sus parámetros en el stack.
- El programador no conoce los detalles de implementación de `append`, que es como debería ser.

En RPC, cuando `append` es un procedimiento remoto,  se utiliza un `stub cliente` que es llamado usando la secuencia de llamada normal, pero que no ejecuta la operación `append`, si no que
- empaca los parámetros en un mensaje y pide que el mensaje sea enviado al servidor.
- luego de llamar `send` el `stub` llama a `receive` y se bloquea hasta que llegue la respuesta.

![[Pasted image 20230827185533.png]]

Cuando el mensaje llega al servidor, el sistema operativo local pasa un mensaje a un `stub servidor`:
- Código que transforma solicitudes que llegan por la red en llamadas a procedimientos locales (típicamente, el `stub` ha llamado a `receive` y está bloqueado esperando a que lleguen mensajes)

El `stub` desempaca los parámetros y llama al procedimiento del servidor de la manera usual:
- Para el servidor, es como si estuviera siendo llamado directamente por el cliente: los parámetros y dirección de retorno están en el stack.

El servidor hace su trabajo y luego devuelve los resultados al `stub`.

El `stub` empaca el resultado en un mensaje y llama `send` para enviarlo de vuelta al cliente:
- y luego llama a `receive` para esperar a la próxima solicitud.

Cuando el mensaje llega al cliente, el sistema operativo local lo pasa al `stub` cliente a través de la operación `receive` que fue llamada antes y lo tenía bloqueado. 

El cliente es desbloqueado y el `stub` inspecciona el mensaje, desempaca el resultado, lo pasa al programa que hizo la llamada y retorna de la forma usual.

En este punto, el programa cliente que hizo la llamada sabe que agregó datos a la lista -y no sabe nada más:
- no tiene idea de que el trabajo fue hecho remotamente en otro computador
- desde su punto de vista, a los servicios remotos se tiene acceso haciendo llamadas a procedimientos locales y no haciendo `send` y `receive`

# Paso de parámetros en RPC
- El stub cliente toma los parámetros, los empaca en un mensaje (parameter marshaling) y los envía al stub servidor.
- El servidor recibe una serie de bytes, además, la ubicación en memoria puede diferir entre las arquitecturas de los computadores, además de tener problemas con la endianess.
- Transformación a formatos neutrales.