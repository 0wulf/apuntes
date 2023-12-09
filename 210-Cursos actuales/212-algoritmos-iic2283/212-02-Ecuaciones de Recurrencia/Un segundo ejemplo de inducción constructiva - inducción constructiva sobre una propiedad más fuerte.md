Considere la siguiente ecuación de recurrencia:
![[Pasted image 20230821145247.png]]
Queremos determinar una función $f(n)$ para la cual se tiene que $T(n)\in O(f(n))$
Dada la forma de la ecuación de recurrencia, podríamos intentar primero con $f(n)=n!$
Tenemos entonces que determinar $c\in\mathbb{R}^{+}$ y $n_0\in\mathbb{N}$ tales que $T(n)\leq{c\cdot n!}$ para todo $n\geq n_0$
Suponga que la propiedad se cumple para $n$:
$$T(n)\leq c\cdot n!$$
Tenemos que
![[Pasted image 20230821145707.png]]
Pero no existe una constante $c$ para la cual $(n+1)^2+c\cdot(n+1)!\leq c\cdot(n+1)!$
Vamos a demostrarlo con una propiedad más fuerte:
$$(\exists{c\in\mathbb{R}^+})(\exists{d\in\mathbb{R}^+})(\exists{n_0\in\mathbb{N}})(\forall{n\geq n_0})(T(n)\leq{c\cdot{n!}}-d\cdot{n})$$
![[Pasted image 20230821150259.png]]
![[Pasted image 20230821150311.png]]
![[Pasted image 20230821150330.png]]
