#include <iostream>
using namespace std;


struct Nodo{
	int dato;
	Nodo *sig;
};

void agregarpila(Nodo *&, int);
void sacarpila (Nodo*&, int &);
int main() {
int n1,n2;

Nodo *pila= NULL;
cout<<"digite un numero: ";cin>>n1;
agregarpila(pila,n1);
cout<<"\n Digite un 2do numero: ";cin>>n2;
agregarpila(pila,n2);

sacarpila(pila,n2);
	return 0;
}
void agregarpila(Nodo *&, int n) {
Nodo *pila= NULL;

	Nodo *nuevo_nodo= new Nodo();
	nuevo_nodo->dato= n;
	nuevo_nodo->sig = pila; 
	pila = nuevo_nodo;
 
cout<<"\nEl numero "<<n<<" agregado a pila"<<"\n";
}

void sacarpila (Nodo*&, int &n){
Nodo *pila= NULL;
	Nodo *aux = pila;
	n = aux->dato;
	pila= aux->sig;
	delete aux;
}





