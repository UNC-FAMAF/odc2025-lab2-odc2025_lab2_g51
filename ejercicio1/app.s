	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480			//definicion de contantes simbolicas tamano del framebuffer
	.equ BITS_PER_PIXEL,  	32			//tamanos de direccion de memoria de cada pixel

	.globl main

main:
	// x0 contiene la direccion base del framebuffer
 	mov x20, x0	// Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------
    
	mov w10, 0x00000000   //setea el color negro

	mov x2, SCREEN_HEIGH         // Y Size
loop1:
	mov x1, SCREEN_WIDTH         // X Size
loop0:
	stur w10,[x0]  
	add x0,x0,4	   
	sub x1,x1,1	   
	cbnz x1,loop0  
	sub x2,x2,1	   
	cbnz x2,loop1  
	//hasta aca la pantalla esta en negro
    ldr x3, =letra_Y
    mov x0, x20        // framebuffer
    mov x1, 100        // x
    mov x2, 100        // y
    mov w4, 0x00FF00   // verdes
    bl dibujar_letra

InfLoop:
	b InfLoop

// FUNCION DIBUJAR LETRA: PARAMETROS QUE TOMA
// x0 = framebuffer base
// x1 = posición X inicial
// x2 = posición Y inicial
// x3 = puntero al bitmap
// w4 = color ARGB

// parametros configurables:
.equ BLOQUE_TAM,     2       // tamano de cada pixel que confoma la letra
.equ LETRA_ANCHO,    5       // tamano del array del bitmap 5x7 en este caso
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
    lsl x16, x16, #1              // CAMBIAR #N PARA CONFIGURAR TAMANO
    add x16, x1, x16
    add x16, x16, x15

    mov x17, x10
    lsl x17, x17, #1              // CAMBIAR #N PARA CONFIGURAR TAMANO
    add x17, x2, x17
    add x17, x17, x14


    mov x18, 640
    mul x18, x17, x18
    add x18, x18, x16
    lsl x18, x18, 2
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

    br x30

letra_Y:
    .byte 0b10001
    .byte 0b01010
    .byte 0b00100
    .byte 0b00100
    .byte 0b00100
    .byte 0b00100
    .byte 0b00100


    
