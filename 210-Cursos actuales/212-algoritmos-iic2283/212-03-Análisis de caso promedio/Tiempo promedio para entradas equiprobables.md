El tiempo promedio para entradas de tamaño $n$ está dado por la siguiente expresión
$$\bar{t}(n)=\frac{1}{|\mathcal{I}_{\mathcal{P},n}|}\cdot \left(\sum_{w\in\mathcal{I_{\mathcal{P},n}}}{\text{tiempo}_{\mathcal{A}}(w)}\right)$$
donde $\mathcal{I}_{\mathcal{P},n}=\{w\in\mathcal{I}_\mathcal{P}: |w|=n\}$ son las instancias de tamaño $n$. 

La definición del tiempo promedio asume que todas las entradas son igualmente probables
- Esto podría no reflejar la distribución de las entradas en la práctica.

Para solucionar este problema podemos usar otras distribuciones de probabilidad.