#include <iostream>
using namespace std;

int mcd (int a,int b);
int r,x,y,mc,aux;
int main() {

	cout<<"ingrese 2 numeros: ";cin>>x;cin>>y;
cout<<mcd(x,y)<<"\n";

	system ("pause");
	return 0;
}

int mcd (int a,int b){
	
	r=a%b;
	
	while (r!=0){		
	aux=a;
	a=b;
	b=r;
	}

return b;
}
