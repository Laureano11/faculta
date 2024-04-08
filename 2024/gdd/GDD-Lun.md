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







