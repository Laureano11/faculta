%Simulacro TOY STORY

duenio(andy, woody, 8).
duenio(sam, jessie, 3).



juguete(woody, deTrapo(vaquero)).
juguete(jessie, deTrapo(vaquero)).
juguete(buzz, deAccion(espacial, [original(casco)])).
juguete(soldados, miniFiguras(soldado, 60)).
juguete(monitosEnBarril, miniFiguras(mono, 50)).
juguete(seniorCaraDePapa,
caraDePapa([ original(pieIzquierdo),
original(pieDerecho),
repuesto(nariz) ])).

esRaro(deAccion(stacyMalibu, [original(sombrero)])).
esColeccionista(sam).

tematica(Juguete, Tematica) :-
    juguete(_, Juguete), % Para que sea inversible para el juguete.
    tematicaJuguete(Juguete, Tematica).

tematicaJuguete(deTrapo(Tematica), Tematica).
tematicaJuguete(deAccion(Tematica,_), Tematica).
tematicaJuguete(miniFiguras(Tematica,_), Tematica).
tematicaJuguete(caraDePapa(_), caraDePapa).

esDePlastico(Juguete):-
    juguete(_,Juguete),
    esPlastico(Juguete).

esPlastico(caraDePapa(_)).
esPlastico(miniFiguras(_,_)).


esDeColeccion(Juguete):-
    esMunecoAccionOCaraDePapa(Juguete),
    esRaro(Juguete).

esDeColeccion(Juguete):-
    esDeTrapo(Juguete).

esDeTrapo(deTrapo(_)).

esMunecoAccionOCaraDePapa(caraDePapa(_)).
esMunecoAccionOCaraDePapa(deAccion(_,_)).


amigoFiel(Duenio, NombreJuguete) :-
    jugueteQueNoEsDePlastico(Duenio, NombreJuguete, Anio),
    forall(jugueteQueNoEsDePlastico(Duenio, _, OtroAnio), Anio >= OtroAnio).
  
jugueteQueNoEsDePlastico(Duenio, NombreJuguete, Anio) :-
    duenio(Duenio, NombreJuguete, Anio),
    juguete(NombreJuguete, Juguete),
    not(esDePlastico(Juguete)).