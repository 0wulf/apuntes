# Algoritmo para detectar terminación basado en un árbol de cobertura
- $n$ procesos son los nodos de un grafo no direccional
	- cuyas aristas representan los canales de comunicación
- El algoritmo emplea un árbol de cobertura fijo (un subconjunto de aristas del grafo):
	- el proceso `T[1]` es la raíz, es responsable de detectar terminación.
- `T[1]` se comunica con los otros procesos para determinar sus estados:
	- los mensajes empleados para esto los llamamos tokens.
# Una versión simple... pero no segura
- Todos los nodos hojas se reportan a sus padres, si han terminado
- Similarmente, otros nodos se reportan a sus padres cuando han terminado sus ejecuciones y todos sus hijos han terminado.
- La raíz concluye que ha ocurrido terminación si ella misma ha terminado --quedó desocupada-- y todos sus hijos han terminado.
- Sin embargo:
	- un proceso puede recibir un mensaje regular de otro proceso que no está en su subárbol
	- después de que el primer proceso le ha enviado un token a su padre
	- y puede volverse activo nuevamente.
# Una versión segura basada en colorear tokens y procesos
- Todos los tokens en las hojas son inicialmente blancos
- Si un proceso ha enviado un mensaje regular a otro, al terminar envía un token gris a su padre
	- de lo contrario, envía un token blanco.
- El padre, al recibir el token gris, sabe que su hijo ha enviado un mensaje a otro proceso
	- y cuando el padre a su vez termina, envía un token gris a su padre
- Finalmente, la raíz sabe que ha habido envío de mensajes cuando recibe un token gris de alguno de sus hijos
	- y pide a todos los nodos reiniciar el algoritmo de terminación.