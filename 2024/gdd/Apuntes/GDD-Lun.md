### Completar anterior


### Grafos - clasificacion

- Grafos dirigidos: los vertices tienen na direccion definida dicho sentido o direccion marca
una jerarquia en la relacion que se esta modelando, 
e 
por ejemplo: ` 'ser mayor que', 'ser menor que', 'ser padre de', 'ser componente de' ` 

- Grafos no dirigidos: son aquellos donde los arcos no tienen una direccion o sentido definido no establece jerarquia de forma tal que es irrelevante
Esta situacion solo se da en relaciones simetricas 
`Ejemplo:  'ser igual a', 'ser hermano de', 'ser`
Es irrelevante el orden de evaluacion de los vertices que conforman la relacion.

- Resctrictos: Son aquellos antiequivalentes, es decir no son reflexivos, simetricos y transitivos.
`Transitividad: transforma relaciones indirectas en directas por asi decirlo`
El grafo restricto es mas facil de modelar, porque esta acotado las cosas que pueden suceder 

- No restrictos: no se les aplica ninguna restricion, pueden modelar relaciones equivalentes.


### Busqueda en grafos

- Depth First: Es avanzar en profundidad sin mantener ningun orden jerarquico, hasta el momento que no puede avanzar mas. Luego toma otra relacion para seguir avanzando.



- Breath First: Primero se evaluan primero los que estan relacionados directamente conmigo. Si no es paso al primero que este relacionado y hago lo mismo.

### Estructura de datos
- Es un grafo dirigido y resstricto. Con unicidad en sus relaciones, esto es que en orden de predecesor cada nodo solo tiene un predecesor a el
`Univoco: miro para atras y 1 solo me genero`
`Biunivoco: tengo 1 solo que me genero y genero 1 solo `

Hay 4 tipos:
1. Pilas
1. Colas
1. Listas
1. Arboles (Biunivoco), su grado de crecimiento es > a 1

Estas 4 estructuras estaticamente se representan con un vector

Dinamicamente se representa con link structs (struct con 2 variable)

* El unico que sabe que tipo de estructura es, es el algoritmo que las administra, ya que se representan de la misma manera.





# Arboles
Donde cada elemento se puede relacionar con mas de uno.

- Nivel: Altura del arbol, arranca de 0
- Grado: maxima cantidad de hijos
- Profundidad: es la cantidad de niveles que tiene

Como saber donde estan mis hijos ? Segun una posicion I
 2 * I + 1 = 1er hijo , porque al multiplicar por 2 termina tu nivel (en el caso de grado 2)
 2 * I + 2 = 2do hijo 

 Caso inverso encontrar padre: 
Si la posicion es PAR, si o si soy hijo derecho
Si la posicion es IMPAR, si o si soy hijo izquierdo

(I - 1)/2
(I - 2)/2

* Caracteristicas del arbol:
    - Balanceado: mismia cantidad de elementos en cada subarbol o una diferencia indivisible
    - Completo: es en cual todos los nodos del arbol cumplen el grado o son hojas
    - Perfectamente balanceado: Cuando esta completo y estan todas las hojas al mismo nivel.

### Busqueda en arboles 
![alt text](image-2.png)

* La busqueda en arboles es logaritmica, por lo tanto a gran cantidad de elementos es proporcionalmente menos. 