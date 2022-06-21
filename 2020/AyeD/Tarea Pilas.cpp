#include<iostream>
#include<stdlib.h>
#include<string.h>
using namespace std;
struct ndc{
	string c;
	ndc *sgt;

};
struct nd{
	int k;
	nd *sgte;
};

void push(nd *&,int );//funcion para poner elemntos en la pila
int pop(nd *&);//funcion para sacar elementos de la pila enteros
string popc(ndc *&pilac );//funcion para sacar elementos de la pila pero de caracteres
void pushc(ndc *&, string );
void meterpila(nd*& , int);
void ejercicio1(nd*&, int );
void ejercicio2(nd*&, int);
char ejercicio3(nd*&, char &, int);
void ejercicio4(nd *&pila,nd *&pila2, int, int);
void ejercicio5(nd *&pila,int );
void ejercicio6(nd *&pila,nd *&pila2, int,int);
char ejercicio7(char,char);
void ejercicio8(ndc *&pilac, ndc *&pilac2);
void ejercicio9(nd *&pila,nd *&pila2,int);
int main(){
	nd * pila=NULL;
	nd * pila2=NULL;
	ndc *pilac=NULL;
	ndc *pilac2=NULL;
	int i,x,y;
	char F,conjunto,nombre,apellido;
	//ejercicio1 (pila ,i);
	//ejercicio2(pila,i);
	//ejercicio3(pila,F, i);
	//ejercicio4(pila,pila2,x,y);
	//ejercicio5(pila, x);
	//ejercicio6(pila,pila2,x,y);
	//ejercicio7(F,conjunto);
	ejercicio8(pilac,pilac2);
	//ejercicio9(pila,pila2,x);
	return 0;
}



void ejercicio1(nd*& pila , int i){
	
	int a;
   cout<<"Cuantos valores quiere en su pila: ";cin>>a;
   if(a<2){
   	cout<<"No va a ser posible introducir su valor I";//La pila no va a disponer de la cantidad suficiente de nodos como para retirar 2
   }
   else {
	cout<<"Ingrese su valor I: ";cin>>i;   	
   	int k=0;
   	int q;
   	while (k<a){
   		cout<<"Ingrese valores para introducir a la pila: ";cin>>q;
   		push(pila,q);
	   k++;
	   }
	   a=0;
	   while (a<2){
	   	pop(pila);
	a++;
	   }
	   push(pila,i);
	   
   	cout<<"Su valor I se ha guardado exitosamente: "<<endl;
   while (pila!=NULL){
   	cout<<pop(pila)<<endl;
   	
   }
   }
 }

void ejercicio2(nd*& pila, int){
	int a;
   cout<<"Cuantos valores quiere en su pila: ";cin>>a;
   int k=0;
   int q;
   int i;
	while (k<a){
   		cout<<"Ingrese valores para introducir a la pila: ";cin>>q;
   		if(k==(a-3)){
   			cout<<"dime su valor i: "; cin>>i;
		   push(pila,i);
		   }
   		else {
		   push(pila,q);
		   }
	   k++;
	   }
}

char ejercicio3(nd*& pila, char &, int){	
	int a,i,k=0;
	char F='S';
	cout<<"dime su valor i: ";cin>>i;
   cout<<"Cuantos valores quiere en su pila: ";cin>>a;
	meterpila(pila,a);	
	while (k<2){
		if(pila!=NULL){
			pop(pila);
		}
		else {
			F='N';
		}
		k++;
	}
	cout<<F;
push(pila,i);

return F;
}

void ejercicio4(nd *&pila, nd *&pila2, int, int){
	int x,y,k=1,a;
cout<<"digite su valor X: ";cin>>x;// El valor X
cout<<"digite en la posicion Y: ";cin>>y;// En la posicion y
cout<<"cuantos valores quiere en su pila generica: ";cin>>a;
if (a>=y){
meterpila(pila,a);
while(pila!=NULL){
	if(k==y){
		push(pila2,x);
	}
	push(pila2,pop(pila));
	k++;
	}
while (pila2!=NULL){
	cout<<pop(pila2)<<endl;
}
	
}
else{
	cout<<"No es posible, la direccion indicada es mayor a la cantidad de elementos de la pila ";
}
}

void ejercicio5(nd*&pila, int){
	int a,x;
	cout<<"cuantos valores queres ingresar en tu pila: ";cin>>a;
	cout<<"Dime su valor x para colocar en la ultima posicion: ";cin>>x;
	push(pila,x);
meterpila(pila,a);

while (pila!=NULL){
	
	cout<<"\n"<<pop(pila);
}
}
	
void ejercicio6(nd *&pila,nd *&pila2, int,int){

		int x,y,a;
		cout<<"Digite el valor X: ";cin>>x;
		cout<<"Sera cambiado por el valor: ";cin>>y;
		cout<<"Cuantos valores quiere introducir a su pila: ";cin>>a;
		(pila,a);
		
	while (pila!=NULL ){
		if(pila->k==x)
		pila->k=y;
push(pila2,pop(pila)); 
}

while (pila2!=NULL) {
	cout<<pop(pila2)<<endl;
}

}

char ejercicio7(char,char){
	char conjunto[50],conjunto2[50],conjuntoaux[50],F;
	
	cout<<"Digite dos conjunto de caracteres separados por 1 punto: ";
	cin.getline(conjunto,50,'.');
	cin.getline(conjunto2,50,'\n');

if (strcmp(conjunto,strrev(conjunto2))==0){	
F='T';
}
else {
	F= 'F';
}
	cout<<F;
	return F;
}

void ejercicio8(ndc *&pilac, ndc *&pilac2){
		string apellido, nombre;
	cout<<"Digite apellido y nombre:  ";cin>>apellido; cin>>nombre;
	pushc(pilac,apellido);
	pushc(pilac2,nombre);
	cout<<"los nombres ingresados fueron: "<<endl;
	cout<<popc(pilac2)<<endl;
	cout<<popc(pilac);
	}

void ejercicio9(nd *&pila,nd *&pila2,int){
	int a,min;
	cout<<"Cantidad de nodos que va a tener tu pila: ";cin>>a; 
	meterpila(pila,a);
	
	while(pila!=NULL){
	if(pila->k<min){
		min=pila->k;
	}
	push(pila2,pop(pila));	
	}
	//push(pila,min)
	//cout<<min;
	
	
}

void meterpila(nd*& pila, int a){
		int k,q;
		while (k<a){
   		cout<<"Ingrese valores para introducir a la pila: ";cin>>q;
   		push(pila,q);
	   k++;
	   }
}
int pop(nd* &pila){
	int x;
	nd* p=pila;
	x=p->k;
	pila=p->sgte;
	delete p;
	return x;
}
void push(nd *&pila,int n){
	
	nd *ndnew= new nd();
	ndnew->k=n;
	ndnew->sgte=pila;
	pila=ndnew; 
}
string popc(ndc *&pilac){
	
	string x;
	ndc* cc=pilac;
	x=pilac->c;
	delete cc;
	return x;
}
void pushc(ndc *&pilac, string cc){

	ndc *ndcnew= new ndc();
	ndcnew->c=cc;
	ndcnew->sgt=pilac;
	pilac=ndcnew;
}




