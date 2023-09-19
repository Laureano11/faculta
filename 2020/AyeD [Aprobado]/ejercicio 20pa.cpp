#include <iostream>
#include <conio.h>
using namespace std;
/*2020_M1-20 Se dispone de un lote de valores enteros positivos que finaliza con un número
negativo. El lote está dividido en sublotes por medio de valores cero. Desarrollar un programa
que determine e informe:
a) por cada sublote el promedio de valores
b) el total de sublotes procesados
c) el valor máximo del conjunto, indicando en que sublote se encontró y la posición
relativa del mismo dentro del sublote
d) valor mínimo de cada sublote
Nota: el lote puede estar vacío (primer valor negativo), 
*/

int main(){

int n=0;	
int lote[n];
int sublotesprocesados;
float minsub=9999999999,maxsub=0,promsub,posmax,posmin,maximoconjunto,posmaximoconjunto,posmaximoconjuntosublote;
float contador=0, sumalotes;
while (lote[n]>=0){
	cout<<"ingrese un nuevo lote: ";cin>>lote[n];
	
	while (lote[n]>0){
		cout<<"dime un numero del sublote: ";cin>>lote[n];
		
		if(lote[n]>maxsub){			
	posmax=contador+1;
	maxsub=lote[n];
}
	if(lote[n]<minsub&&lote[n]!=0){			
	posmin=contador+1;
	minsub=lote[n];
	}
	sumalotes+=lote[n];

	contador++;		
}
	if (maxsub>maximoconjunto){
		maximoconjunto=maxsub;
		posmaximoconjuntosublote=posmax;
		posmaximoconjunto=sublotesprocesados;
	}
	


cout<<"El promedio de valores del sublote fue: "<<(sumalotes/contador)<<endl<<endl;
cout<<"El numero maximo es: "<<maxsub<<" encontrado en la posicion -->"<<posmax<<endl<<endl;
cout<<"el minimo del sublote es: "<<minsub<<" encontrado en la posicion--->"<<posmin<<endl<<endl;




minsub=9999999999;
maxsub=0;
posmin=0;
posmax=0;
contador=0;
sumalotes=0;
sublotesprocesados++;

}	

cout<<"se han procesado: "<<sublotesprocesados<<" sublotes"<<endl<<endl;
cout<<"El mayor del conjunto fue: "<<maximoconjunto<<" encontrado en la posicion--> "<<posmaximoconjuntosublote<<" del sublote N "<<posmaximoconjunto+1;

	return 0;
	
}
