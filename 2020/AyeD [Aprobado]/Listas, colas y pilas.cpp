#include <iostream>
#include <stdio.h>
#include <stdlib.h>

using namespace std;
/*
int main(int argc, char *argv[]){
	char c, d,e,f[]="asdasd";
	int k;
	
  FILE *archivopp = fopen("prueba1.txt", "r");

  // fprintf(archivopp, "\n escribiendoop 2 ");
  fscanf(archivopp,"%s %s %s %d", d,e,f,k);
   if(archivopp != NULL){	
  /*	while (1!=0){
  c= fgetc(archivopp);
  if (feof(archivopp))
  break;
  cout<<c;
  k++;
  }
  
  cout<<d<<e<<f<<k;
  cout<<"\n\nEl archivo se leyo correctamente";
  }
else 
cout<<"\n no se ha podido leer el archivo";

fclose(archivopp);
  
cout<<"\n\n";
  system("PAUSE");
  return 0;
}    



struct nodo{
	int k;
	nodo *sgte;
};
void delcola(nodo *&, nodo *&, int &)
void inscola(nodo *&,nodo*&, int);
int main(){
	int k3;
nodo *frente=NULL;	
nodo *fin=NULL;		
cout<<"numero: ";cin>> k3;
inscola(frente,fin,k3);
inscola(frente,fin,33);
cout<<frente->k;
cout<<fin->k
	return 0;
}
void delcola(nodo *&frente, nodo *&fin, int &n){
	n= frente->dato;
	nodo *aux= frente;
	
	if (frente == fin){
		fin=NULL;
		frente=NULL;
	}
	else
	frente =frente->sgte;
delete aux;
}
void inscola(nodo *&frente, nodo*&fin, int k2){
	nodo *newnd= new nodo();
	
	newnd->k=k2;
	newnd->sgte =NULL;
	 
	if(frente==NULL){
		frente =newnd;
	}
	else{
		fin->sgte=newnd;
	}
	fin=newnd;
}
/*bool cola_vacia(nodo *frente){
	return (frente ==NULL)? true : false;
}
*/ 
 

struct datos{
	int importe;
	string detalle;
}datospila;
struct nd{
datos datospila;
	nd *sgte;
};


string pop(nd* &pila);// quitar elemntos string de la pila
int pop(nd* &pila); //quitar elementos de la pila
void push(nd *&pila, int, string); // poner elementos en la pila



int main(){
nd * pila=NULL;

void mostrargastos();
	
return 0;
}

/*void mostrargastos(){
	for (int i; i<15;i++){
		cout<<"Sector N"<<i+1;
	for (int k; k<31;k++){
		}
}
}
*/
int pop(nd* &pila ){
	int x;
	nd* p=pila;
	x=p->datospila.importe;
	pila=p->sgte;
	delete p;
	return x;
	

}
string pop(nd* &){
	string d;
	nd* p=pila;
	d=p->datospila->detalle;
	pila=p->sgte;
	delete p;
	return d;
}
void push(nd *&pila,int n, char d){
	
	nd *ndnew= new nd();
	ndnew->datospila.importe=n;
	ndnew->datospila.detalle=d;
	ndnew->sgte=pila;
	pila=ndnew; 
}
