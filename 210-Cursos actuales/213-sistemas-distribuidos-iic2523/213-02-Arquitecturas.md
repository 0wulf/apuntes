Es crucial organizar apropiadamente los sistemas distribuidos: sus componentes y cómo estos interactúan.
Objetivo: separar las aplicaciones de las plataformas subyacentes, a través de una capa de *middleware* que provee transparencia de distribución (aunque es necesario hacer compromisos)
### Arquitecturas de software (o estilo arquitectónico)
* Estratificada o por capas
* Basadas en objetos/servicios
* Basadas en recursos
* Basadas en eventos o publicación/suscripción
### Organización del *middleware*
* *wrappers* o adaptadores
* *interceptors*
* *middleware* modificable
### Arquitecturas de sistemas
* Centralizadas
* Descentralizadas
* Híbridas

# ¿Qué define a una arquitectura de software?
- Componentes: 
	- unidad modular con interfaces (requerida y provista) bien definidas que es reemplazable (mientras el sistema sigue operando) dentro de su entorno
- La forma en que los componentes están conectados unos a otros: 
	- los conectores son mecanismos que median la comunicación, coordinación y cooperación entre componentes.
	- e.g. RPC, paso de mensajes.
- Los datos intercambiados entre componentes.
- Cómo estos elementos son configurados conjuntamente en un sistema.

## Arquitecturas estratificadas o por capas
![[Pasted image 20230822171751.png]]
### e.g. Stacks de protocolos de comunicación
- Cada capa implementa uno o varios servicios de comunicación, ofrecidos por la capa para enviar datos de un interlocutor a otro (u otros)
- Cada capa ofrece una interfaz a través de la cual el servicio se vuelve disponible, que especifica las funciones que pueden ser llamadas y que oculta la implementación del servicio.
- Cada capa implementa un protocolo, que describe las reglas que los interlocutores deben seguir para establecer la comunicación e intercambiar información.
### e.g Estratificación lógica de las aplicaciones
Los diferencia en tres niveles lógicos que siguen un estilo arquitectónico estratificado para permitir acceso a bases de datos:
- El nivel de la interfaz de aplicación, que maneja la interacción con el usuario o con una aplicación externa
- El nivel de procesamiento que contiene la funcionalidad central de la aplicación y que varía mucho de una aplicación a otra
- El nivel de datos, que opera sobre una pase de datos o sistema de archivos persistente.
![[Pasted image 20230822172358.png]]

## Arquitecturas basadas en objetos
![[Pasted image 20230822172641.png]]

## Separación entre procesamiento y coordinación
![[Pasted image 20230822172744.png]]

## Arquitecturas publicación-subscripción
![[Pasted image 20230822172904.png]]
![[Pasted image 20230822172926.png]]
![[Pasted image 20230822173049.png]]
![[Pasted image 20230822173058.png]]
![[Pasted image 20230822173117.png]]
![[Pasted image 20230822173128.png]]
![[Pasted image 20230822173142.png]]
![[Pasted image 20230822173236.png]]
![[Pasted image 20230822173245.png]]
![[Pasted image 20230822173253.png]]
![[Pasted image 20230822173300.png]]
![[Pasted image 20230822173312.png]]
![[Pasted image 20230822173450.png]]
