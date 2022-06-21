#include <iostream>
using namespace std;
int main(){
	int i=0;
int valores[10], suma,promedio;
	while (i<10){
		cout<<" Ingrese un valor numerico: ";cin>>valores[i];
		suma+=valores[i];
		i++;
	}
	promedio=suma/10;
	cout<<"Los valores mayores o igual la media fueron"<<endl;
	cout<<"Los valores se mostraran en el formato (valor ----> posicion)"<<endl;
	i=0;
	while(i<10){
		if(valores[i]>=promedio){	
	cout<<valores[i]<<"---->"<<i+1<<endl;
}
	i++;
	}
	
   return 0;}

   
