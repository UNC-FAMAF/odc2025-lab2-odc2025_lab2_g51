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

/// gaturro


//cabeza

//cachetes
 
       // linea (boca)
    mov x1, 443
    mov x2, 225
    mov x5, 32
    movz w4, 0x00, lsl 16
	movk w4, 0x0000, lsl 0
    bl circulo

        // color (boca)
    mov x1, 443
    mov x2, 225
    mov x5, 30
    movz w4, 0xFF, lsl 16
	movk w4, 0xEA55, lsl 0
    bl circulo

        // linea (cachete izq)
    mov x1, 400
    mov x2, 210
    mov x5, 57
    movz w4, 0x00, lsl 16
	movk w4, 0x00, lsl 0
    bl circulo
    
        // color (cachete izq)
    mov x1, 400
    mov x2, 210
    mov x5, 55
    movz w4, 0xFF, lsl 16
	movk w4, 0xE255, lsl 0
    bl circulo

        // linea (cachete der)
    mov x1, 485
    mov x2, 210
    mov x5, 57
    movz w4, 0x00, lsl 16
	movk w4, 0x00, lsl 0
    bl circulo

        // color (cachete izq)
    mov x1, 400
    mov x2, 210
    mov x5, 55
    movz w4, 0xFF, lsl 16
	movk w4, 0xE255, lsl 0
    bl circulo

        // color (cachete der)
    mov x1, 485
    mov x2, 210
    mov x5, 55
    movz w4, 0xFF, lsl 16
	movk w4, 0xE255, lsl 0
    bl circulo



////OJO 

    mov x1, 425
    mov x2, 135
    mov x5, 30
    movz w4, 0xFF, lsl 16
	movk w4, 0xFFFF, lsl 0
    bl circulo

    mov x1, 425
    mov x2, 150
    mov x5, 30
    movz w4, 0xFF, lsl 16
	movk w4, 0xFFFF, lsl 0
    bl circulo



    mov x1, 465
    mov x2, 135
    mov x5, 30
    movz w4, 0xFF, lsl 16
	movk w4, 0xFFFF, lsl 0
    bl circulo

    mov x1, 465
    mov x2, 150
    mov x5, 30
    movz w4, 0xFF, lsl 16
	movk w4, 0xFFFF, lsl 0
    bl circulo




/// nariz

    mov x1, 443
    mov x2, 190
    mov x5, 10
    movz w4, 0xF6, lsl 16
	movk w4, 0x89E3, lsl 0
    bl circulo

    mov x1, 456
    mov x2, 180
    mov x5, 10
    movz w4, 0xF6, lsl 16
	movk w4, 0x89E3, lsl 0
    bl circulo

    mov x1, 430
    mov x2, 180
    mov x5, 10
    movz w4, 0xF6, lsl 16
	movk w4, 0x89E3, lsl 0
    bl circulo

    mov x1, 443
    mov x2, 177
    mov x5, 10
    movz w4, 0xF6, lsl 16
	movk w4, 0x89E3, lsl 0
    bl circulo

    mov x0, x20
    mov x1, 443      // x
    mov x2, 200        // y
    mov x5, 55       // largo
    movz w4, 0x00, lsl 16
	movk w4, 0x0000, lsl 0
    bl linea_vertical

    mov x0, x20
    mov x1, 444      // x
    mov x2, 115        // y
    mov x5, 55       // largo
    movz w4, 0x00, lsl 16
	movk w4, 0x0000, lsl 0
    bl linea_vertical
//// lentes

    mov x1, 440      // x
    mov x2, 150       // y
    mov x5, 30       // largo
    mov x6, 10     // alto
    movz w4, 0x00, lsl 16
	movk w4, 0x0000, lsl 0
    bl llenar_cuadrado


    mov x1, 385      // x
    mov x2, 140       // y
    mov x5, 55     // largo
    mov x6, 35     // alto
    movz w4, 0x00, lsl 16
	movk w4, 0x0000, lsl 0
    bl llenar_cuadrado



    mov x1, 455      // x
    mov x2, 140       // y
    mov x5, 55      // largo
    mov x6, 35     // alto
    movz w4, 0x00, lsl 16
	movk w4, 0x0000, lsl 0
    bl llenar_cuadrado
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
