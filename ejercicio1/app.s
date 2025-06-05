	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480			//definicion de contantes simbolicas tamano del framebuffer
	.equ BITS_PER_PIXEL,  	32			//tamanos de direccion de memoria de cada pixel
    .equ NUM_LETRAS, 8

    #include "simbolos.s"
    .include "funciones.s"
	.globl main

main:

mov x20, x0
mov w4, 0x00FF00
mov x1, 0
mov x5, 0

ldr x6, =tabla_general

loop:
    mov x2, 0

    // cargar puntero a tabla desde tabla_general[x5]
    ldr x3, [x6, x5, lsl #3]

    bl lluvia_columna_secuencial

    add x1, x1, #16
    add x5, x5, #1
    cmp x5, #8
    blt .no_reset
    mov x5, 0
.no_reset:
    cmp x1, #640
    blt loop

/// silla

 // respaldo

    mov x1, 440            // x
    mov x2, 140            // y
    mov x5, 150            // largo
    mov x6, 250            // alto
    movz w4, 0x52, lsl 16
    movk w4, 0x4D47, lsl 0
    bl llenar_cuadrado

    mov x1, 515    // centro x del círculo
    mov x2, 190    // centro y del círculo
    mov x5, 75    // radio
    bl circulo

    mov x1, 460            // x
    mov x2, 320            // y
    mov x5, 130            // largo
    movz w4, 0x75, lsl 16
    movk w4, 0x6E66, lsl 0
    bl linea_horizontal

    mov x1, 460            // x
    mov x2, 310            // y
    mov x5, 110            // largo
    bl linea_horizontal

    mov x1, 460            // x
    mov x2, 190            // y
    mov x5, 110            // largo
    bl linea_horizontal

    mov x1, 460            // x
    mov x2, 160            // y
    mov x5, 110            // largo
    bl linea_horizontal

    mov x1, 490            // x
    mov x2, 130             // y
    mov x5, 50            // largo
    bl linea_horizontal


/// gaturro

///cuerpo

//torso
    mov x1, 470      // x
    mov x2, 300       // y
    mov x5, 80       // largo
    mov x6, 70     // alto
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl llenar_cuadrado


    mov x1, 510
    mov x2, 340
    mov x5, 25
    movz w4, 0xFF, lsl 16
	movk w4, 0xE255, lsl 0
    bl circulo


/// brazo izq

    mov x1, 340     // x
    mov x2, 305       // y
    mov x5, 140      // largo
    mov x6, 16     // alto
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl llenar_cuadrado


   // brazo der
    mov x1, 530          // x inicial
    mov x2, 300          // y inicial
    mov x5, 30            // ancho de línea
    mov x6, 60           // alto de línea
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl linea_diagonal


//cabeza

//cachetes
 
       // linea (boca)
    mov x1, 513
    mov x2, 275
    mov x5, 32
    movz w4, 0x00, lsl 16
	movk w4, 0x0000, lsl 0
    bl circulo

        // color (boca)
    mov x1, 513
    mov x2, 275
    mov x5, 30
    movz w4, 0xFF, lsl 16
	movk w4, 0xEA55, lsl 0
    bl circulo

        // linea (cachete izq)
    mov x1, 470
    mov x2, 260
    mov x5, 57
    movz w4, 0x00, lsl 16
	movk w4, 0x00, lsl 0
    bl circulo
    
        // color (cachete izq)
    mov x1, 470
    mov x2, 260
    mov x5, 55
    movz w4, 0xFF, lsl 16
	movk w4, 0xE255, lsl 0
    bl circulo

        // linea (cachete der)
    mov x1, 555
    mov x2, 260
    mov x5, 57
    movz w4, 0x00, lsl 16
	movk w4, 0x00, lsl 0
    bl circulo

        // color (cachete izq)
    mov x1, 470
    mov x2, 260
    mov x5, 55
    movz w4, 0xFF, lsl 16
	movk w4, 0xE255, lsl 0
    bl circulo

        // color (cachete der)
    mov x1, 555
    mov x2, 260
    mov x5, 55
    movz w4, 0xFF, lsl 16
	movk w4, 0xE255, lsl 0
    bl circulo



////OJO 

//blanco

    mov x1, 500
    mov x2, 185
    mov x5, 30
    movz w4, 0xFF, lsl 16
	movk w4, 0xFFFF, lsl 0
    bl circulo

    mov x1, 500
    mov x2, 195
    mov x5, 30
    movz w4, 0xFF, lsl 16
	movk w4, 0xFFFF, lsl 0
    bl circulo



    mov x1, 530
    mov x2, 185
    mov x5, 30
    movz w4, 0xFF, lsl 16
	movk w4, 0xFFFF, lsl 0
    bl circulo

    mov x1, 530
    mov x2, 195
    mov x5, 30
    movz w4, 0xFF, lsl 16
	movk w4, 0xFFFF, lsl 0
    bl circulo



/// nariz

    mov x1, 513
    mov x2, 240
    mov x5, 10
    movz w4, 0xF6, lsl 16
	movk w4, 0x89E3, lsl 0
    bl circulo

    mov x1, 526
    mov x2, 230
    mov x5, 10
    movz w4, 0xF6, lsl 16
	movk w4, 0x89E3, lsl 0
    bl circulo

    mov x1, 500
    mov x2, 230
    mov x5, 10
    movz w4, 0xF6, lsl 16
	movk w4, 0x89E3, lsl 0
    bl circulo

    mov x1, 513
    mov x2, 227
    mov x5, 10
    movz w4, 0xF6, lsl 16
	movk w4, 0x89E3, lsl 0
    bl circulo

    mov x1, 513      // x
    mov x2, 250        // y
    mov x5, 50       // largo
    movz w4, 0x00, lsl 16
	movk w4, 0x0000, lsl 0
    bl linea_vertical

    mov x1, 514      // x
    mov x2, 162        // y
    mov x5, 55       // largo
    movz w4, 0x00, lsl 16
	movk w4, 0x0000, lsl 0
    bl linea_vertical

/// orejas
    mov x1, 465
    mov x2, 195
    mov x5, 30   // base
    mov x5, 10
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl circulo

    mov x1, 560
    mov x2, 195
    mov x5, 30   // base
    mov x5, 10
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl circulo



//// lentes

    mov x1, 490      // x
    mov x2, 200       // y
    mov x5, 30       // largo
    mov x6, 10     // alto
    movz w4, 0x00, lsl 16
	movk w4, 0x0000, lsl 0
    bl llenar_cuadrado


    mov x1, 450      // x
    mov x2, 190       // y
    mov x5, 55    // largo
    mov x6, 35     // alto
    movz w4, 0x00, lsl 16
	movk w4, 0x0000, lsl 0
    bl llenar_cuadrado


    mov x1, 515      // x
    mov x2, 190       // y
    mov x5, 55      // largo
    mov x6, 35     // alto
    movz w4, 0x00, lsl 16
	movk w4, 0x0000, lsl 0
    bl llenar_cuadrado


    //mesa
    movz w4, 0x6633
    movk w4, 0x0099, lsl #16
    mov x1, 20              // x inicial
    mov x2, 450             // y inicial
    mov x5, 620             // ancho
    mov x6, 30              // alto
    bl llenar_cuadrado

    mov x1, 120            // posición x
    mov x2, 350            // posición y
    mov x5, 520            // ancho del rectángulo
    mov x6, 100            // alto del rectángulo
    bl llenar_cuadrado

    mov x1, 20        // posición X de inicio
    mov x2, 450        // posición Y de inicio
    mov x5, 100         // base
    mov x6, 100         // altura
    bl triangulo_rectangulo_reflejado

    mov x1, 10         // posición X (ajustá según necesidad)
    mov x2, 450        // posición Y (ajustá según necesidad)
    mov w4, 0x000000   // color negro
    mov x5, 630        // largo de la línea en píxeles
    bl linea_horizontal

    // Pantalla (cuadrado grande)
    mov x1, 100        // x inicial
    mov x2, 270        // y inicial (más arriba de la mesa)
    mov x5, 200        // ancho
    mov x6, 120         // alto
    movz w4, 0x2422
    movk w4, 0x0021, lsl #16
    bl llenar_cuadrado

    //// Soporte vertical 
    mov x1, 190        // x inicial
    mov x2, 350        // y inicial 
    mov x5, 20        // ancho
    mov x6, 80         // alto
    movz w4, 0x302D
    movk w4, 0x002C, lsl #16
    bl llenar_cuadrado

    //// soporte hhorizontal
    mov x1, 110        // x inicial
    mov x2, 420        // y inicial 
    mov x5, 180        // ancho
    mov x6, 20         // alto
    movz w4, 0x302D
    movk w4, 0x002C, lsl #16
    bl llenar_cuadrado
    
    mov w4, #0x0000
    mov x1, 200         // centro x del círculo
    mov x2, 340         // centro y del círculo
    mov x5, 25          // radio
    bl circulo

    mov x1, 140          // x inicial
    mov x2, 280          // y inicial
    mov x5, 1            // ancho de línea
    mov x6, 60           // alto de línea
    bl linea_diagonal

    mov x1, 210          // x inicial
    mov x2, 330          // y inicial
    mov x5, 1            // ancho
    mov x6, 50           // alto
    bl linea_diagonal2

    mov x1, 188         // X inicial
    mov x2, 330         // Y inicial
    mov x5, 60         // alto
    mov x6, 1           // grosor
    bl linea_vertical

    mov x1, 211         // X inicial
    mov x2, 330         // Y inicial
    mov x5, 60         // alto
    mov x6, 1           // grosor
    bl linea_vertical





/// mano
    /// mano
    mov x1, 340     // x
    mov x2, 300       // y
    mov x5, 40      // largo
    mov x6, 40     // alto
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl llenar_cuadrado

    /// parte redonda de la mano
    mov x1,350     // x
    mov x2, 320      // y
    mov x5, 22
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl circulo

    // linea dedo
    mov x1, 345     // x
    mov x2, 320      // y
    mov x5, 22
    movz w4, 0xba, lsl 16
	movk w4, 0x8207, lsl 0
    bl circulo


    // dedo
    mov x1,350     // x
    mov x2, 320      // y
    mov x5, 22
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl circulo

        /// linea dedo indice
    mov x1, 343        // X inicial
    mov x2, 318         // Y inicial
    mov x5, 25         // alto
    mov x6, 1           // grosor
    movz w4, 0xba, lsl 16
	movk w4, 0x8207, lsl 0
    bl linea_vertical


 



    /// dedo indice
    mov x1, 359     // x
    mov x2, 330      // y
    mov x5, 15      // largo
    mov x6, 40     // alto
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl llenar_cuadrado

    /// punta del dedo
    mov x1, 366     // x
    mov x2, 370      // y
    mov x5, 8
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl circulo

        /// linea dedo indice
    mov x1, 374        // X inicial
    mov x2, 320         // Y inicial
    mov x5, 57         // alto
    mov x6, 1           // grosor
    movz w4, 0xba, lsl 16
	movk w4, 0x8207, lsl 0
    bl linea_vertical

            /// linea dedo indice
    mov x1, 359        // X inicial
    mov x2, 320         // Y inicial
    mov x5, 57         // alto
    mov x6, 1           // grosor
    movz w4, 0xba, lsl 16
	movk w4, 0x8207, lsl 0
    bl linea_vertical




    /// lampara

    mov x1, 91   // centro x del círculo
    mov x2, 50    // centro y del círculo
    mov x5, 20    // radio
    movz w4, 0xFF, lsl 16
    movk w4, 0xFFCC, lsl 0
    bl circulo

    mov x1, 80       // x inicial
    mov x2, 0        // y inicial 
    mov x5, 21        // ancho
    mov x6, 30         // alto
    movz w4, 0x9185
    movk w4, 0x007F, lsl #16
    bl llenar_cuadrado

    mov x1, 46	  // x inicial
    mov x2, 50   // y inicial
    mov x5, 90   // base
    mov x6, 40     // altura
    bl triangulo_equilatero





InfLoop:
    b InfLoop

// FUNCION DIBUJAR LETRA: PARAMETROS QUE TOMA
// x0 = framebuffer base
// x1 = posición X inicial
// x2 = posición Y inicial
// x3 = puntero al bitmap
// w4 = color ARGB

// parametros configurables:
.equ BLOQUE_TAM,     1       // tamano de cada pixel que confoma la letra
.equ LETRA_ANCHO,    5       // tamano del array del bitmap 5x7 en este caso, si se cambia, tambien debe cambiar el tamano del bitmap
.equ LETRA_ALTO,     7       

dibujar_letra:
    mov x10, 0

.fila_ciclo:
    ldrb w12, [x3, x10]
    mov w11, 0

.columna_ciclo:
    mov w13, 1
    lsl w13, w13, w11
    and w14, w12, w13
    cbz w14, .skip_pixel
    
    mov x14, 0
.bloque_fila:
    mov x15, 0
.bloque_columna:


    uxtw x16, w11 
    lsl x16, x16, #0              // CAMBIAR #N PARA CONFIGURAR TAMANO
    add x16, x1, x16
    add x16, x16, x15

    mov x17, x10
    lsl x17, x17, #0              // CAMBIAR #N PARA CONFIGURAR TAMANO
    add x17, x2, x17
    add x17, x17, x14


    mov x18, 640
    mul x18, x17, x18
    add x18, x18, x16
    lsl x18, x18, #2
    add x18, x0, x18

    // Pinta pixel
    str w4, [x18]
    
    add x15, x15, 1
    cmp x15, BLOQUE_TAM
    blt .bloque_columna

    add x14, x14, 1
    cmp x14, BLOQUE_TAM
    blt .bloque_fila

.skip_pixel:
    add w11, w11, 1
    cmp w11, LETRA_ANCHO
    blt .columna_ciclo

    add x10, x10, 1
    cmp x10, LETRA_ALTO
    blt .fila_ciclo

    ret

lluvia_columna_secuencial:
    stp x29, x30, [sp, -16]!     
    mov x29, sp
    stp x21, x22, [sp, -16]!
    stp x23, x24, [sp, -16]!
    stp x25, x26, [sp, -16]!
    str x27, [sp, -16]!


    mov x21, x1       // guardar posición X de la columna
    mov x22, x2      // y actual
    mov x23, x3      // puntero a tabla de letras
    mov w24, w4      // color

    mov x27, 0       // índice de letra

.loop_columna:
    // cargar letra desde la tabla: letra = tabla[x10]
    ldr x26, [x23, x27, lsl #3]
    // preparar y llamar a dibujar_letra
    mov x1, x21       
    mov x2, x22       
    mov x3, x26
    mov w4, w24
    bl dibujar_letra

    // avanzar en tabla
    add x27, x27, 1
    cmp x27, 8
    blt .skip_reset
    mov x27, 0        // reinicia si llegó al final

.skip_reset:
    // avanzar verticalmente
    add x22, x22, 8 
    cmp x22, #488
    blt .loop_columna

    ldr x27,  [sp], 16
    ldp x25, x26, [sp], 16
    ldp x23, x24, [sp], 16
    ldp x21, x22, [sp], 16
    ldp x29, x30, [sp], 16    
    
    ret
