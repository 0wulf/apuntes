## En general, la estructura de la comunicación forma un grafo direccional arbitrario
Los nodos son procesos y las aristas las rutas de comunicación:
- Hay una arista de un proceso a otro proceso si el primero envía a un canal desde el cual el segundo recibe

Supongamos que el grafo es completo:
- hay una arista desde cada proceso a cada uno de los otros procesos
- cada proceso `T[i]` recibe a través de su canal privado de input `ch[i]`
- cualquier proceso puede enviar mensajes a `ch[i]`
---
## El algoritmo para un anillo no funciona en general (e.g. un grafo completo de 3 procesos)
- Los procesos pasan el token solo de `T[1]` a `T[2]` a `T[3]` y de vuelta a `T[1]`
- Supongamos que `T[1]` tiene el token, se vuelve desocupado e inicia el algoritmo pasando el token a `T[2]`.
- Cuando `T[2]` queda desocupado pasa el token a `T[3]`, pero justo `T[3]` le envió un mensaje a `T[2]` antes de recibir el token
- Cuando el token vuelva a `T[1]` este no puede asumir que la computación ha terminado, aunque haya permanecido desocupado.
---
## Detectar terminación en general es más difícil: los mensajes pueden llegar por cualquier arista
La clave del algoritmo anterior es que toda la comunicación viaja alrededor del anillo:
- y por lo tanto el token "hace avanzar" los mensajes regulares
- en particular, el token viaja por cada arista del anillo

Podemos extender el algoritmo anterior si aseguramos que el token viaje por cada arista del grafo:
- aunque visite cada proceso muchas veces
- si cada proceso ha permanecido desde que vio el token por primera vez
- entonces podemos concluir que la computación terminó
---
## El algoritmo para un grafo completo- Cada proceso está pintado de rojo o azul, con todos los procesos inicialmente rojos.
- Cuando un proceso recibe un mensaje regular, se pinta de rojo.
- Cuando un proceso recibe el token --está bloqueado esperando a recibir el próximo mensaje:
	- se pinta de azul (si no está azul)
	- y pasa el token
- Todo grafo direccional completo contiene un ciclo (ciclo de Euler) que incluye a cada arista (exactamente una vez):
	- sea $C$ el ciclo y $nc$ su longitud
- Cada proceso sabe el orden de sus aristas de salida en $C$
	- al recibir el token por una arista, el proceso lo envía por la próxima --asegurando que el token viaje por cada arista
- El token tiene ahora un valor --un número entero:
	- el número de veces consecutivas que ha pasado por procesos desocupados
	- y por lo tanto, el número de canales que podrían estar vacíos.
- El token está inicialmente en cualquier proceso y vale 0.
- Cuando ese proceso se desocupa por primera vez:
	- se pinta de azul
	- y pasa el token por su primera arista en $C$
- Al recibir el token:
	- si el proceso está rojo, se pinta de azul, pone el valor del token en 0 y lo envía --es decir, reinicia el algoritmo.
	- si está de azul, incrementa el valor del token y lo pasa.

```
// La acción de T[i] al recibir un mensaje regular
color[i] <- rojo

// y las acciones de T[i] al recibir el token
if (token == nc):
	anunciar terminación y detenerse
if (color[i] == rojo):
	color[i] <- azul
	token <- 0
else:
	token <- token+1
j <- índice de canal próxima arista en C
send ch[j](token)
```