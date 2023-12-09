# Problema de pattern matching de una palabra
Dado un patrón $w=w_1...w_m$ y un documento $d=d_1...d_n$, encontrar todas las posiciones donde aparece $w$ en $d$, o sea, enumerar:
$$\{(i,j)\mid w=d_i...d_j\}$$

---
# Autómata de un patrón
![[Pasted image 20231122094550.png]]
![[Pasted image 20231122095640.png]]
![[Pasted image 20231122095658.png]]
![[Pasted image 20231122100201.png]]
![[Pasted image 20231122100317.png]]
la diapode arriba esta mala
![[Pasted image 20231122100557.png]]
> Se lee: Para todo $i$ que pertenece a $S$, le estoy pidiendo que la palabra hasta cierto punto siempre sea sufijo de una palabra cortada hasta el punto $max(S)$

![[Pasted image 20231122100652.png]]
![[Pasted image 20231122101546.png]]
![[Pasted image 20231122101553.png]]
![[Pasted image 20231122101604.png]]

---
# *k-lookahead*
![[Pasted image 20231122102701.png]]
![[Pasted image 20231122102710.png]]
![[Pasted image 20231122102716.png]]
![[Pasted image 20231122102823.png]]
![[Pasted image 20231122102847.png]]
![[Pasted image 20231122102838.png]]
![[Pasted image 20231122102856.png]]

---
# Algoritmo de Knuth-Morris-Prat
![[Pasted image 20231122102928.png]]
![[Pasted image 20231122102936.png]]
![[Pasted image 20231122102942.png]]
![[Pasted image 20231122102949.png]]
![[Pasted image 20231122102958.png]]

---
# Bibliografía
![[Pasted image 20231122103012.png]]
