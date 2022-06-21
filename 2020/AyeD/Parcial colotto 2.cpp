#include <iostream>


 struct nodo{
 	int dato;
 	nodo *sgte;
 };
 int poplista(nodo*&);
 void insertarsinrepetir(nodo*& ,int );
  char buscar(nodo*&, int);
  void listasinorden(nodo*&, nodo*&);
int main() {
	nodo* list1=NULL;
	nodo* lista2=NULL;
	nodo* listainterseccion=NULL;


	return 0;
}
void listasinorden(nodo*& lista1, nodo*& lista2){
int i=0;
int v1[i];

while(lista1!=NULL){
	while(0){ //colocamos todos los elementos de la lista 1 en el vector
		v1[i]=poplista(lista1);
		i++;
	}
	while(lista2!=NULL){
		while(0){ 
			v1[i]=poplista(lista2);
			i++;
		}// colocamos todos los elementos de la lista 2 en el vector
	}
	int bb;
	int k=0;
	for( k=0;k<i;k++){
		for(int j; j<i-1;j++){
		bb=v1[j];
		v1[j]= v1[j+1];
		v1[j+1]= bb;	//ordenamos todos los elementos de ambas listas
		} // luego del ordenamiento burbuja nuestro vector ya esta ordenado.
	}
	nodo* listainterseccion=NULL;
	int q=0;
	//ahora solo insertamos sin repetir en una lista nueva
	while(q<=i){ //bucle hasta que se vacie el vector
	insertarsinrepetir(listainterseccion, v1[i]);	
	}
	
}
	
}	
	
int poplista(nodo* &lista){
	int x;
	nodo* p=lista;
	x=p->dato;
	lista=p->sgte;
	delete p;
	return x;
	}	
	
	
	char buscar(nodo* &lista,int x){
	char flag='F';
	nodo* aux=lista;
	while((aux->sgte!=NULL) && (x=aux->dato)){
		aux=aux->sgte;
	}
	if(aux->dato==x)
	flag='T';
	else
	flag='F';
	
	return flag;
}



void insertarordenado(nodo*&lista, int x){

	nodo* nuevo= new nodo();
	nuevo->dato=x;
	
	nodo* aux1=lista;
	nodo* aux2=NULL;
	
	while((aux1!= NULL) && (aux1->dato<x)){
		aux2=aux1;
		aux1=aux1->sgte;
	}
	if(lista==aux1){
		lista=nuevo;
	}
	else{
		aux2->sgte=nuevo;	
	}
	nuevo->sgte=aux1;
}

void insertarsinrepetir(nodo*& p,int x){	
if(buscar(p,x)=='T'){
return;
}
else
insertarordenado(p,x);
}






