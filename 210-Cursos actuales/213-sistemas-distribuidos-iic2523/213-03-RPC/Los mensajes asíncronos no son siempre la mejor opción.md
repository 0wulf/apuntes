Los mensajes asíncronos son apropiados para programar (procesos de tipo) filtros y pares interactuantes -> la información fluye por los canales en una dirección:
- e.g. los procesos en el algoritmo de Ricart-Argawala.
pero no son apropiados (los mensajes asíncronos) para (procesos de tipo) cliente-servidor:
- el flujo de información en ambos sentidos entre unos y otros tiene que programarse con dos intercambios de mensajes usando dos canales diferentes.
- cada cliente necesita un canal de respuesta diferente.

(Los mensajes asíncronos) no ofrecen transparencia de acceso.