### Motivación
#### ¿Es mínima esta gramática?
$$
\begin{gathered}
S\rightarrow aAa\mid aBD\mid aBH \\
A\rightarrow B\mid D \\
B\rightarrow aBa\mid b \\
C\rightarrow aCC\mid bC\\
D\rightarrow aDCa\mid Ca\\
F\rightarrow aFDa\mid aab\\
H\rightarrow\varepsilon
\end{gathered}
$$
1. Dada una variable $X$, ¿es $X$ útil para producir palabras? 
2. Dada una producción $p: X\rightarrow\gamma$, ¿es $p$ útil para producir palabras?
---
# Eliminación de variables inútiles
## Definición: Variables útiles e inútiles
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG
Diremos que una variable $x\in V$ es **útil** si existe una derivación: 
$$S\xRightarrow{*}\alpha X\beta\xRightarrow{*}w$$
Por el contrario, diremos que una variable $X$ es inútil si NO es útil.
#### e.g. ¿Qué variables son inútiles?
$$\begin{gathered}
S\rightarrow aAa\mid aBC \\
A\rightarrow aS\mid bD \\
B\rightarrow aBa\mid b \\
C\rightarrow abb\mid DD\\
D\rightarrow aDa
\end{gathered}$$
> ¿Cómo podemos determinar si una variable es útil? 
> 	Si es generadora y alcanzable
## Definición: Variable alcanzable y Variable generadora
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG
Para una variable $X\in V$
1. Decimos que $X$ es **alcanzable** si existe una derivación $$S\xRightarrow{*}{\alpha X\beta}$$
2. Decimos que $X$ es **generadora** si existe una derivación $$X\xRightarrow{*}w$$
> ¿Cómo determinamos si una variable es alcanzable o generadora?
## ¿Cómo determinamos si una variable es alcanzable?
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG
### Propiedad
Para toda variable $x\in V-\{S\}$
![[Pasted image 20231017182753.png]]
En base a esto podemos utilizar el siguiente algoritmo
![[Pasted image 20231017182852.png]]

## ¿Cómo determinamos si una variable es generadora?
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG
### Propiedad
Para toda variable $X\in V-\{S\}$
![[Pasted image 20231017182950.png]]
En base a esto podemos utilizar el siguiente algoritmo
![[Pasted image 20231017183001.png]]

## Eliminación de variables inútiles
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG
### Teorema
Sea $\mathcal{G}''$ una gramática creada a partir de $\mathcal{G}$ después de:
- Eliminar todas las variables y reglas NO generadoras
- Eliminar todas las variables y reglas NO alcanzables
Entonces $\mathcal{L}(\mathcal{G}'')=\mathcal{L}(\mathcal{G})$ y $\mathcal{G}''$ no contiene variables inútiles
> ¿Podemos eliminar primero las variables no generadoras y luego las no alcanzables? NO
#### ¿Qué falla al cambiar el orden?
![[Pasted image 20231017183450.png]]
#### Demostración del teorema
![[Pasted image 20231017183528.png]]
![[Pasted image 20231017183537.png]]
![[Pasted image 20231017183544.png]]
![[Pasted image 20231017183602.png]]

---
# Eliminación de producciones inútiles
Ahora no es preguntarse si una variable es útil, si no que si es necesaria
## Producciones unitarias y en vacío
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG
### Definición: Producciones en vacío y producciones unitarias
- Decimos que una producción de la forma: $X\rightarrow\varepsilon$ es una producción **en vacío**
- Decimos que una producción de la forma: $X\rightarrow Y$ es **unitaria**
Deseamos eliminar este tipo de producciones.
#### e.g
$$\begin{gathered}
S\rightarrow aAa\mid aBD\mid aBH \\
A\rightarrow aD\mid S \\
B\rightarrow aBa\mid \varepsilon \\
C\rightarrow abb\mid D\\
D\rightarrow aDa\mid a
\end{gathered}$$
- ¿Cuáles producciones son en vacío?
- ¿Cuáles producciones son unitarias?
- ¿Es $D\rightarrow a$ unitaria?
### ¿Podemos eliminar todas las producciones en vacío?
No. E.g:
$$S\rightarrow aSb\mid\varepsilon$$
#### Conclusión
Si $\varepsilon\in\mathcal{L}(\mathcal{G})$, entonces NO se pueden borrar todas las producciones en vacío sin alterar el lenguaje de $\mathcal{G}$
> Desde ahora supondremos que $\varepsilon\not\in\mathcal{L}(\mathcal{G})$
> Lo cual es razonable porque se puede añadir una palabra fácilmente
### ¿Cómo eliminamos las producciones en vacío y unitarias?
#### Observación
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG tal que $\varepsilon\not\in\mathcal{L}(\mathcal{G})$
![[Pasted image 20231018100213.png]]
#### Clausura de producciones unitarias y en vacío
Sea $\mathcal{G}=(V,\Sigma,P,S)$ una CFG tal que $\varepsilon\not\in\mathcal{L}(\mathcal{G})$
Sea $P^*$ el **menor conjunto de producciones** que contiene a $P$ y **cerrado bajo** las siguientes reglas:
1. Si $X\rightarrow Y\in P^{*}\wedge Y\rightarrow\gamma\in P^*$ entonces $X\rightarrow\gamma\in P^*$
2. Si $X\rightarrow\varepsilon\in P^{*}\wedge Z\rightarrow\alpha X\beta\in P^{*}$ entonces $Z\rightarrow\alpha\beta\in P^*$
Defina $\mathcal{G}^{*}=(V,\Sigma,P^{*},S)$. Entonces
- $P^{*}$ es finito
- $\mathcal{L}(\mathcal{G}^{*})=\mathcal{L}(\mathcal{G})$
> $|P^{*}|\geq|P|$
#### Propiedad 1
Para cualquier palabra $w\in\mathcal{L}(\mathcal{G}^{*})$, sea $\mathcal{T}$ un árbol de derivación de $w$ en $\mathcal{G}^*$ de tamaño mínimo.
Así, el árbol de derivación $\mathcal{T}$ NO usa producciones unitarias.
![[Pasted image 20231018101436.png]]
#### Propiedad 2
Para cualquier palabra $w\in\mathcal{L}(\mathcal{G}^{*})$, sea $\mathcal{T}$ un árbol de derivación de $w$ en $\mathcal{G}^*$ de tamaño mínimo.
Así, el árbol de derivación $\mathcal{T}$ NO usa producciones en vacío.
![[Pasted image 20231018101520.png]]

Por las propiedades 1 y 2, tenemos que:
- Para todo $w\in\mathcal{L}(\mathcal{G}^*)$, existe una derivación de $w$ en $\mathcal{G}$ que NO usa producciones en vacío ni producciones unitarias
- Así, podemos eliminar las producciones en vacío y unitarias de $\mathcal{G}^*$
#### Teorema
Para toda CFG $\mathcal{G}$ tal que $\varepsilon\not\in\mathcal{L}(\mathcal{G})$, sea:
1. $\mathcal{G}^*$ la clausura de producciones unitarias y en vacío
2. $\hat{\mathcal{G}}$ el resultado de remover toda producción unitaria o en vacío de $\mathcal{G}^*$
Entonces $\mathcal{L}(\hat{\mathcal{G}})=\mathcal{L}(\mathcal{G})$ y $\hat{\mathcal{G}}$ no tiene producciones unitarias o en vacío.
##### Demostración
Por el resultado anterior sabemos que $\mathcal{L}(\mathcal{G})=\mathcal{L}(\hat{\mathcal{G}})$ 
Por la propiedad 2, sabemos que $\hat{\mathcal{G}}$ no tiene producciones unitarias o en vacío.
> Importante: Es posible que $\hat{\mathcal{G}}$ contenga símbolos inútiles