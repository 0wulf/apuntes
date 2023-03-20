# Clase 05: Scheduling I
## Scheduling
### Planificación de CPU: ¿Cómo podemos gestionar los recursos que tenemos para lograr _multitasking_?
Tenemos:
* Múltiples procesos en memoria (multiprogramación) ordenados en una tabla de PCBs. Si no tuvieramos multiprogramación no necesitaríamos planificar.
* Algunos procesos en estado _ready_.
* CPU que puede atender un solo proceso a la vez.
<br></br>
Queremos:
* Multitasking: asignar tiempo a múltiples procesos.

Gestionamos los recursos a través del _scheduler_, el cual puede ser visto como un sistema de manejo de colas.
<br></br>
![image](https://user-images.githubusercontent.com/101217121/226347249-17c8a609-d735-4620-b83a-c2f7f8a7bf6a.png)
<br></br>
Recordemos que, en el caso de la _syscall_ <code>fork()</code> para Linux, el padre también sigue ejecutando.
### Niveles de _scheduling_
* _Long-term scheduler_:
  - Admite procesos en la cola _ready_.
  - Determina el grado de multiprogramación (cantidad de procesos en memoria).
* _Medium-term scheduler_:
  - Modifica temporalmente el grado de multiprogramación.
  - Ejecuta _swapping_ copiando memoria RAM al disco y del disco a la RAM.
* _Short-term scheduler_ (aka _dispatcher_):
  - Selecciona un proceso de la cola _ready_ para ejecutar.
  - Ejecuta el cambio de contexto.
<br></br>
![image](https://user-images.githubusercontent.com/101217121/226352012-4d78af6a-9aab-4475-a07d-78b61ef50ade.png)
<br></br>

#### ¿Y si estamos siempre haciendo _scheduling_ en vez de ejecutar programas?
_Scheduling_ es importante para el _multitasking_... pero _scheduling_ y _context switch_ son solo _overhead_:
* ¿Qué pasa si el _scheduler_ o el _context switch_ toman más tiempo de lo que toma el proceso?
* ¿Qué pasa si se le asigna poco tiempo a cada proceso?
* ¿Qué pasa si hay muchos procesos _ready_?
La contención o atascamiento de procesos se refleja en el concepto de _thrashing_:
<br></br>
![image](https://user-images.githubusercontent.com/101217121/226355586-8ac24178-fe91-4920-9987-398f09f8b26f.png)
<br></br>

### Modelo de ejecución de un proceso
No todos los procesos se comportan igual. Los procesos en general alternan entre dos fases:
* Uso de CPU (_CPU brust_)
* Espera por I/O (_I/O-brust_)
<br></br>
y suelen estar dominados por uno u otro, de modo que, a los procesos fuertemente dominados por el uso de CPU se le conoce como _CPU intensive_ mientras que a los procesos fuertemente dominados por espera de I/O se les conoce como _I/O intensive_ o procesos interactivos.
<br></br>
![image](https://user-images.githubusercontent.com/101217121/226359283-bc08d9d7-c365-4f8e-bd5b-0c4e89786567.png)
<br></br>
#### Una CPU bajo el 100% está subutilizada.
El tiempo que gasta un proceso en espera obviamente influye en la utilización de la CPU:
* $p$ es el porcentaje de tiempo en espera de I/O.
* $p^n$ es la probabilidad que $n$ procesos estén esperando por I/O.
* Utilización de la CPU es $CPU_n=1-p^n$
Una vez que llego al 100% ya no tiene mucho sentido agregar más procesos.
<br></br>
![image](https://user-images.githubusercontent.com/101217121/226360885-77ffd2ec-8dd3-4e20-8af2-eede50c9680c.png)
<br></br>

### Tipos de _scheduling_
Podemos clasificar las políticas de _scheduling_ según tipo de interrupción y según objetivo.
Según tipo de interrupción:
* _Preemptive_ (expropiativo):
  - Utiliza interrupciones (ej: de reloj _timer_) para decidir cuando sacar un proceso de ejecución.
* _Non-Preemptive_ (colaborativo o no-expropiativo): Permite que un proceso ejecute hasta que:
  - El proceso deja voluntariamente la CPU, ó
  - El proceso se bloquea en I/O, ó
  - El proceso termina.
<br></br>
Según objetivo:
* _BATCH_: trabajo por lotes. Sin interacción.
  - Mantener la CPU lo más ocupada posible.
  - Minimizar _turnaround time_: tiempo desde envío hasta término.
  - Maximizar _throughput_: número de trabajos por hora.
* _Interactive_: 
  - Minimizar tiempo de respuesta.
  - Satisfacer usuarios.
* _Real Time_:
  - Tiempo de respuesta debe ser predecible.
  - Alcanzar _deadlines_.
<br></br>
Todos los tipos de _scheduler_ tienen el objetivo de _fairness_: que todos los procesos tengan un tiempo razonable de ejecuci
