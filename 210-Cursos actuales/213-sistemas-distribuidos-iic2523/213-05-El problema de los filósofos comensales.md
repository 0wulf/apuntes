Cinco filósofos se sientan alrededor de una mesa circular para comer. Hay cinco tenedores, uno entre cada dos filósofos vecinos Para comer, un filósofo necesita ambos tenedores: el que está a su izquierda y el que está a su derecha, pero debe tomarlos uno a la vez. Cuando un filósofo no está comiendo, está pensando.
```
process phil[i=0..4]:
	while (true):
		pensar
		tomar tenedores
		comer
		soltar tenedores
```
---
## En memoria compartida el problema puede resolverse usando semáforos
- Representamos los tenedores por un arreglo de semáforos binarios, inicializados en 1:
	- obtener un tenedor consiste en ejecutar una operación `P` sobre el semáforo correspondiente
	- soltar un tenedor consiste en ejecutar una operación `V`
- Los procesos son esencialmente idénticos:
	- es natural que todos ejecuten las mismas acciones
	- e.g. todos tratad te tomar primero su tenedor izquierdo y luego su tenedor derecho.
- Para que no haya deadlocks aseguremos que no ocurra espera circular
	- que los procesos no sean simétricos
```
sem[] fork <- {1,1,1,1,1}

process phil[i=1..4]:
	while (true):
		pensar
		P(fork[i]); P(fork[i+1])
		comer
		V(fork[i]); V(fork[i+1])
		
process phil[i=5]:
	while (true):
		pensar
		P(fork[1]); P(fork[5])
		comer
		V(fork[1]); V(fork[5])

```
---
## Solución descentralizada (e higiénica)
- Cada filósofo es atendido por un mozo (proceso `waiter`) a través de tres canales: `hungry`, `eat`, `done`
- Es otro ejemplo de algoritmos basados en tokens
	- los tokens son los cinco tenedores
	- cada token está en poder de uno de los mozos o está en tránsito entre ellos
- Los mozos están conectados entre ellos como si estuvieran sentados alrededor de una mesa redonda, a través de cuatro canales: `needL`, `needR`, `passL`, `passR`.
```
process phil[i]:
	while (true):
		send hungry()
		receive eat()
		eat
		send done()
		think
```
---
### Cuando un filósofo quiere comer, le pide al mozo que obtenga los tenedores
- El filósofo envía al mozo un mensaje (vacío) por el canal `hungry`
- Si el mozo no tiene ambos tenedores, entonces se los pide a sus vecinos:
	- envía mensajes por los canales `needL` y/o `needR` según corresponda
	- luego, el mozo retiene los tenedores mientras el filósofo come
- Hay que manejar los tenedores de manera de no incurrir en deadlock:
	- un mozo que necesita ambos tenedores no pueda obtenerlos.
- Cuando un filósofo no está comiendo, el mozo debiera estar dispuesto a entregar los tenedores:
	- pero hay que evitar pasar los tenedores de ida y de vuelta sin que sean usados
- La solución también debe ser justa
---
### La clave: manejar los tenedores de manera de no incurrir en deadlock
- Las variables `haveL`, `haveR`, `dirtyL`, `dirtyR` registran el estado de los tenedores
- Un mozo entrega un tenedor usado, pero no uno que se acaba de obtener:
	- cuando un filósofo empieza a comer, el mozo marca ambos tenedores como "sucios" -- `dirtyL <- true; dirtyR <- true` 
	- cuando otro mozo quiere un tenedor, si el tenedor está sucio y no está siendo usado, el mozo lo "limpia" y lo entrega -- `dirtyR <- false; send passR()`
- Inicialmente, los tenedores están sucios y son distribuidos asimétricamente:
	- uno de los mozos tiene ambos tenedores, otros tres tienen solo uno y el quinto no tiene ninguno.
![[Pasted image 20230831144336.png]]