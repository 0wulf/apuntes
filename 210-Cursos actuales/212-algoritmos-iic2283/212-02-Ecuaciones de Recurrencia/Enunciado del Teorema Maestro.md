Sea $f:\mathbb{N}\rightarrow\mathbb{R}^+$, $a,b,c\in\mathbb{R}^+_0$ tales que $a\geq{1}$ y $b\geq 1$, y $T(n)$ una función definida por la siguiente ecuación de recurrencia:
$$
T(n)= \left\{ \begin{array}{lcc}
              c &   si  & n = 0 \\
              \\ a\cdot T(\lfloor{\frac{n}{b}}\rfloor) +f(n)&  si & n\geq{1}
              \end{array}
    \right.
$$
Se tiene que:
1. Si $f(n)\in{O(n^{\log_{b}(a)-\varepsilon})}$ para $\varepsilon>0$, entonces $T(n)\in\Theta(n^{\log_{b}(a)})$
2. Si $f(n)\in\Theta(n^{\log_{b}(a)}\cdot\log_2^k(n))$ para $k\geq{0}$, entonces $T(n)\in\Theta(n^{\log_{b}^{k+1}(a)}\cdot{\log_{2}(n)})$
3. Si $f(n)\in\Omega(n^{\log_{b}(a)+\varepsilon})$ para $\varepsilon>0$ y $f$ es $(a,b)$-regular, entonces $T(n)\in\Theta(f(n))$