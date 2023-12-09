- Para $\varepsilon$-NFA veremos una forma alternativa para definir las nociones de ejecución y aceptación.
## Definiciones
Sea $\mathcal{A}=(Q,\Sigma,\Delta,I,F)$ un $\varepsilon$-NFA
- Un par $(q,w)\in Q\times\Sigma^*$ es una configuración de $\mathcal{A}$
- Una configuración $(q,w)$ es inicial si $q\in I$
- Una configuración $(q,w)$ es final si $q\in F$ y $w=\varepsilon$
"Intuitivamente, una configuración $(q,aw)$ representa que $\mathcal{A}$ se encuentra en el estado $q$ procesando la palabra $aw$ y leyendo la letra $a$""
- Se define la relación $\vdash_\mathcal{A}$ de siguiente-paso entre configuraciones de $\mathcal{A}$: $$(p,u)\vdash_\mathcal{A}(q,v)$$ si y solo si, existe $(p,c,q)\in\Delta$ con $c\in\Sigma\cup\{\varepsilon\}$ tal que $u=c\cdot v$
	- Notar que $\vdash_\mathcal{A}\subseteq (Q\times\Sigma^*)\times(Q\times\Sigma^*)$
- Se define $\vdash_\mathcal{A}^*$ como la clausura refleja y transitiva de $\vdash_\mathcal{A}$:
	- Para toda configuración $(q,w)$, entonces $(q,w)\vdash_\mathcal{A}^*(q,w)$
	- Si $(p,u)\vdash_\mathcal{A}(p',w)$ y $(p',w)\vdash_\mathcal{A}^*(q,v)$, entonces $(p,u)\vdash_\mathcal{A}^*(q,v)$
	- $(p,u)\vdash_\mathcal{A}^*(q,v)$ si uno puede ir de $(p,u)$ a $(q,v)$ en 0 o más pasos.