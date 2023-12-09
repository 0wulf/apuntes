# Instantáneas Globales
- Una **instantánea global** es un registro consistente de los estados de todos los nodos y canales de un sistema distribuido.
- Para que una instantánea sea **consistente**, cada mensaje debe estar exactamente en uno de estos dos estados
	- enviado y en tránsito en un canal
	- recibido
- **No se requiere** que toda la información de la instantánea sea recolectada en un instante particular:
	- Solo que la recolección de la información en el tiempo sea tal que se logre la consistencia
---
## El estado de los nodos y los canales
- Estado de un nodo:
	- Los valores de sus variables internas 
	- junto con las secuencias de mensajes que han sido enviados y recibidos a través de todos los canales de input y de output del nodo
- Estado de un canal:
	- La secuencia de mensajes que han sido enviados a través del canal pero que aun no han sido recibidos
---
## Consideraremos dos nodos y los mensajes enviados por el nodo 1 al nodo 2
![[Pasted image 20230831131555.png]]
- Supongamos que ambos nodos reciben la orden de tomar una instantánea.
- Básicamente, la instantánea debiera indicar lo siguiente:
	- `nodo1` ha enviado 14 mensajes --pero no sabe cuáles han sido recibidos
	- `nodo2` ha recibido 9 mensajes --pero no sabe cuáles están aun en el canal
	- los mensajes `m10` a `m14` están aun en el canal.
---
### Enviamos un mensaje marker, Separa mensajes enviados antes y después de tomar la instantánea
![[Pasted image 20230831132240.png]]
- Supongamos que el `nodo1` recibió la orden de tomar la instantánea después de enviar el mensaje `m11`, pero antes de enviar el `m12`.
- `nodo1` registra su estado en cuanto recibe la orden:
	- su estado incluye los mensajes enviados `m1` hasta `m11`.
- nodo 2 también registra su estado:
	- su estado incluye los mensajes recibidos hasta el momento:  `m1 a m9`
- Los mensajes `m10` y `m11` son parte del estado del canal.
---
### Dos consideraciones adicionales
- Los nodos receptores son los responsables de registrar el estado del canal correspondiente:
	- mensajes recibidor por el nodo después de que el nodo registró su estado, pro antes de que el nodo recibiera el marker.
- Un nodo puede recibir un marker antes de que se le haya ordenado tomar una instantánea:
	- el canal será considerado vacío, ya que todos los mensajes recibidos antes del marker se consideran como parte del estado del nodo receptor.
---
## Características generales del algoritmo
- Suponemos que existe un nodo (de entorno) que inicia el algoritmo:
```
for (todos mis canales c de output):
	send c(marker, myID)
```
- Agregamos acciones al `send` y al `receive` del algoritmo "normal"
	- registramos el último mensaje enviado a ese destino
	- o el último mensaje recibido desde ese origen
- Agregamos un proceso para la recepción del primer marker
- Agregamos un proceso que registra el estado una vez que ha recibido markers por todos sus canales de input.
---
### Cuando un nodo recibe el primer marker
1. Registra el estado de sus canales de output
	- el número del último mensaje enviado a través de cada canal de output
2. Registra el estado de sus canales de input
	- para el canal de input por el cual se recibe el primer marker: todos los mensajes recibidos antes del marker
	- para todos los otros canales de input: la diferencia entre el último mensaje recibido antes de que el nodo registrara su estado y el último mensaje recibido antes de recibir el marker por este canal
3. Envía el marker por cada uno de sus canales de output
	- antes de enviar cualquier otro mensaje
![[Pasted image 20230831133130.png]]
---
### Cuando un nodo ha recibido todos los markers, el nodo registra su estado
- El arreglo `stateatRecord`:
	- el último mensaje enviado por cada canal de output
- El arreglo `messageatRecord`:
	- el último mensaje recibido por cada canal de input
- Para cada canal de input `c`:
	- los mensajes desde `messageatRecord[c]+1` hasta `messageatMarker[c]`
