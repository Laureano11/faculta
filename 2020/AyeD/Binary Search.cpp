#include <iostream>
#include<conio.h>
using namespace std;



int main(){

int array[]= {5,8,9,20,45,60,90};
int inf, sup, mitad, dato;
char band = 'F';

cout<<"say a number to search: ";cin>>dato; // here u put the numbre that u want to search

inf=0; // this always will be 0, its the lower position on the array
sup=7; // this is the last position on the array -1
	
	while(inf <= sup){
		mitad= (inf+sup)/2;
		
	if (array[mitad]==dato){
	band = 'V';
	break;
	}
	if (array[mitad]>dato){
	sup= mitad;
	mitad = (sup+inf)/2;	
	}
	if(array[mitad]<dato){
		inf= mitad;
		mitad = (sup+inf)/2;
	}
	}
	
	if(band== 'V'){
		cout<<"el numero ha sido encontrado en la posicion"<<mitad;
	}
	else 
	cout<<"el numero no ha sido hallado";
	
	
	return 0;
}
