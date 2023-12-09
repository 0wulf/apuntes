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