# Parciales SO
## Parcial TM 2019

1. ¿Qué ventajas da el uso de paginación jerárquica en un entorno de memoria virtual? Compare la
paginación jerárquica con la tabla de páginas invertida en términos de: forma de acceso | tamaño
ocupado.

- Ventajas: la paginacion jerarquica permite tener varias tablas de paginas por lo tanto facilita la multiprogramacion
Comparando la Tabla de pagina invertidas accesos: la paginacion jerarquica son 3 accesos, 1ero a la tabla de punteros a tablas de pagina,
2do, a las tablas de pagina, 3ero a la pagina en si. Por otro lado la pagina invertida son 2 accesos 1 a la tabla de pagina y otro a la pagina.
Tamano ocupado, ocupa mas tamano la paginacion jerarquica ya que la cantidad de tablas de paginas son mayores y tambien puede haber mas paginas.


1. Indique qué problemas presenta la estrategia de asignación de bloques contigua y cómo la
indexada lo soluciona. ¿Qué ventajas presenta la primera estrategia sobre la segunda?

- La asignacion de bloques continua presenta la desventaja que necesita si o si que el espacio libre necesario
para asignar un espacio tiene que estar continuo si o si. Por lo tanto puede haber el espacio libre necesario,
pero al no estar contiguo no se puede asignar este espacio. Esta desventaja la soluciona el metodo de indexado
donde en el fcb hay un puntero a cada bloque y no necesariamente necesitan estar contiguos ni en orden, por lo tanto
se aprovecha mejor el espacio, aunque su desventaja es que necesitan en el FCB una estructura mas compleja para administrar
estos bloques de datos.

1. Se tiene un sistema que cuenta con un esquema de paginación con páginas de 64KiB, en el cual se
mapean archivos cuyo tamaño en el File System es siempre menor que 30KiB. ¿Qué problema se
presenta en esta situación? Plantee una alternativa para poder solucionarlo.

- Esta habiendo un problema de fragmentacion interna, ya que no es esta ocupando todo el espacio por pagina
derrochando espacio libre. Esto se puede solucionar con un tamanio de paginas mas chiquitas, como pueden ser 4kib o 8kib, y seria preferible 
usar mas paginas pero hay menor fragmentacion interna, incluso se podrian usar paginas de 1kib.

4. V o F
a. En caso de detectar thrashing el bajar el nivel de multiprogramación siempre soluciona el
problema.
b. En caso de realizar un hardlink sobre un archivo que se encuentra en otro FS pero que es
de tipo UFS se incrementará el contador de referencias.

- Falso, bajar el nivel de multiprogramacion no siempre solucionaria el problema, aunque en algunos casos si podria hacerlo.
- El thrashing podría ser porque un proceso en particular no tiene suficientes
frames para ejecutar una instrucción, usando asignación fija.

- Falso, no se incrementara el contador de referencias ya que este otro sistema UFS, no tendra conocimiento de este acceso directo hardlink


## Parcial TT 2019

1. Explique al menos dos maneras que tiene el hardware para mejorar la eficiencia del sistema de
gestión de memoria. ¿Qué ventajas implica cada una

- MMU: mejora la eficiencia de la memoria realizando la traducción de Dirección Lógica a
Física. Las ventaja principal es permitir que la traducción se realice de manera más
rápida. Además, aporta protección al sistema analizando la validez de la dirección
lógica.
- TLB: mejora la eficiencia de la memoria para que la traducción sea más rápida. Es una
memoria caché de entradas de la tabla de páginas del proceso actual (algunas tienen
entradas de varios procesos), La consulta en la TLB es más rápida que en la tabla de
páginas. Mejora aún su eficiencia cuando se utiliza paginación jerárquica.
- Disco de swap: permite que los procesos sean más grandes que la memoria o bien
cargar más procesos en memoria.

1. V o F:
- a. La principal ventaja de utilizar paginación jerárquica es que los procesos pueden utilizar
un número de páginas mayor a la cantidad de marcos disponibles.
- b. La paginación y la segmentación pueden requerir el uso de la compactación para evitar
la fragmentación. Sin embargo, la segmentación paginada no requiere compactación.

- A: Falso, no pueden utilizar mas paginas que frames, lo que si es que aumenta el nivel de multiprogramacion
y pueden haber mas procesos ejecutando y compartiendo memoria.
- B: Falso, la segmentacion paginada aun asi necesitaria compactacion, puede sufrir de fragmentacion interna.
la paginacion no sufre de fragmentacion externa por lo tanto no necesita compactacion.


1. Explique las ventajas de tener en un Inodo tanto punteros directos como indirectos ¿Cuánta
fragmentación podría sufrir este esquema?
- Si son punteros indirectos la fragmentacion puede ser muy alta, debido a que este ocupa espacios de los bloques
solo para los punteros y si utilizamos uno de estos para asignar un espacio pequenio la fragmentacion interna seria muy grande.
- Las ventajas de usar ambos punteros es que nos permiten ampliar los tamanios maximos de archivos y al mismo tiempo tener archivos pequenios sin sufrir
fragmentacion interna


1. ¿Qué ventajas/desventajas plantea la estrategia de protección de archivos
Propietario-Grupo-Universo contra una matriz de accesos?
- Una ventaja que plantea PGU es que ocupa bastante poco espacio comparado con
la técnica de matriz de acceso que pierde mucho espacio dado que se utiliza una sola
tabla para todos los archivos del sistema, aparte si se agrega un nuevo archivo siempre
se debe agregar una nueva columna. Lo mismo si se agrega un nuevo usuario.
Una desventaja de pgu es que no tiene granularidad por usuario, si se quiere ser mas
especifico se lo tiene que complementar con una ACL. La matriz de accesos permite
especificar para cada usuario el tipo de permiso que tendrá.


