#include <iostream>
#include<conio.h>
#include<string.h>

using namespace std; 

int funciona (int a);

int main() {
	int min[4];
	/*
	char nombre[50];
	cout<<"Digite su nombre: ";cin.getline(nombre,50,'@');
	cout<<"\n"<<nombre; */
	cout<<"dime 4 digitos en minutos \n";cin>>min[4];
	funciona(min[4]);
	return 0;
}

int funciona (int a[]){
	int minutos;
	minutos= a[1]*60 + a[2,3];
	
	
	return minutos;
}
