```
module <name>:
encabezados de operaciones exportadas
declaraciones de variables
código de inicialización
procedimientos para operaciones exportadas
procedimientos y procesos locales
```
- Los procesos locales corren en el background
- En RPC se declara un procedimiento para cada operación y se crea un proceso para cada manejar cada llamada al procedimiento.
- Para distinguirlos de los procesos que resultan de las llamadas a las operaciones exportadas