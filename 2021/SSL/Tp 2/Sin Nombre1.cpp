#include<stdio.h>

int funcionACorrer(int , int);
int main(){
	char noBool;
	int valorX, valorS;
	int numero=2;
	
	while (noBool){
		funcionACorrer(valorX,valorS);
		printf("\nPrograma corriendo");
		numero++;

		

}
 printf("No while");

}












int funcionACorrer(int parametro1,int parametro2){
		
	int resultado;
	resultado = (parametro1 + parametro2)/5;
	return resultado;
	
}
