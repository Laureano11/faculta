#include<iostream>
#include<conio.h>
#include<cstring>
using namespace std;


struct registro{
 char nombreyapellido[50];
 int numerolegajo;
 int division;
}r[99],r1;
struct nd{
	nd* sgte;
	registro info;		
};
void insertarordenado(nd*&, registro );//inserta ordenado segun un campo
registro poplista(nd*&);//hace pop de la lista del primer elemento
nd* pushlista(nd*&, registro);//hace push de la lista 
void insertarsinrepetir(nd*&,registro);//inserta solo si el valor no se encuentra en la lista
void llenararchivo(FILE*);
char buscar(nd*&,registro);

int main(){
nd* lista1=NULL;
FILE *f;
//llenararchivo(f);

f=fopen("datosalumnos.txt","rb");
int q=0;
while(fread(&r[q],sizeof(registro),1,f)){
	r1=r[q];
	insertarordenado(lista1,r1);
	q++;
}
fclose(f);

cout<<buscar(lista1,r[4]);

return 0;}	


registro poplista(nd* &lista){
	registro x;
	nd* p=lista;
	x=p->info;
	lista=p->sgte;
	delete p;
	return x;
}

nd* pushlista(nd*& p, registro x){	
nd* nuevo = new nd();
nuevo->info=x;
nuevo->sgte= p;
p = nuevo;
return nuevo;
}

void llenararchivo(FILE*& f){
registro r3;
f=fopen("datosalumnos.txt","wb");
r3.division=3;
r3.numerolegajo=32313;
strcpy(r3.nombreyapellido,"laureano");
fwrite(&r3,sizeof(registro),1,f);

r3.division=5;
r3.numerolegajo=25;
strcpy(r3.nombreyapellido,"jose");
fwrite(&r3,sizeof(registro),1,f);

r3.division=4;
r3.numerolegajo=4398076;
strcpy(r3.nombreyapellido,"papurri");
fwrite(&r3,sizeof(registro),1,f);

r3.division=2;
r3.numerolegajo=7656;
strcpy(r3.nombreyapellido,"geronimo");
fwrite(&r3,sizeof(registro),1,f);	
fclose(f);
}

void insertarordenado(nd*&lista, registro dato){

	nd* nuevo= new nd();
	nuevo->info=dato;
	
	nd* aux1=lista;
	nd* aux2=NULL;
	
	while((aux1!= NULL) && (aux1->info.numerolegajo<dato.numerolegajo)){
		aux2=aux1;
		aux1=aux1->sgte;
	}
	if(lista==aux1){
		lista=nuevo;
	}
	else{
		aux2->sgte=nuevo;	
	}
	nuevo->sgte=aux1;
}

 char buscar(nd* &lista,registro x){
	char flag='F';
	nd* aux=lista;
	while((aux->sgte!=NULL) && (x.numerolegajo!=aux->info.numerolegajo)){
		aux=aux->sgte;
	}
	if(aux->info.numerolegajo==x.numerolegajo)
	flag='T';
	else
	flag='F';
	
	return flag;
}

void insertarsinrepetir(nd*& p,registro x){	
if(buscar(p,x)=='T'){
return;
}
else
insertarordenado(p,x);
}






