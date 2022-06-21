#include <iostream>
#include <conio.h>
using namespace std;

string tendencia(int x, int y);
int main(){
	int a,b;
    cout<<"digite sus 1er valor: ";cin>>a;
     cout<<"digite 2do valor: ";cin>>b;
 	cout<<tendencia(a,b);
    return 0;
}

string tendencia(int a, int b){
	
	string tendenciaa;
 
	if (b-a<0)
	tendenciaa="Decreciente";
	
	else if (b-a<(a*0,02)&& b-a>0)
	tendenciaa="Estable";
	
	else if (b-a<(a*0,05)&& b-a<(a*0,02))
	tendenciaa="Leve asecenso";
	
	else if (b-a<a && b-a>(a*0,05))
	tendenciaa="En ascenso";
	
	return tendenciaa;	
}
