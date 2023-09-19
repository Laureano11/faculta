#include<iostream>
#include<string.h>
using namespace std; 
int factorial(int numerito);
int main() {
	int a=0,t=0,f=0,ft=0;
	while (a>=0){
	cout<<"\ningrese un numero que vamos a calcular varias cosas: ";cin>>a;
	cout<<"su factorial es: "<<factorial(a);
	if (a%3==0){
	t++;}
	if (a%5==0){
	f++;}
	if (a%5==0 && a%3==0)
	ft++;
	}
	cout<<"\n\n los multiplos de 3 en total hay: ";cout<<t;
	cout<<"\n los multiplos de 5 en total hay: ";cout<<f;
	cout<<"\nlos multiplos de 3 y 5 en total hay: ";cout<<ft;
return 0;
}

int factorial(int numerito){
	int factorial=1,i;
for(i=1;i<=numerito;i++){
	factorial= factorial*i;
}		
return factorial;	
}














/* char nombre[50];
	cout<<"Digite su nombre: ";cin.getline(nombre,50,'@');
	cout<<"\n"<<nombre; */
