.include "funcionesFondo.s"
.include "dibujos.s"

delay:
    stp x29, x30, [sp, -16]! 
    mov x29, sp
    str x19, [sp, -8]! 

    mov x19, x18 // x18 es la duración, se copia este valor en x19

loop_delay:
    subs x19, x19, 1 // resta 1 a la duracion
    cbnz x19, loop_delay // si no es cero el loop sigue
  
    ldr x19, [sp], 8 
    ldp x29, x30, [sp], 16 
    ret

partes:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x19, x20, [sp, -16]!
    bl fondo_letras
    
    bl silla
    bl gaturro
    bl lentes
    bl mesa
    bl lampara
    bl teclado
       ldp x19, x20, [sp], 16
    ldp x29, x30, [sp], 16
    ret
ret

animacion_mano:

    mov x19, 300
    mov x20, 320
    mov x21, 320
    mov x22, 320
    mov x23, 318
    mov x24, 330
    mov x25, 370
    mov x26, 320
    mov x27, 320

    mov x28,  14 // duracion

loopmano:
    mov x18, 0xffffff
    bl delay

    bl fondo_mano
    mov x18, 0xfff
    bl delay
    // mano al final, así queda arriba
    bl mano

    // moviemiento para abajo de la mano
    add x19, x19, 1
    add x20, x20, 1
    add x21, x21, 1
    add x22, x22, 1
    add x23, x23, 1
    add x24, x24, 1
    add x25, x25, 1
    add x26, x26, 1
    add x27, x27, 1

    subs x28, x28, 1
    cbnz x28, loopmano
    mov x18, 0xfffffff
    mov x28,  14 // duracion
    bl delay
    
    b animacion_mano
ret

fondo_letras:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x19, x20, [sp, -16]!
        
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

    ldp x19, x20, [sp], 16
    ldp x29, x30, [sp], 16
ret

fondo_mano:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x19, x20, [sp, -16]!

    mov x1, 327
    mov x2, 299
    mov x5, 53
    mov x6, 90
    mov w4 , 0x00
    bl llenar_cuadrado
    
    mov x1, 336
    mov x2, 296
    ldr x3, =letra_O
    mov w4, 0x00FF00  
    bl dibujar_letra

    mov x1, 336
    mov x2, 304
    ldr x3, =numero_2
    mov w4, 0x00FF00  
    bl dibujar_letra

    mov x1, 336
    mov x2, 342
    ldr x3, =letra_C
    mov w4, 0x00FF00  
    bl dibujar_letra

    mov x1, 352
    mov x2, 296
    ldr x3, =letra_D
    mov w4, 0x00FF00  
    bl dibujar_letra
    
    mov x1, 368
    mov x2, 296
    ldr x3, =numero_5
    mov w4, 0x00FF00  
    bl dibujar_letra

    mov x1, 350            // x
    mov x2, 360            // y
    mov x5, 160            // largo
    movz w4, 0xFFFF, lsl 0    
    movk w4, 0x00FF, lsl 16    
    bl linea_horizontal

    mov x1, 340            // x
    mov x2, 370            // y
    mov x5, 160            // largo
    movz w4, 0xFFFF, lsl 0    
    movk w4, 0x00FF, lsl 16 
    bl linea_horizontal

    mov x1, 330            // x
    mov x2, 380            // y
    mov x5, 160            // largo
    movz w4, 0xFFFF, lsl 0    
    movk w4, 0x00FF, lsl 16 
    bl linea_horizontal

    mov x1, 320          // x inicial
    mov x2, 400          // y inicial
    mov x5, 1            // ancho de línea
    mov x6, 40           // alto de línea
    bl linea_diagonal2

    mov x1, 339          // x inicial
    mov x2, 400          // y inicial
    mov x5, 1            // ancho de línea
    mov x6, 40           // alto de línea
    bl linea_diagonal2


    mov x1, 350          // x inicial
    mov x2, 390          // y inicial
    mov x5, 20            // ancho de línea
    mov x6, 10           // alto de línea
    bl linea_diagonal2


    mov w4, #0x0000
    mov x1, 365         // centro x del círculo
    mov x2, 385         // centro y del círculo
    mov x5, 5          // radio
    bl circulo

    movz w4, 0x6633
    movk w4, 0x0099, lsl #16
    mov x1, 325              // x inicial
    mov x2, 350             // y inicial
    mov x5, 60             // ancho
    mov x6, 10              // alto
    bl llenar_cuadrado


    movz w4, 0x6633
    movk w4, 0x0099, lsl #16
    mov x1, 308          // x inicial
    mov x2, 379          // y inicial
    mov x5, 22            // ancho de línea
    mov x6, 22           // alto de línea
    bl linea_diagonal2

    movz w4, 0x6633
    movk w4, 0x0099, lsl #16
    mov x1, 324         // centro x del círculo
    mov x2, 379         // centro y del círculo
    mov x5, 5          // radio
    bl circulo

    mov x1, 350     // x
    mov x2, 305       // y
    mov x5, 50      // largo
    mov x6, 16     // alto
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl llenar_cuadrado

    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    mov x1, 350         // centro x del círculo
    mov x2, 327         // centro y del círculo
    mov x5, 22          // radio
    bl circulo

    ldp x19, x20, [sp], 16
    ldp x29, x30, [sp], 16
ret
