## Definición
Sea $\Sigma$ un alfabeto y $L\subseteq{\Sigma^*}$
Decimos que $L$ es un **lenguaje** sobre el alfabeto $\Sigma$
### Ejemplos de lenguajes
Sea $\Sigma = \{a,b\}$
* $L_0=\{\varepsilon, a, aa, b, ba\}$
* $L_1=\{\varepsilon, b, bb, bbb, ...\}$
* $L_2=\{w|\exists{u\in{L_1}}:w=a\cdot{u}\}$
* $L_3=\{w|\exists{u,v\in{\Sigma^*}}:w=u\cdot{abba}\cdot{v}\}$
Un lenguaje puede ser visto como una **propiedad** de palabras