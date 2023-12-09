Sea $\mathcal{A}=(Q,\Sigma,\Delta,I,F)$ un $\varepsilon$-NFA y $w\in\Sigma^{*}$
# Definiciones
- $\mathcal{A}$ acepta $w$ si existe una configuración inicial $(q_0,w)$ y una configuración final $(q_f,\varepsilon)$ tal que
$$(q_0,w)\vdash^{*}_{\mathcal{A}}(q_f,\varepsilon)$$
- El lenguaje aceptado por $\mathcal{A}$ se define como
$$\mathcal{L}(\mathcal{A})=\{w\in\Sigma^{*}|\mathcal{A}\text{ acepta }w\}$$
Se puede extender para NFA y DFA.

![[Pasted image 20230828101335.png]]
