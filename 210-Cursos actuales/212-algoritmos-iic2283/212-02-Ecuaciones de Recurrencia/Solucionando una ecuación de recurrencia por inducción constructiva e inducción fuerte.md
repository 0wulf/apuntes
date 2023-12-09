Sea $T(n)$ definida como
![[Pasted image 20230816152957.png]]
Queremos demostrar que $T(n)\in{O(\log(n))}$
Vale decir, queremos demostrar que 
$$\exists{c}\in\mathbb{R}^+,\exists{n_0}\in\mathbb{n}\text{ tales que }T(n)\leq{c\cdot{\log(n)}},\forall{n\geq{n_0}}
$$
Inducción nos va a servir tanto para demostrar la propiedad como para determinar los valores adecuados para $c$ y $n_0$
Dado que $T(1)=b$ y $\log(1)=0$ no es posible encontrar un valor para $c$ tal que $T(1)\leq c\cdot\log(1)$
Dado que $T(2)=(b+d)$, si consideramos $c=(b+d)$ tenemos que $T(2)\leq c\cdot\log(2)$
Definimos entonces $c=(b+d)$ y $n_0=2$
Tenemos que demostrar lo siguiente
$$
\forall{n\geq{2}},T(n)\leq{c\cdot\log(n)}
$$
La inducción fuerte aparece en que debemos considerar todos los casos anteriores
* Tenemos $n_0$ como punto de partida
* $n_0$ es un caso base, pero pueden existir otros
* Dado $n>n_0$ tal que $n$ no es un caso base, suponemos que la propiedad se cumple para todo $n'\in\{n_0,...,n-1\}$

Queremos demostrar que $\forall{n\geq{2}},T(n)\leq{c\cdot\log(n)}$
- 2 es el punto de partida y el primer caso base
- También 3 es un caso base ya que $T(3)=T(1)+d$ donde para $T(1)$ no se cumple
- Para $n\geq 4$ tenemos que $T(n)=T(\lfloor{\frac{n}{2}}\rfloor)+d$ y $\lfloor{\frac{n}{2}}\rfloor\geq{2}$, por lo que resolvemos este caso de manera inductiva
	- Suponemos que la propiedad se cumple para todo $n'\in\{2,...,n-1\}$
![[Pasted image 20230816155227.png]]
![[Pasted image 20230816155235.png]]