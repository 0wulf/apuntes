El algoritmo ejecuta concurrentemente con la computación llevada a cabo en cada nodo:
- Especifica sentencias adicionales que deben ser ejecutadas como parte del procesamiento de los mensajes regulares de la computación
- Supone que por cada arista en el grafo del nodo $i$ al nodo $j$, hay una **arista inversa** que transmite un mensaje especial llamado una **señal** de $j$ a $i$.
- Supone que todos los nodos, excepto el nodo de entorno, están inicialmente inactivos, solo esperando a recibir mensajes
![[Pasted image 20230904145848.png]]
---
# 2
La computación (general, no el algoritmo de detección de terminación) se inicia cuando el nodo de entorno envía mensajes por sus aristas de salida:
- Cuando un nodo recibe su primer mensaje, inicia su computación
- más adelante, la computación en cada nodo termina y el nodo no envía más mensajes...
	- aunque si recibe otro mensaje puede ser ejecutado
- en todo momento, un nodo puede recibir, procesar y enviar señales
---
## Versión preliminar
Por cada mensaje recibido por un nodo... éste debe enviar una señal por la correspondiente arista inversa:
- la diferencia entre el número de mensajes recibidos por el nodo $i$ a través de la arista $e$ y el número de señales enviadas a través de la arista inversa correspondiente $inDeficit_i[e]$
- la diferencia entre el número de mensajes enviados por el nodo $i$ (por todas sus aristas de salida) y el número de señales recibidas es $outDeficit_i$
- cuando un nodo termina, no envía más mensajes, pero sigue enviando señales mientras $inDeficit[e]$ no sea 0 para todas sus aristas de entrada

Cuando $outDeficit_{env}=0$, el algoritmo anuncia terminación.

---
## Cambios en el código de cada nodo
Por cada `send` de un mensaje regular, ejecuta adicionalmente
- $outDeficit$<-$outDeficit+1$

Por cada `receive` de un mensaje regular a través de la arista $e$, ejecuta adicionalmente
- $inDeficit[e]$<-$inDeficit[e]+1$
- $inDeficit$<-$inDeficit+1$

Además, hay un proceso adicional en cada nodo que recibe señales a través de las aristas invertidas $e'$:
- `receive[e'](...)`
- `outDeficit` <- `outDeficit-1`

Finalmente, hay un proceso adicional en cada nodo que envía señales:
```
when inDeficit > 1 or (inDeficit==1 and irTerminated() and outDeficit==0):
	e <- una arista tal que inDeficit[e]!=0
	send[e'](...)
	inDeficit[e] <- inDeficit[e] - 1
	inDeficit <- inDeficit - 1
```

Este proceso puede enviar una señal si el `inDeficit` no es 0
- la última señal la envía cuando la computación ha terminado y el `outDeficit` es 0
... y supone que cada nodo puede decidir si su computación local ha terminado llamando a `isTerminated()`

---
## ¿Qué hace en nodo de entorno?
Inicia la computación, enviando mensajes por todas sus aristas de salida
- por cada mensaje enviado, incrementa su `outDeficit`

Luego, espera hasta que su `outDeficit` sea 0:
- entonces, anuncia su terminación

También tiene el proceso adicional que recibe señales (y decrementa el `outDeficit`).
![[Pasted image 20230904151736.png]]