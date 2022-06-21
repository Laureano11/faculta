#include <iostream>
#include <conio.h>
#include<string.h>
using namespace std;
struct materia{
	int nota;
	char nombremateria[50];
};
struct datosalumno{
	int legajo;
	char apellido[50];
	char nombre[50];
	int materiaspasadas;
	materia* materiasalumno;
}v[10];
struct nd{
	datosalumno info;
	nd* sgte;
};
materia* pushlistamateria(materia*&, materia);
nd* pushlista(nd*&, datosalumno);

int main() {
nd* Alumno=NULL;
materia* materias=NULL;




return 0;	
}

nd* pushlista(nd*& lista, datosalumno x){
	nd* nuevo = new nd();
nuevo->info=x;
nuevo->sgte=lista;
lista= nuevo;
return nuevo;
	
}
materia* pushlistamateria(materia*&, materia){
	materia* nuevo= new materia();
	nuevo=materia;
	
}
