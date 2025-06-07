Nombre y apellido 
Integrante 1: Franco Galassi
Integrante 2: Dylan Alexis Machado
Integrante 3: Máximo Ortega Oviedo
Integrante 4: Joaquín Emiliano Pairetti


Descripción ejercicio 1: Imagen de gaturro en su setup con una estetica al estilo de la pelicula Matrix.


Descripción ejercicio 2: Animacion de gaturro al estilo matrix apretando varias veces una tecla.


Justificación instrucciones ARMv8:
                            uxtw: Utilizada en funcion para el fondo, para extender registro de 32 bits a 64 para compatibilizar operaciones con registros de 64 bits.
                            ldrb: Instrucción de carga de un byte desde memoria en un registro de 32 bits. Fue utilizada para acceder a la matriz de bits de las letras, donde cada fila es representada por un byte.
                            stp: Guardado (stp) de múltiples registros en la pila antes y después de llamar a subrutinas (como lluvia_columna_secuencial). LEGv8 no incluye estas instrucciones para manipular el stack.
                            ldp: muy similar a stp pero para liberar los registros.
                            ldr: Utilizada para cargar direcciones de etiquetas (por ejemplo, ldr x0, =tabla_letras). uso mas simple que ldur.
                            mov/cmp: si bien son pseudoinstrucciones de LEGv8, estrictamente no pertenecen como intrucciones de esta. Creemos que es redundante justificar su uso.
 


