	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480			//definicion de contantes simbolicas tamano del framebuffer
	.equ BITS_PER_PIXEL,  	32			//tamanos de direccion de memoria de cada pixel
    .equ NUM_LETRAS, 8

    #include "simbolos.s"
    .include "dibujos.s"
    .include "funcionesFondo.s" 
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
    // imagen 
    bl silla
    bl gaturro
    bl lentes
    bl mesa
    bl lampara
    bl teclado
    bl mano

InfLoop:
    b InfLoop


