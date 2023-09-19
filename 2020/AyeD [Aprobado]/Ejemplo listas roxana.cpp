#include <iostream>
#include <cstring>
using namespace std;
/* run this program using the console pauser or add your own getch, system("pause") or input loop */
struct Alumno
{
   int legajo;
   int materia;
   char nombre[40];
};
struct tipoLS{
   int legajo;
   int materia;
   char nombre[40];
};
struct nodo{
	Alumno info;
	nodo* sgte;
};
struct nodoLS{
	tipoLS info;
	nodoLS* sgte;
};
struct tipoLP{
	int info;
	nodoLS* sgte;
};
struct nodoLP{
	tipoLP info;
	nodoLP* sgte;
};
void ordenarMejorado(int [], int );
//PILAS
void push(nodo* &, Alumno);
Alumno pop(nodo* &);
//LISTAS
nodoLP* insertarOrdenadoMat(nodoLP*& , tipoLP );
nodoLS* insertarOrdenadoLeg(nodoLS*& , tipoLS );
nodoLP* insertarSinRepetir(nodoLP*& , tipoLP);
nodo* insertarOrdenado(nodo*& , Alumno);
nodoLP* buscar(nodoLP*,tipoLP);
tipoLP popLP(nodoLP* &);
tipoLS popLS(nodoLS* &);

//ARCHIVOS
void cargalegajos();

int main(int argc, char** argv) {
	
	  // un array con 6 enteros
   	Alumno y[8] = {{11,1,"Pedro"},{77,1,"Juan"},{4,1,"AB"},{77,5,"Juan"},{555,6,"NN"},{77,2,"Juan"},{99,3,"FG"},{100,4,"HH"}};
   	cargalegajos();
   	FILE* f=fopen("legajos.dat","rb+");
   	
	int i;
   	Alumno r;
   	Alumno valor;
	nodo* vector[6];

	for(i=0; i < 6; i++)
		vector[i] = NULL;
	//cargar  vector de listas con vector
	for(i=0; i < 8; i++){
 		valor.legajo = y[i].legajo;
 		valor.materia = y[i].materia;
 		strcpy(valor.nombre,y[i].nombre);
 		insertarOrdenado(vector[y[i].materia-1], valor);
 		
	}
	//con archivo
	while(fread(&r,sizeof(r),1,f)){
 		valor.legajo = r.legajo;
 		valor.materia = r.materia;
 		strcpy(valor.nombre,r.nombre);
 		insertarOrdenado(vector[r.materia-1], valor);
 		
	}
	
//mostrar los datos
	for(i=0; i < 6; i++){
 		while(vector[i]!=NULL){
 			valor=pop(vector[i]);
       		cout << "materia: "<< valor.materia<< " legajo: " <<valor.legajo << " nombre: " << valor.nombre <<endl;
		}
	}

//LISTA DE LISTAS
	
	fseek(f,0,SEEK_SET);
	tipoLS valorLS;
	tipoLP valorLP;
 	nodoLP* listaP=NULL;
	while(fread(&r, sizeof(r), 1,f)){
		// cargar los registros de las listas
		valorLS.legajo = r.legajo; 
		strcpy(valorLS.nombre,r.nombre);
		valorLP.info = r.materia; 
		valorLP.sgte = NULL;
		
		nodoLP* p=insertarSinRepetir(listaP, valorLP);
		insertarOrdenadoLeg(p->info.sgte, valorLS);
	}
	
	//MOSTRAR LOS DATOS
	while(listaP!=NULL){
		 valorLP = popLP(listaP);
		 cout << "MATERIA: " << valorLP.info << endl;
		 while(valorLP.sgte!=NULL){
		 	valorLS=popLS(valorLP.sgte);
		 	cout << "legajo:" << valorLS.legajo << endl;
		 }
	}
	
  
   
	return 0;
}
nodoLP* insertarSinRepetir(nodoLP*& p, tipoLP v){
   
nodoLP* q = buscar(p,v);
   if(q==NULL)
     q = insertarOrdenadoMat(p,v);
   
return q;
}


void cargalegajos()
{
	FILE* f=fopen("legajos.txt","wb");
	Alumno v;
	v.materia=1;
	v.legajo=12;
	strcpy(v.nombre , "AC");
	
	fwrite(&v,sizeof(v),1,f);
	
	v.materia=1;
	v.legajo=10;
	strcpy(v.nombre , "TU");
	fwrite(&v,sizeof(v),1,f);
	
	v.materia=6;
	v.legajo=1005;
	strcpy(v.nombre, "DF");
	fwrite(&v,sizeof(v),1,f);
	
	v.materia=6;
	v.legajo=12;
	strcpy(v.nombre,"SA");
	fwrite(&v,sizeof(v),1,f);
	
	v.materia=2;
	v.legajo=12;
	strcpy(v.nombre,"FR");
	fwrite(&v,sizeof(v),1,f);
	
	v.materia=3;
	v.legajo=1005;
	strcpy(v.nombre, "DF");
	fwrite(&v,sizeof(v),1,f);
	
	v.materia=4;
	v.legajo=10;
	strcpy(v.nombre, "HR");
	fwrite(&v,sizeof(v),1,f);
	
	v.materia=5;
	v.legajo=5;
	strcpy(v.nombre, "NA");
	fwrite(&v,sizeof(v),1,f);
	fclose(f);
}

Alumno pop(nodo* &pila){
	Alumno x;	
	nodo* p = pila;
	x = pila->info;
	pila = p->sgte; 
	delete p;
	return x;
}
tipoLS popLS(nodoLS* &pila){
	tipoLS x;	
	nodoLS* p = pila;
	x = pila->info;
	pila = p->sgte; 
	delete p;
	return x;
}
tipoLP popLP(nodoLP* &pila){
	tipoLP x;	
	nodoLP* p = pila;
	x = pila->info;
	pila = p->sgte; 
	delete p;
	return x;
}
void push(nodo* & pila, Alumno x){		

 nodo*p = new nodo();	
  p->info = x;	
  p->sgte = pila;
  pila = p;		
 return;
}
void ordenarMejorado(int arr[], int N)
{
   
   int i,j,aux,ord = 0;
   for (i=1; i<N && !ord; i++)
   {
      ord = 1;
      for(j=0; j<N-i; j++)
      {
         if( arr[j]>arr[j+1] )
         {
			aux= arr [j];
			arr[j]= arr[j+1];
			arr[j+1]=aux;                        
            ord = 0;
         }
      }
   }

   return;
}
nodo* insertarOrdenado(nodo*& l, Alumno x){
   nodo* p = new nodo();
   p->info = x;
   p->sgte = NULL;
   if(l==NULL || x.legajo <l->info.legajo)
   {
   		p->sgte=l;
   		l=p;
   }
   else
   {
		nodo* q=l;
	  	while(q->sgte!=NULL && q->sgte->info.legajo < x.legajo) {
	      q = q->sgte;
	   	}
	 	p->sgte= q->sgte;
	 	q->sgte=p;
   }
   	return p;
}
nodoLS* insertarOrdenadoLeg(nodoLS*& l, tipoLS x){
  nodoLS* p = new nodoLS();
   p->info = x;
   p->sgte = NULL;
   if(l==NULL || x.legajo <l->info.legajo)
   {
   		p->sgte=l;
   		l=p;
   }
   else
   {
		nodoLS* q=l;
	  	while(q->sgte!=NULL && q->sgte->info.legajo < x.legajo) {
	      q = q->sgte;
	   	}
	 	p->sgte= q->sgte;
	 	q->sgte=p;
   }
   	return p;
}
nodoLP* insertarOrdenadoMat(nodoLP*& l, tipoLP x){
   nodoLP* p = new nodoLP();
   p->info = x;
   p->sgte = NULL;
   if(l==NULL || x.info <l->info.info)
   {
   		p->sgte=l;
   		l=p;
   }
   else
   {
		nodoLP* q=l;
	  	while(q->sgte!=NULL && q->sgte->info.info < x.info) {
	      q = q->sgte;
	   	}
	 	p->sgte= q->sgte;
	 	q->sgte=p;
   }
   	return p;
}
nodoLP* buscar(nodoLP* lista,tipoLP x)
{
	nodoLP* p=lista;
	while(p!=NULL && x.info!=p->info.info)
		p=p->sgte;
	return p;
}
