1. Un nuevo proceso -un servidor- atiende la llamada.
2. Los parámetros son pasados como mensajes entre el proceso que llama este nuevo proceso servidor
3. El proceso que llamó se suspende mientras el servidor ejecuta el procedimiento que implementa la operación
4. Cuando el servidor termina la ejecución de la operación, envía los parámetros del resultado y el valor de retorno al proceso que llamó, y termina su ejecución
5. Después de recibir los resultados, se retoma el proceso que llamó
# Ejemplos
## [[Un módulo servidor de tiempo]]
## [[Un sistema de archivos distribuido]]