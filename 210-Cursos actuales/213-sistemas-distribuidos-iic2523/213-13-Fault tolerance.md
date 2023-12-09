Tolerante a fallas en la medida que esconde que uno de los procesos ha fallado. 
![[Pasted image 20231127110812.png]]
El principal problema es distinguir entre un proceso muerto y uno extremadamente lento en responder.
![[Pasted image 20231127110818.png]]Queremos que se pueda recuperar automáticamente de las fallas parciales sin afectar seriamente el desempeño
![[Pasted image 20231127111053.png]]
Dependable systems:
- Availability - Disponibilidad: system ready to use when i need it
- Reliability - Confiablidad: Propiedad de funcionar continuamente sin fallas. Funcionamiento sin interrupciones
- Safety - Inocuidad: no produce daño. es decir, cuando deja de operar correctamente, no ocurre nada catastrófico. Si la base de datos se cae, esta no puede volver arriba con data corrompida. En una planta nuclear si falla una conexión a un sensor, deben haber sensores de respaldo
- Mantainability - Mantenibilidad: 
La diferencia entre avaliability y reliability radica en que si se cae por 1 ms entonces el sistema es altamente disponible pero no altamente confiable. Si un sistema nunca se cae pero tenemos un período de dos semanas de baja, 

Tipos de fallas
- Crash failures: halts but works fine until halting
- Omission failures: fails to respond to incoming requests
	- Receive omission: fails to receive incoming messages
	- Send omission: fails to send messages
- Timing failure: responses lies outside a specified time interval
- Response failure: Response is incorrect
	- Value failure: The value of the respoonse is wrong
	- State-transition failure: deviates from the correct flow of control
- Arbitrary failure: May produce arbitrary responses at arbitrary times

Para saber si un proceso se cae, debemos diferenciar entre
- Sistemas asíncronos: en donde no se asume nada acerca de los tiempos de recepción de mensajes, por ejemplo.
- Sistemas sincrónicos: utilizamos un timeout.
Lo típico es estar en una zona intermedia en asíncrono y síncrono
Sistemas parcialmente sincrónicos: la mayor parte del tiempo se comporta como sincrónico. Es decir, el comportamiento asíncrono es una excepción. Usamos igual un timeout pero a veces puede tomarse una conclusión errónea
Necesitamos que sea tolerante a detectar incorrectamente que un proceso se ha caído

Esconder la ocurrencia de fallas para el resto de los procesos. Podemos usar redundancia.
Redundancia:
- Redundancia de información: se envían por ejemplo un checksum para verificar que no se haya corrompido la información. Hamming code permite corregir.
- Redundancia temporal: los sistemas de transacción permiten utilizar esto, pues o se realizó o no se realizó nada. Podemos repetir. No queda hecha hasta la mitad.
- Redundancia física: e.g. replicación

TMR Triple Modular Redundancy: redundancia aplicada en el diseño de dispositivos electrónicos
![[Pasted image 20231129192757.png]]
![[Pasted image 20231129192804.png]]
![[Pasted image 20231129192809.png]]


La idea es agrupar procesos idénticos y que parezcan un proceso robusto
- un mensaje enviado al grupo es enviado a todos los procesos parte del grupo
- los grupos pueden ser dinámicos
- los miembros necesitan llegar a consenso:
	- sin fallas: multicasting totalmente ordenado o incluso o una solución centralizada
	- crash failures: flooding
	- fallas bizantinas: 
		- todos los procesos backup guardan el mismo valor
		- si el primary es non-faulty entonces nonfaulty backups almacenan la información enviada por el primary
		- si no tenemos que tomar una decisión (nonfaulty llegan al mismo resultado) requerimos $2k+1$ procesos con $k$ faulty
![[Pasted image 20231129192915.png]]

CAP Theorem
en cualquier sistema interconectado en que hay datos compartidos solo se puden garantizar dos de las tres propiedades:
- C consistencia: los datos se ven iguales
- A availability disponibilidad
- P tolerancia a la partición del grupo

Los sistemas distribuidos prácticos son inherentemente unreliable

![[Pasted image 20231129192934.png]]
![[Pasted image 20231129192938.png]]
![[Pasted image 20231129192944.png]]
![[Pasted image 20231129192949.png]]
![[Pasted image 20231129192953.png]]
![[Pasted image 20231129193003.png]]
![[Pasted image 20231129193011.png]]
![[Pasted image 20231129193020.png]]
![[Pasted image 20231129193027.png]]
![[Pasted image 20231129193033.png]]
![[Pasted image 20231129193049.png]]
![[Pasted image 20231129193056.png]]
![[Pasted image 20231129193104.png]]
![[Pasted image 20231129193112.png]]
![[Pasted image 20231129193116.png]]
![[Pasted image 20231129193122.png]]
![[Pasted image 20231129193135.png]]


