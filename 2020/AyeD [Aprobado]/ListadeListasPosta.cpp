#include <iostream>
#include <stdlib.h>
#include <windows.h>

using namespace std;
struct Tr{
	int Dni;
	int legajo;
	string nombre;
	int nota;
	int materia;
};
//LS (Lista secundaria) Legajos y notas
struct tipoinfoLS
{
int legajo; //El numero de legajo
int nota;//La nota del alumno
};

struct NodoLS
{
int legajo;
int nota; 
NodoLS* sgte; //Puntero hacia el proximo Nodo de LS
};

//LP (Lista principa)  Materias
struct tipoinfoLP 
{
int materia; //El codigo de la materia
NodoLS* puntLS; //El puntero hacia la lista de legajos de la materia
};

struct NodoLP
{
tipoinfoLP info; //Que contiene de info cada Nodo de LP
NodoLP* sgte; //El puntero al proximo Nodo de la LP
};

//Funcion para insertar una materia
NodoLP* insertarOrdenado(NodoLP *&LP,tipoinfoLP x)
{
NodoLP* aux = new NodoLP();
aux->info = x;
aux->sgte = NULL;
if(LP==NULL||x.materia<LP->info.materia)
{
aux->sgte = LP;
LP = aux;
}
else
{
NodoLP *q = LP;
while(q->sgte!=NULL&&x.materia>q->sgte->info.materia)
{
q = q->sgte;
}
aux->sgte = q->sgte;
q->sgte = aux;
}
	return aux;
}


NodoLP * Buscar(NodoLP*& LP,tipoinfoLP x)
{
NodoLP *p = LP;
while(p!=NULL && x.materia!=p->info.materia)
p = p->sgte;

return p;
}



NodoLP * insertarSinRepetir(NodoLP *& LP, tipoinfoLP x)
{
NodoLP *p = Buscar(LP,x);
if(p==NULL)
p = insertarOrdenado(LP,x);
return p;

}


NodoLS * insertarOrdenadoLeg(NodoLS *& LS,tipoinfoLS x)
{
NodoLS *aux = new NodoLS();
aux->info.legajo = x.legajo;
aux->info.nota = x.nota;
aux->sgte = NULL;
if(LS == NULL||x.legajo<LS->info.legajo)
{
aux->sgte = LS;
LS = aux;
}
else
{
NodoLS *q = LS;
while(q->sgte!=NULL &&x.legajo>q->sgte->info.legajo)
{
q = q->sgte;
}
aux->sgte = q->sgte;
q->sgte = aux;
}

return aux;

}



tipoinfoLP PopLP(NodoLP*& LP)
{
 NodoLP *p = LP;
 tipoinfoLP x = p->info;
 LP = p->sgte;
 delete(p);
 return x;

}


tipoinfoLS PopLS(NodoLS *& LS)
{
NodoLS *p = LS;
tipoinfoLS x = p->info;
LS = p->sgte;
delete(p);
return x;

}




int main()
{

//Declaracion de las variables
Tr r;
tipoinfoLP  valorLP;
tipoinfoLS  valorLS;
FILE *f;
f = fopen("Alumnos.dat","wb+");
NodoLP* LP = NULL;
NodoLS* LS = NULL; 


for(int i = 0;i<3;i++)
{
	cout<<i<<". "<<endl;
	cout<<"DNI: "; cin>>r.Dni;
	cout<<"Legajo: "; cin>>r.legajo;
	cout<<"Materia: " ; cin>>r.materia;
	cout<<"Nota: ";cin>>r.nota;
	fwrite(&r,sizeof(r),1,f);
}

fclose(f);
f = fopen("Alumnos.dat","rb");
/*
fread(&r,sizeof(r),1,f);
while(!feof(f))
{
	cout<<"Materia: "<<r.materia<<endl;
	cout<<"DNI: "<<r.Dni<<endl;
	cout<<"Legajo: "<<r.legajo<<endl;
	cout<<"Nota: " <<r.nota<<endl;
	fread(&r,sizeof(r),1,f);
}

system("cls");
fclose(f);
f = fopen("Alumnos.dat","rb+");
fread(&r,sizeof(r),1,f);
while(!feof(f))
{
	cout<<"Materia: "<<r.materia<<endl;
	cout<<"DNI: "<<r.Dni<<endl;
	cout<<"Legajo: "<<r.legajo<<endl;
	cout<<"Nota: " <<r.nota<<endl;
	fread(&r,sizeof(r),1,f);
}

*/

//Mostrar los datos ordenados


//Lectrua del archivo()
while(fread(&r,sizeof(Tr),1,f))
{
	valorLS.legajo = r.legajo;
	valorLS.nota = r.nota;
	
	valorLP.materia = r.materia;
	valorLP.puntLS = NULL;

	NodoLP* p = insertarSinRepetir(LP,valorLP);
	
	insertarOrdenadoLeg(p->info.puntLS,valorLS);
}

//Mostrar los datos:

while(LP!=NULL)
{
valorLP = PopLP(LP);
cout<<"Materia: "<<valorLP.materia<<endl;
while(valorLP.puntLS!=NULL)
{
valorLS = PopLS(valorLP.puntLS);
	cout<<"legajo: "<<valorLS.legajo<<endl;
	cout<<"Nota: "<<valorLS.nota<<endl;

}

}



return 0;



}
