#include<iostream>
#include<conio.h>
using namespace std;

	struct stats{
		int kills=2;
		char userid[30];
		int deaths;
		float kd=1;
}uknow,justk,brouly;	
int suma(int z, int y);		
int main(){	

int a,b;
	cout<<"decime las kills: ";cin>>uknow.deaths;
	
	cout<<uknow.userid<<endl;
	cout<<"say me 2 numbers: ";cin>>a>>b;
	cout<<"las kills son: "<<uknow.deaths<<endl;
	cout<<"la suma da: "<<suma(a,b);
	return 0;	
}

suma(int a, int b){
	
	int suma;
	
	suma= a+b;
	
	
	return suma;
}
