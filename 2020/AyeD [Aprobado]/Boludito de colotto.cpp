#include <iostream>
using namespace std;
struct informacion{
	int fila;
	int columna;
	int enteroalmacenado;
};
struct nodo{
	informacion info;
	nodo* sgte;
};
void push(nodo *&,informacion );

const int p=10;
const int q=10;
void recorrermatriz(int matriz[p][q], nodo*& );
int main() {

 nodo* pila=NULL;
int matriz[10][10];


	
	return 0;
}
void recorrermatriz(int matriz[p][q], nodo*& pila){
	informacion aux;
	
	int j;
for(int i=0;i<j+1;i++){ //i son las filas
	for (j=0;j<i;j++){// j son las columnas
		aux.fila=i;
		aux.columna=j;
		aux.enteroalmacenado=matriz[i][j];
		push(pila,aux);
	}
	
}
	
}

void push(nodo *&pila,informacion n){
	
	nodo *ndnew= new nodo();
	ndnew->info=n;
	ndnew->sgte=pila;
	pila=ndnew; }
	
	
