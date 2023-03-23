# _Answer Set Programming_ (ASP)
## Clingo
<p align="justify">Utilizamos la herramienta <a href="https://potassco.org/clingo/">clingo</a> para resolver problemas de programación de conjuntos de respuestas (ASP). Para ello, se debe escribir un programa en el lenguaje de programación de conjuntos de respuestas (ASP) y ejecutarlo con la herramienta clingo. El programa debe ser escrito en un archivo de texto con extensión <code>.lp</code> y se ejecuta con el comando <code>clingo &ltarchivo.lp&gt</code>.</p>

<p align="justify">Los programas ASP se componen de hechos y reglas. Los hechos son declaraciones que se asumen verdaderas y son de la forma <code>p(a1, a2, ..., an).</code> donde no necesariamente existen argumentos. Es más fácil viéndolo de la forma <code>fact.</code>. Las reglas son declaraciones que se asumen verdaderas si se cumplen sus antecedentes y son de la forma <code>head :- body.</code>. El <i>body</i> puede incluir varios átomos separados por comas, indicando que todos ellos deben cumplirse para que la regla sea verdadera. Estos se conocen como _constraints_ y también se pueden incluir comparaciones como <code>X < Y</code> o <code>X = Y</code>.</p>

<p align="center">
    <img src="2023-03-21-18-11-12.png" alt="Ejemplo de programa ASP" width="500"/>
</p>

<p align=justify>Al ejecutar el programa, clingo retorna un <i>Answer Set</i> o un conjunto de <b>modelos</b>. La aparición de más de un modelo se puede lograr mediante la inclusión de <i>choice rules</i>. Estas son de la forma ...</p>


## Semántica de programas sin variables
### Reglas
#### Definición
Una **regla** en programación en lógica es un objeto de la forma $Head \larr Body$, donde $Head$ y $Body$ son conjuntos de átomos.
#### Ejemplos:
* $\{u\}\larr\{t,r\}$ en clingo: `u :- t, r.`
* $\{t\}\larr\{\}$ en clingo: `t.`
* $\{\}\larr r$ en clingo: `:- r.`
* $\{p,q\}\larr\{r,s\}$ en clingo: `p,q :- r,s.`

### Programas
#### Definición
Un **programa** es un conjunto de reglas.
#### Programas básicos
Un programa $\Pi$ es un **programa básico** cuando cada regla $H\larr B$ en $\Pi$ es tal que $H$ contiene exactamente un átomo.
### Modelos
#### Computando el modelo de un programa básico
Dado un programa básico $\Pi$, el siguiente algoritmo retorna el modelo de $\Pi$:
1. $M:=\{p|\text{ para toda regla }\{p\}\larr\empty\in\Pi\}$ (la regla es de la forma $\{p\}\larr\empty$).
2. Para cada regla de la forma $H\larr B \in\Pi$ tal que $B\subseteq M$ se cumple que $M:=M\cup H$.
3. Si $M$ cambió en 2. entonces volver a 2. En caso contrario retornar $M$ y $M$ es el modelo.
#### Definición
$M$ es un **modelo** de un programa $\Pi$ instanciado y sin negación si y solo si $M$ es un conjunto minimal (respecto de la relación de subconjunto) de átomos de $\Pi$, tal que si $Head\larr Body \in \Pi$ y $Body\subseteq M$, entonces $Head \cap M \neq\empty$.

### Reglas con negación
#### Definición
Una **regla** en programación en lógica es un objeto de la forma $Head \larr Pos, not(Neg)$, donde $Head$, $Pos$ y $Neg$ son conjuntos de átomos.
#### Ejemplos:
* $\{p,q\}\larr\{r,s\},not(\{t\})$ en clingo: `p;q :- r,s, not t.`
* $\{t\}\larr\empty,not(\{\})$ en clingo: `t.`
* $\{\}\larr not(\{r,s\})$ en clingo: `:- not r, not s.`

### Reducción y conjunto respuesta
#### Definición
La **reducción** de un programa $\Pi$ relativa a un conjunto $X$, denotada como $\Pi^X$, es la que resulta de hacer:
1. $\Pi^X:=\Pi$
2. Borrar toda regla $Head\larr Pos\cup not(Neg)$ de $\Pi^X$ cuando $Neg\cap X \neq \empty$.
3. Reemplazar cada regla $Head\larr Pos\cup not(Neg)$ en $\Pi^X$ por $Head\larr Pos$ cuando $Neg\cap X = \empty$.
#### Teorema
$X$ es un modelo de un programa con negación $\Pi$si y solo si $X$ es un modelo para $\Pi^X$ 