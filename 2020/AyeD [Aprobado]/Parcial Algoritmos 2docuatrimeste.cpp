#include <iostream>
#include<conio.h>
#include<cstring>
const int i=15;
const int k=31;
struct gasto{
	int sector;
	int diames;
	char detalle[50];
	int importe;
};
struct nodo{
	gasto info;
	nodo* sgte;
};
nodo* insertarlista(nodo*&, gasto);
void cargarEstructura(FILE *, nodo* [i][k]);//al ser una matriz no es necesario pasar por referencia ya que se considera que los valores I y K van a cambiar dentro de la funcion
int main() {
	FILE* f;
	nodo* lista[i][k];//es una lista con filas de sectores y columnas de dias
	//i representa sectores y k representa dias
	for(int i=0;i<15;i++){
		for(int k=0;k<31;k++){
			lista[i][k]->sgte=NULL;//se colocan todos los punteros en null
		}
	}	
cargarEstructura(f,lista);	//llamamos a la funcion para que se carguen los datos de archivo en memoria

	return 0;
}

void cargarEstructura(FILE *f, nodo* lista[i][k]){
	gasto aux1;
	f=fopen("Gastos.dat","rb+");
	while(fread(&aux1,sizeof(gasto),1,f)){//vamos leyendo bloques del tamano gasto
	//no requerimos de ningun contador, el mismo dato de int sector e int diames nos indica en que posicion de lista colocarlo
			insertarlista(lista[aux1.sector-1][aux1.diames-1],aux1 );//se va guardando los datos obtenidos en los registros
		//cuando se lee el bloque se inserta segun al sector o dia del mes que pertenece
		//se le resta 1 para acomodar la diferencia. dia 2, sector 14, iria en la posicion lista[13][1]
	}
	fclose(f);//cerramos el archivo
}


nodo* insertarlista(nodo*& p, gasto x){	//funcion para insertar informacion en la lista sin ningun criterio
nodo* nuevo = new nodo();
nuevo->info=x;
nuevo->sgte=p;
p = nuevo;
return nuevo;
}
