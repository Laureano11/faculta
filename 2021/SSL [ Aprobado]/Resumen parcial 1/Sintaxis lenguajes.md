# Sintaxis y semantica de los Lengujaes

## Capitulo 1

* Alfabeto: Conjunto finito de caracteres (_elemento constructivo basico e individual_)y construye cadena de caracteres

`Ejercicio 1:`
 
 Alfabeto: (0,1,2,3,4,5,6,7,8,9, +,-)

 * Cadena: se construye **concatenando** caracteres de un **alfabeto** dado

 `Ejercicio 2:`

cadena1: 021

cadena2: 012

 `Ejercicio 3:`

Cadena: abab

* Longitud de cadena: se represente |S|.

_Ejemplo: longitud cadena |asdfes|: 6_

* Cadena vacia se representa con epilson

`Ejercicio 4:` 
A^1300 B^846 A^257 (_El indice 0 no es admitido_)

* Concatenacion de cadenas: S1*S2 (No es conmutativa)

* la cadena vacia es la identidad en concatenacion



* Potenciacion  en una cadena: S^4 = SSSS (_El indice 0 si es admitido_)

`Ejercicio 5:` S1 S2 S1 S2 =aabbaaabba

`Ejercicio 6:` Pporque c^0 indica ausencia de caracter y eso no tiene sentido

`Ejercicio 7:` Es lo mismo ya que se concatena 0 veces, por lo tanto el resultado es vacio

`Ejercicio 8:` cadena1= abbbabbbabbb

cadena2= ababababababababab

* Lenguaje natural: aquel que es hablado o escrito por los seres humanos
    * Evolucionan incorporando nuevos terminos y reglas
    * Reglas gramaticales viene despues del desarrollo del lenguaje
    * El signifcado(semantica) de las palabras es mas importante que su sintactica.
    * Ambiguos: Existe un emisor y un receptor

`Ejercicio 9`: Bruto, torpe, burro

* Lenguaje Formal: conjunto de cadenas formadas por un alfabeto dado
    * Las cadenas de este lenguaje no tienen semantica
    * No es ambiguo

`Ejercicio 10:` {a,r,g,e,n,t,u,h,o,l,b,s,d}

`Ejercicio 11:` {cppcp}{ppppc}{ccccp}{ccppc}

` Ejercicio 12 ` 

L = {b^n / 0 ≤ n ≤ 8}

` Ejercicio 13: `
El lenguaje de todas las palabras sobre el alfabeto {b} que están formadas por la concatenación
del carácter b consigo mismo, entre una y ocho veces e incluye a la palabra vacía

`Ejercicio 14:`
Por extensión se podría describir aunque sería bastante tedioso. Por comprensión no se puede
porque no tenemos los operadores adecuados para hacer esta descripción.

* Palabra: Si una cadena pertence a una lenguaje, se dice que es una palabra de ese lenguaje.
    * no existe palabra de longitud infinita

`Ejercicio 15: ` Es el lenguaje que contiene la letra A concatenada consigo misma una cantidad impar de veces

`Ejercicio 16: ` L={(A)^2N/ 0<N<400}

`Ejercicio 17:` 3 palabras de menor longitud= aba, abba, abbba.

Este lenguaje es aquel que comienza y termina con la letra A y tiene en el medio la letra B 1 o mas veces.

Lenguaje descripto por extension: {1001,101,10001,1000001}

Lenguaje descripto por compresion: L={10^n 1 / 1<n<4 } 

* Cardinalidad de un lenguaje: cantidad de palabras que lo componen

* Sublenguaje: subconjunto de un lenguja
    * sublenguaje vacio= cardinalidad 0
    * sublenguaje que contiene la palabra vacio = cardinalidad 1

* Lenguaje universal= lenguaje infinito formal que contiene todas las palabras que se pueden formar con los caracteres del alfabeto _E_, se representa con la sigma clausura/estrella.


## Capitulo 2 
--------------------------------

* Gramaticas formales: aquellas estructuras que pueden generar todas las palabras que forman un lenguaje Formal.
    * Es un conjunto de porducciones que dictan las reglas de reescritura y es deterministico.
    * Toda produccion esta formada por tres partes el lado izq, el lado derecho y el operador de produccion.

* Produccion epsilon -> Produccion que no genera nada, solo la palabra vacio.

`Ejercicio 1:` S->aaT , T->_e_. | S->aaT, T->b|

La produccion T-> geneera la palabra vacia del lenguaje, pero solo se puede llegar a ella a traves de S por lo tanto se genera AA antes.

* La gramatica Formal se compone por : (Vn,Vt,P,S)
    * Vn vocabulario no terminales, productores.
    * Vt Vocabulario terminal, caracteres del alfabeto.
    * P conjunto finito de producciones.
    * S axioma a partir del cual se comienzan a aplicar las producciones

`Ejercicio 2:` El lenguaje {a, aa}

`Ejercicio 3:`No es posible generar la cadena bab, una vez llegado a BA no hay produccion que genere la B restante.

 
 **Existen 4 tipos de gramaticas:**
    
    - Gramaticas Regulares de tipo 3:
        Sus producciones deben tener del lado izquierdo un solo noterminal.
        Del lado derecho debe estar formado por: Un terminal, un terminal + no terminal, epilson

    - Gramaticas independientes de tipo 2:
        No tienen restriccions respecto al lado derecho de la produccion. A-> aEDbRgbb

    - Gramaticas sensibles al contexto de tipo 1:
    |P| <= |T| ej; DVE-> aabT.
    - Gramaticas irrestrictasde tipo 0:
        tanto sus producciones como terminales, pueden llevar cualquier secuencia de terminales y noterminales. 

* Producciones recursivas: T-> aT

las gramaticas son equivalentes cuando generan el mismo lenguaje formal. 
 * Gramatica Quasi-Regular(GQR): esta abrevia la escrutira de una GR. Ej; S-> N|NS  N-> a|b|c

 `Ejercicio 11:` una GR siempre es una GIC pero una GIC no siempre es una GR. GR => GIC 

 `Ejercicio 12:` aab, aaabb

 **Formas de representar la derivacion**
 
 -Forma horizontal, usando el simbolo `->`
 
 -Forma Vertical, reemplazando un noterminal por su lado derecho y continuar asi

-Forma arbol, el axioma es la raiz del arbol.

La derivacion en forma vertical generara una tabla en donde en la primera mostrara la palabra que se va generando, mientras que a la izquierda se ira comentando cada reemplazo que se hizo.

[Link](file:///C:/Users/Laureano/Documents/UTN%20Lauri/2021/SSL/Derivacion%20sintaxis.jpg)
