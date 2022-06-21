#include <iostream>
#include <cstring>
using namespace std;

struct registro{
	int dni;
	char nombre[50];
	float peso;
	int ncasa;
}r,r1[6];



struct dia{
	int importe;
	char detalle[40];
};
struct sector{
	int numerosector;
	dia diaa[31];
};

struct nd{
	sector n;
	nd *sgte;
};

void cargarlistas(registro [],FILE *&);
void pushpila(nd *&,int );
int poppila(nd *&);
void queue(nd *&, nd *&, int);
int unqueue(nd *&, nd *&);
void unasolacola(nd *&,nd *&,nd *&,nd *&);
int elementosdeunacola(nd *&,nd *&);
void devolvercolaanashex(nd *&,nd *&,nd *&);
int main(){

/*	FILE *f= fopen("datos.txt","wb");
	int i=0;
	r1[0].dni=43980678;
	r1[0].ncasa=1630;
	strcpy(r1[0].nombre,"laureano");
	r1[0].peso=55.6;
	fwrite(&r1[i],sizeof(r),1,f);
	
	r1[0].dni=2034304;
	r1[0].ncasa=1234;
	strcpy(r1[0].nombre,"morena");
	r1[0].peso=70.5;
	fwrite(&r1[i],sizeof(r),1,f);
	
	r1[0].dni=123123123;
	r1[0].ncasa=12344444;
	strcpy(r1[0].nombre,"nahuelito");
	r1[0].peso=90.0;
	fwrite(&r1[i],sizeof(r),1,f);

	fclose(f);
	
	cargarlistas(r1,f);
*/

	return 0;
}

void queue(nd *&fte, nd *&fin, int x){
	nd* p= new nd();
	p->n= x;
	p->sgte= NULL;
	if (fte==NULL)
	fte=p;
	else 
	fin->sgte=p;
	fin=p;
	return;
}
int unqueue(nd *&fte, nd *&fin){
	
	nd*p = fte;
	int x = fte->n;
	fte = p->sgte;
	if(fte==NULL)
	 fin = NULL;
	delete p;
	return x;
	
}
void unasolacola(nd *&fte1,nd *&fin1,nd *&fte2,nd *&fin2){
		
	if(fte2==NULL){
		while(fte1!=NULL){
		queue(fte2,fin2,unqueue(fte1,fin1));}
	}
	else if (fte2!=NULL){
		while(fin2!=NULL){
		queue(fte1,fin1,unqueue(fte2,fin2));}
		while(fte1!=NULL){
			queue(fte2,fin2,unqueue(fte1,fin1));
		}
	}
	return;
}
int elementosdeunacola(nd *&fte,nd *&fin){
	int k=0;
	nd *fteaux= new nd();
	nd *finaux= new nd();
	
	while(fte!=NULL){
		queue(fteaux,finaux,unqueue(fte,fin));
			k++;
	}
	
for(int i=0;i<10;i++){
	//cout<<unqueue(fteaux,finaux);
	cout<<"hola";
	}
	return k;
}
int poppila(nd* &pila){
	int x;
	nd* p=pila;
	x=p->n;
	pila=p->sgte;
	delete p;
	return x;
}
void pushpila(nd *&pila,int n){	

	nd *p= new nd();
	p->n=n;
	p->sgte=pila;
	pila=p; 
}
void devolvercolaanashex(nd *&fte1,nd *&fin1, nd*&pila){
 	
 		if(elementosdeunacola(fte1,fin1)>5){
		 	for(int i=0;i<3;i++){
			cout<<unqueue(fte1,fin1)<<endl;
			}
		 }
  else{ while(fte1!=NULL){
			pushpila(pila,unqueue(fte1,fin1));
			}
			while(pila!=NULL){
				cout<<poppila(pila);	}
  }}		
void cargarlistas(registro r1[],FILE *&f){
	
	fopen("datos.txt","rb");
	
	int q=0;
	while(fread(&r1,sizeof(r),1,f)){
		r1[q]=r; 
	q++;	
	}
fclose(f);}
	




