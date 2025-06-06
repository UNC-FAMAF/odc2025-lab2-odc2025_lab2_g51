	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480			//definicion de contantes simbolicas tamano del framebuffer
	.equ BITS_PER_PIXEL,  	32			//tamanos de direccion de memoria de cada pixel
    .equ NUM_LETRAS, 8

    #include "simbolos.s"
    .include "funciones.s"
	.globl main

main:

// animacion
//bl fondo_negro
//bl fondo_letras
bl partes
bl animacion_mano
bl fondo_mano
//bl animacion_letras


InfLoop:
    b InfLoop
