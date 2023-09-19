

gallina(ginger,10,5).
gallina(babs,15,2).
gallina(mac,8,7).
gallina(bunty,23,6).
gallina(turuleca,15,1).

gallo(rocky,circo).
gallo(fowler,piloto).
gallo(oro,arrocero).

rata(nick).
rata(fetcher).

viveEn(granjaDelSol,turuleca).
viveEn(granjaDelSol,fetcher).
viveEn(granjaDelSol,nick).
viveEn(granjaDelSol,oro).

viveEn(tweedys,ginger).
viveEn(tweedys,mac).
viveEn(tweedys,bunty).
viveEn(tweedys,babs).
viveEn(tweedys,flower).


granja(Granja):-
    viveEn(Granja,_).


puedeCederle(GallinaCedente, GallinaCedida):-
    gallina(GallinaCedente,_,7),
    gallina(GallinaCedida,_,Huevos),
    Huevos < 3.


animal(Animal):-
    gallo(Animal,_).
animal(Animal):-
    gallina(Animal,_,_).
animal(Animal):-
    rata(Animal).


animalLibre(Animal):-
    animal(Animal),
    not(viveEn(_,Animal)).
    

valoracionGranja(Granja,Valoracion):-
    granja(Granja),
    findall(ValoracionAnimal,valoracionDeLosVivientesEn(Granja,ValoracionAnimal) , ValoracionesAnimal),
    sumlist(ValoracionesAnimal, Valoracion).

valoracionDeLosVivientesEn(Granja,ValoracionAnimal):-
    viveEn(Granja,Animal),
    valoracion(Animal,ValoracionAnimal).

valoracion(Animal,CuantoVale):-
    gallina(Animal,Peso,Huevos),
    CuantoVale is Peso * Huevos.

valoracion(Animal,0):-
    rata(Animal).

valoracion(Animal,50):-
    gallo(Animal,_),
    sabeVolar(Animal).

valoracion(Animal,25):-
    gallo(Animal,_),
    not(sabeVolar(Animal)).


sabeVolar(Animal):-
    gallo(Animal,piloto).
sabeVolar(Animal):-
    gallo(Animal,circo).


    
granjaDeluxe(Granja):-
noTieneRatas(Granja),
tieneMasDe50Animales(Granja).
    
    
granjaDeluxe(Granja):-
noTieneRatas(Granja),
valoracionGranja(Granja,1000).

noTieneRatas(Granja):-
granja(Granja),
forall(viveEn(Granja,Animales), not(rata(Animales))).

tieneMasDe50Animales(Granja):-
    granja(Granja),
    findall(Animal,viveEn(Granja,Animal),Animales),
    length(Animales,CantidadAnimales),
    CantidadAnimales >50.  
