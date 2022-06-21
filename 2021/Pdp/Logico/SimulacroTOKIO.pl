%SimulacroTOKIO

medallas(argentina,oro,equipo(futbolMasculino)).
medallas(delfiPignatello,plata,individual(natacion)).
medallas(mariaBecerra,oro,individual(natacion)).
medallas(curry,plata,equipo(basquetMasculino)).

medallas(dePaul,oro,individual(futbol5)).
medallas(tevez,plata,individual(futbol5)).
medallas(drIgo,bronce,individual(futbol5)).

atleta(drIgo,argentina,23).
atleta(dePaul,argentina,21).
atleta(tevez,argentina,33).
atleta(messi,argentina,29).

atleta(mariaBecerra,argentina,19).
atleta(carlosPepon,paraguay,39).

atleta(curry,usa,45).
atleta(delfiPignatello,argentina,22).

compite(messi,futbolMasculino).
compite(delfiPignatello,natacion).
compite(delfiPignatello,natacionEnCadena).
compite(curry,basquetMasculino).

compite(dePaul,futbol5).
compite(drIgo,futbol5).
compite(tevez,futbol5).

evento(equipo(futbolMasculino),faseDeGrupos,argentina).
evento(equipo(futbolMasculino),4,argentina).
evento(equipo(futbolMasculino),8,argentina).
evento(equipo(futbolMasculino),semis,argentina).
evento(equipo(futbolMasculino),final,argentina).

evento(equipo(futbolMasculino),faseDeGrupos,nigeria).
evento(equipo(futbolMasculino),faseDeGrupos,bosnia).
evento(equipo(futbolMasculino),faseDeGrupos,iran).


evento(individual(natacion),1,delfiPignatello).
evento(individual(natacion),2,delfiPignatello).
evento(individual(boxeo),final,delfiPignatello).

evento(equipo(natacionEnCadena),3,argentina).
%%PUNTO 2

vinoAPasear(Atleta):-
    atleta(Atleta,_,_),
    not(compite(Atleta,_)).

%%Punto 3

medallasDelPais(Pais,Medalla,Disciplina):-
    atleta(Atleta,Pais,_),
    medallas(Atleta, Medalla, Disciplina).

medallasDelPais(Pais,Medalla,Disciplina):-
    atleta(_,Pais,_),
    medallas(Pais,Medalla,Disciplina).

%%Punto 4

participoEn(Atleta,Disciplina,Ronda):-
    atleta(Atleta,_,_),
    evento(individual(Disciplina),Ronda,Atleta).

participoEn(Atleta,Disciplina,Ronda):-
    atleta(Atleta,Pais,_),
    compite(Atleta,Disciplina),
    evento(equipo(Disciplina),Ronda,Pais).

%%Punto 5 
dominio(Pais,Disciplina):-
    atleta(_,Pais,_),
    compite(_,Disciplina),
    medallas(_,_,individual(Disciplina)),
    forall(medallas(Atleta,_,individual(Disciplina)), atleta(Atleta,Pais,_)).

%%Punto 6 
medallaRapida(Disciplina):-
    evento(Disciplina,Ronda,_),
    evento(Disciplina,RondaDistinta,_),
    Ronda \= RondaDistinta.



%%Punto 7 
noEsElFuerte(Pais,Disciplina):-
forall((evento(equipo(Disciplina),Ronda,Pais),Ronda==faseDeGrupos).

noEsElFuerte(Pais,Disciplina):-
    atleta(Atleta,Pais,_).
forall((evento(individual(Disciplina),Ronda,Atleta), Ronda==1)).
    

