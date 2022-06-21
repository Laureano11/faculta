#include<iostream>
#include<stdlib.h>
#include<string.h>
using namespace std;


struct nd{
	int n;
	nd *sgte;
};
void ordenarMejorado(int arr[], int);//ordenamiento burbuja
nd* insertarDelante(nd* &, int);//inserta delante lista
nd* buscar(nd* p, int);//buscar dentro de lista
nodo* insertarordenado(nodo*&, int);// insertar ordenado
nd* insertarAlFinal(nd*& , int);//insertar al final
nd* insertarEnMedio(nd*& , int);//insertar en el medio
int unqueue(nd *&, nd *&);// sacar elemento de cola
void queue(nd *&, nd *&, int);// poner elemento en cola
void pushlista(nd *&, int);// poner elemento en pila
void pushpila(nd *&,int ); //Insertarelementos en una pila
int poppila(nd *&);//retirar elementos de una pila// el int depende del valor que contenga
int main() {
int a=323;	
//cout<<"hola"<<unqueue(fte,fin);
nd* fin=NULL;
nd* fte=NULL;
nd* pila1=NULL;


return 0;	
}
int poppila(nd* &pila){
	int x;
	nd* p=pila;
	x=p->n;
	pila=p->sgte;
	delete p;
	return x;
}
void pushpila(nd *&pila,int n){
	
	nd *p= new nd();
	p->n=n;
	p->sgte=pila;
	pila=p; 
}
void queue(nd *&fte, nd *&fin, int x){
	nd* p= new nd();
	p->n= x;
	p->sgte= NULL;
	if (fte==NULL)
	fte=p;
	else 
	fin->sgte=p;
	fin=p;
	return;
}	
int unqueue(nd *&fte, nd *&fin){
	
	nd*p = fte;
	int x = p->n;
	fte = p->sgte;
	if(fte==NULL)
	 fin = NULL;
	delete p;
	return x;
	
}
nd* insertarDelante(nd*& p, int x){
nd* nuevo = new nd();
nuevo->n = x;
nuevo->sgte= p;
p = nuevo;
return nuevo;
}


nd* insertarEnMedio(nd*& w, int v){
nd* p = new nd();
p->n= v;
p->sgte = NULL;
nd* aux = p;
while( aux->sgte!=NULL&& v<aux->sgte->n){
aux = aux->sgte;
}
p->sgte = aux->sgte;
aux->sgte = p;
return p;
}
nd* insertarAlFinal(nd*& p, int v){
nd* nuevo= new nd();
nuevo->n= v;
nuevo->sgte= NULL;
nd* aux = p;
if(p==NULL){
p = nuevo;
return nuevo;}
else {
nd* aux = p;}
while(aux->sgte!=NULL){
aux = aux->sgte;
}
aux->sgte = nuevo;
return p;
}
nodo* insertarordenado(nodo*& p, int v ){
if(p==NULL||v<p->n)
p = insertarDelante(p,v);
else
p = insertarEnMedio(p,v);
return p;}
nodo* buscar(nd* p, int v){
nodo* aux = p;
while(aux!=NULL&& aux->n!=v){
aux = aux->sgte;}
return aux;
}
void ordenarMejorado(int arr[], int N){
   
   int i,j,aux,ord = 0;
   for (i=1; i<N && !ord; i++)
   {
      ord = 1;
      for(j=0; j<N-i; j++)
      {
         if( arr[j]>arr[j+1] )
         {
			aux= arr [j];
			arr[j]= arr[j+1];
			arr[j+1]=aux;                        
            ord = 0;
         }
      }
   }

   return;
}



