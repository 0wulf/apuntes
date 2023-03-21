a
a
a
a
a
a
a
%
% ## los programas simples contienen reglas
% ## sin sengación

M = { h | "h." es una regla en P }

while ture:
    Sea h :- Cuerpo es una regla en P tal que los elementos de Cuerpo están en M y h no está en M:
        Agregamos h a M
    if M no cambió en la línea anterior:
        break

