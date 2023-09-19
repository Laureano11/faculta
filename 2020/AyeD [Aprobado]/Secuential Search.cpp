#include<iostream>
#include<conio.h>
using namespace std;

int main() {
	int vector[]= {2,10,21,29,43,23,412,31,4,123,4,12,32,342,3,123,4,213,12,423,1,231,23,4,5,34,676,456,34,5,474,56,345,76,34,5,56,47,56,345,623,452,6,56,234,25,3467,3456,32,452,34,63,45,324,645,754,456,34,52,34,6,363,4,777};
	int dato,i=0;
	string flag="F";
	dato= 34;
	
	while ((flag=="F")&&(i<64)){
	if(vector[i]==dato)
	flag="V";	
	i++;
	}	
	if (flag=="F")
	cout<<"el dato no pudo ser hallado";
	else
	cout<<flag<<" se encuentra en la posicion ->"<<i;
	
	return 0;
}
