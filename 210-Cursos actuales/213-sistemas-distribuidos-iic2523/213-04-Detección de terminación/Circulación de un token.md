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

Cuando `T[1]` recibe el token, si está de azul, entonces anuncia terminación y se detiene.