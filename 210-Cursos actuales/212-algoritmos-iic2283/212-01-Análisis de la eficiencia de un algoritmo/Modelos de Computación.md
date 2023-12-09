Antes de diseñar y analizar algoritmos, es importante definir el modelo de computación subyacente.
Esto dignifica definir el tipo de computador hipotético sobre el cual se ejecutarán nuestros algoritmos.
Cada modelo de computación especifica las operaciones elementales que el computador hipotético puede ejecutar.
Esto afecta la manera en que uno diseña y analiza algoritmos sobre esos modelos, entonces es importante aclararlo desde un principio.
Dos modelos típicos son las máquinas de turing y las máquinas de acceso aleatorio
### Modelo de computación **Word RAM** 
RAM -> Random Access **Machine**
Es uno de los modelos más usados en la literatura por su similitud con los computadores actuales.
Es una máquina hipotética que consiste de:
* CPU, formada por
	* Registros: $k$ celdas de $w$ bits cada una (el parámetro más importante del modelo)
	* Instrucciones: **una instrucción por ciclo**.
	* Unidad de control 
* Memoria:
	* Una cantidad infinita de celdas de $w$ bits cada una, que pueden ser accedidas de manera aleatoria para lectura y escritura y cada acceso toma **un ciclo** del procesador.
![[Pasted image 20230809151119.png]]