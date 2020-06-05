# Tema1-IOCLA
Introducere în organizarea calculatorului și limbaj de asamblare

    Tema1 IOCLA (Polish prefixat)

Tema a fost realizata in totalitate in limbaj de asamblare.

Am implementat 2 functii in main:  Preorder
                   Evaluate

Preorder este o functie recursiva care parcurge arborele AST format in preordine, pe masura 
cel parcurge arborele AST am transformat numerele aflate sub forma de stringuri in numere 
intregi cu ajutorul functiei atoi (1) si apoi le-am adaugat intr-un vector.

(1) -     functia atoi a fost la fel realizata de mine, aici am verificat daca aveam un numar ca intrare
    atunci ii transformam fiecare cifra din string in int, daca este un numar negativ atunci memoram
    -1 intr-un registru si il inmultim la sfarsit cu numarul nostru format in cazul cand intra un
    operator in atoi atunci returnam operatorul fara ca sa schimbam ceva.

Evaluate este o functie recursiva care calculeaza expresia data sub forma prefixata intr-un 
vector, functia parcurge vectorul de la coada spre inceput si pune numerele intr-o stiva pana 
ajunge la un semn, cand a ajuns la sem scoate doua numere din stiva si face operatia
respectiva semnului, apoi pune rezultatul pe stiva si asa repenta pana cand nu mai avem 
elemente in vector. Apoi afiseaza rezultatul aflat pe stiva.

Tema a fost realizata timp de 3 zile.
