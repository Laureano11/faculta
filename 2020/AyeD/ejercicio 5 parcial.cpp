#include <iostream>
using namespace std;


struct equipos{
	string nombre;
	int puntos;
}club[20],team;
void ordenar();
int main() {
ordenar();
return 0;
}

	

void ordenar(){
	int k=0, j=0;
	while (k<20){
		
	cout<<"\nIngrese el nombre del equipo: ";cin>>club[k].nombre;
	cout<<"Puntos en el campeonato:  ";cin>>club[k].puntos;
	k++;
}

for (k=0;k<20;k++){
	for (j=0;j<20;j++){
		if(club[j].puntos>club[j+1].puntos){
			team=club[j];
			club[j]=club[j+1];
			club[j+1]=team;
			
			
		}
	}
}
cout<<"\n Tabla Descendente: \n ";
for (j=19;j>=0;j--){
	cout<<club[j].nombre<<"--->"<<club[j].puntos<<endl;
}
cout<<"El campeon es --->"<<club[19].nombre;
}

