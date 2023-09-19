

int mul (int a,int b);
/*
int main() {
	int n, n2;
	cout<<"digite dos numeros: ";cin>>n>>n2;
	
	cout<<mul(n,n2);
	
	return 0;
}
int mul (int a,int b){
	int ss; 
	int i;
	for (i=0;i<b;i++){
		ss+=a;
	}
	return ss;
}
*/

#include <iostream>
using namespace std;
struct pintureria{
	int tipo;
	string motivo;
	int valor;
	char gravedad[1];	
}abal;


int main() {
int i;

	while (i<2){
	cout<<"tipo: ";cin>>abal.tipo;
		
	cout<<"motivo: ";cin>>abal.motivo;	
	
	cout<<"Valor: ";cin>>abal.valor;
	
	cout<<"Gravedad: ";cin>>abal.gravedad;	
	
	i++;
}
cout<<abal.gravedad<<endl;
cout<<abal.motivo<<endl;
cout<<abal.tipo<<endl;
cout<<abal.valor<<endl;


return 0;
}
