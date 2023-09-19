/*Se dispone de un lote de valores enteros positivos que finaliza con un número negativo.
 El lote está dividido en sublotes por medio de valores cero. Desarrollar un programa que determine e informe:
 a)por cada sublote el promedio de valores
 b)el total de sublotes procesados
 c)el valor máximo del conjunto, indicando en que sublote se encontró y la posición relativa del mismo dentro del sublote
 d)valor mínimo de cada subloteNota: el lote puede estar vacío (primer valor negativo),
 o puede haber uno, varios o todos lossublotes vacíos (ceros consecutivos) 
*/
#include <iostream>
using namespace std;

int main()
{
    int lotes[255] = {0};// a menos que se usen listas, no se puede hacer un conjunto "interminable", ya que el ejercicio no define un límite. Por eso hay un limite lo mas alto posible
    int i = -1, j = 0, suma=0, cant_sublotes = 0, pos_sublote_max, long_sublote, max_con = INT_MIN, min_sub = INT_MAX;
    cout<<"Ingrese numeros (0 para separar lotes, negativos para terminar):"<<endl;
    do{
        i++;
        cin >> lotes[i];
        if(lotes[i]==0)//separar lotes en el ingeso para analisis posterior
            cout<<"---|"<<endl;
    }while(lotes[i]>=0 && i < 256);
    i=0;
    while(lotes[i]>=0)//escaneo del vector
    {
        suma = 0;
        long_sublote = 0;
        j=0;
        min_sub = INT_MAX;
        while(lotes[i]!=0)//escaneo de lotes
        {
            suma+=lotes[i];
            if(lotes[i]>max_con)
            {
                max_con=lotes[i];
                pos_sublote_max = j;
            }
            if(lotes[i]< min_sub)
            {
                min_sub = lotes[i];
            }
            long_sublote++;
            i++;
            j++;
        }
        if(lotes[i-1]!=0 && lotes[i]<=0)//Discriminante de lotes vacios y negativo
        {
            cout<<"****************\nSUBLOTE "<< cant_sublotes << endl;
            cout<<"Promedio: " <<((float)suma)/((float)long_sublote)<<endl;
            cout<<"Minimo del sublote: "<< min_sub <<endl;
            cant_sublotes++;
        }
        i++;
    }
    cout << "+++++++++++++++++++++\nSublotes procesados: " << cant_sublotes << endl;
    cout << "Maximo del conjunto es ("<<max_con<<"), encontrado en posicion relativa ["<<pos_sublote_max+1<<"]"<<endl;
    system("pause");
    return 0;
}
