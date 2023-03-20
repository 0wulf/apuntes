# Clase 05: Scheduling I (?)
## Scheduling
### Planificación de CPU: ¿Cómo podemos gestionar los recursos que tenemos para lograr _multitasking_?
Tenemos:
* Múltiples procesos en memoria (multiprogramación) ordenados en una tabla de PCBs. Si no tuvieramos multiprogramación no necesitaríamos planificar.
* Algunos procesos en estado _ready_.
* CPU que puede atender un solo proceso a la vez.
<br>
Queremos:
* Multitasking: asignar tiempo a múltiples procesos.

Gestionamos los recursos a través del _scheduler_, el cual puede ser visto como un sistema de manejo de colas.
![image](https://user-images.githubusercontent.com/101217121/226347249-17c8a609-d735-4620-b83a-c2f7f8a7bf6a.png)
<br>
Recordemos que, en el caso de la _syscall_ <code>fork()</code> para Linux, el padre también sigue ejecutando.
### Niveles de _scheduling_
