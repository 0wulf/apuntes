cable(c1).
cable(c2).

cable(tp).
cable(tn).

con(Cable1,Cable3) :- con(Cable1,Cable2),con(Cable2,Cable3).

led(l1).
con(tp,c1).
con(c1,l1).
con(l1,c2).
con(c2,tn).

encendido(Led) :- con(tp,tn),led(Led).
