/*
	Se quiere almacenar los gastos por sector (1 al 15) por dia (1 al 31), con detalle e importe
	leer de un archivo q no esta ordenado y que puede varios importes para un mismo sector
*/

#include <iostream>
#include <string.h>
using namespace std;

const int SECTORES = 15;
const int DIAS = 31;

struct Gasto{
	unsigned short nroSector, dia;
	char detalle[200];
	int importe;
};

struct Nodo{
	Gasto info;
	Nodo* sig;
};

void mostrarGastos(Nodo*[SECTORES][DIAS]);
void mostrarGastosSector(Nodo*[SECTORES][DIAS], unsigned short);
void mostrarGastosQuincena(Nodo*[SECTORES][DIAS]);
void mayorGasto(Nodo*[SECTORES][DIAS]);
void generarArchivo();
bool procesarGastos(Nodo*[SECTORES][DIAS]);
Nodo* insertarOrdenado(Nodo*&, Gasto);

int main(){
	Nodo* sectores[SECTORES][DIAS];
	
	// INICIALIZAMOS TODOS LOS PUNTEROS DE LA MATRIZ EN NULL
	for(int i = 0; i<SECTORES; i++){
		for(int j = 0; j<DIAS; j++){
			sectores[i][j] = NULL;
		}
	}
	
	if(procesarGastos(sectores)){	
		cout<<"Procediendo a mostrar los gastos de cada sector en sus dias..."<<endl<<endl;
		mostrarGastosSector(sectores, 1);
		cout<<endl;
		mostrarGastos(sectores);
		cout<<endl;
		mostrarGastosQuincena(sectores);
		cout<<endl;
		mayorGasto(sectores);
	}else{
		cout<<"No se pudo procesar los gastos"<<endl;
		generarArchivo();
	}
}

bool procesarGastos(Nodo* sectores[SECTORES][DIAS]){
	FILE* arch;
	if(arch = fopen("Gastos.dat", "rb+")){
		Gasto aux;
		fread(&aux, sizeof(aux), 1, arch);
		while(!feof(arch)){
			insertarOrdenado(sectores[aux.nroSector-1][aux.dia-1], aux);
			fread(&aux, sizeof(aux), 1, arch);
		}
		
		fclose(arch);
		return true;
	}
	return false;
}

// INSERTAR ORDENADO POR IMPORTE DESCENDENTE
Nodo* insertarOrdenado(Nodo*& l, Gasto info){
	Nodo* nuevo = new Nodo();
	strcpy(nuevo->info.detalle, info.detalle); // PARA COPIAR UN CHAR A OTRO
	nuevo->info.dia = info.dia;
	nuevo->info.importe = info.importe;
	nuevo->info.nroSector = info.nroSector;
	nuevo->sig = NULL;
	if (l==NULL || info.importe > l->info.importe ){
		nuevo->sig = l;
		l = nuevo;
	}else{
		Nodo* aux = l;
		while( aux->sig !=NULL && info.importe < aux->sig->info.importe) {
			aux = aux->sig;
		}
		nuevo -> sig = aux->sig,
		aux -> sig = nuevo;
	}
	return nuevo;
}

void mostrarGastos(Nodo* sectores[SECTORES][DIAS]){
	for(int i=0; i<SECTORES; i++){
		cout<<"Sector: "<<i+1<<endl;
		for(int j=0; j<DIAS; j++){
			cout<<"|\tDia: "<<j+1<<endl;
			Nodo* auxSector = sectores[i][j];
			if(auxSector != NULL){
				while(auxSector != NULL){
					cout<<"|\t|\t"<<auxSector->info.detalle<<" | "<<auxSector->info.importe<<endl;
					auxSector = auxSector->sig;
				}
			}else{
				cout<<"|\t|\tNo hay gastos"<<endl;
			}
		}
	}
}

void mostrarGastosSector(Nodo* sectores[SECTORES][DIAS], unsigned short nroSector){
	int total = 0;
	// nroSector - 1 dado que los sectores son del 1 al 15 y en la matriz del 0 al 14
	for(int i = 0; i < DIAS; i++){
		Nodo* auxSector = sectores[nroSector-1][i];
		while(auxSector != NULL){
			total+=auxSector->info.importe;
			auxSector = auxSector->sig;
		}
	}
	cout<<"Total del sector "<<nroSector<<": "<<total<<endl;
}

void mostrarGastosQuincena(Nodo* sectores[SECTORES][DIAS]){
	int total = 0;
	for(int i = 0; i < SECTORES; i++){
		int subTotal = 0;
		for(int j = 0; j < 15; j++){
			Nodo* auxSector = sectores[i][j];
			while(auxSector != NULL){
				subTotal += auxSector->info.importe;
				auxSector = auxSector->sig;
			}
		}
		cout<<"Total de la 1ra quincena del sector "<<i+1<<": "<<subTotal<<endl;
		total += subTotal;
	}
	cout<<"Total de la quicena: "<<total<<endl;
}

void mayorGasto(Nodo* sectores[SECTORES][DIAS]){
	Gasto aux;
	aux.importe = -999999;
	for(int i=0; i<SECTORES; i++){
		for(int j=0; j<DIAS; j++){
			Nodo* auxSector = sectores[i][j];
			while(auxSector != NULL){
				if(aux.importe < auxSector->info.importe){
					strcpy(aux.detalle, auxSector->info.detalle);
					aux.dia = auxSector->info.dia;
					aux.importe = auxSector->info.importe;
					aux.nroSector = auxSector->info.nroSector;
				}
				auxSector = auxSector->sig;
			}
		}
	}
	cout<<"Mayor gasto:"<<endl;
	cout<<"|\tNro. Sector: "<<aux.nroSector<<endl;
	cout<<"|\tDia: "<<aux.dia<<endl;
	cout<<"|\tDetalle: "<<aux.detalle<<endl;
	cout<<"|\tImporte: "<<aux.importe<<endl;
}

// SIRVE PARA GENERAR UN ARCHIVO EN CASO DE Q NO EXISTA
void generarArchivo(){
	FILE* arch = fopen("Gastos.dat", "wb+");
	Gasto aux;
	cin>>aux.importe;
	while(aux.importe!=0){
		cin>>aux.dia;
		cin>>aux.nroSector;
		cin>>aux.detalle;
		fwrite(&aux, sizeof(aux), 1, arch);
		cin>>aux.importe;
	}
	fclose(arch);
}
