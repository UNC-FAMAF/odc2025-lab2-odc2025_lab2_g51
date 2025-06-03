	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480


posicion:
    mov x10, x1        // eje x
    mov x11, x2        // eje y
    mov x12, SCREEN_WIDTH
    mul x11, x11, x12  // y * SCREEN_WIDTH
    add x11, x11, x10  // y * WIDTH + x
    lsl x11, x11, 2   // (y * WIDTH + x) * 4 (bytes por pixel)
    add x0, x0, x11    
    ret



pixel:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x27, x28, [sp, -16]!


    mov x5, x0 
    bl posicion
    mov x7, x0
    mov x0, x5
    str w4, [x7]

    ldp x27, x28, [sp], 16
    ldp x29, x30, [sp], 16
    ret



linea_horizontal:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x27, x28, [sp, -16]!


    mov x27, x1   // eje X
    mov x28, x2   // eje y
    mov x9, x5    // cantidad de pixeles de alto


loopA:
    mov x1, x27        // x actual
    mov x2, x28        // y actual
    bl pixel

    add x27, x27, 1   // x27 = x27 + 1
    sub x9, x9, 1     // x9 = x9 - 1
    cbnz x9, loopA    // si x9 != 0, loopA

    ldp x27, x28, [sp], 16
    ldp x29, x30, [sp], 16
ret




llenar_cuadrado:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x27, x28, [sp, -16]!
    stp x25, x26, [sp, -16]!

    mov x27, x1   // eje X
    mov x28, x2   // eje y
    mov x25, x5   // cantidad de pixeles largo 
    mov x26, x6   // cantidad de pixeles alto

loopC:
    mov x1, x27        // x actual
    mov x2, x28        // y actual
    mov x5, x25    // cantidad de pixeles a avanzar
    bl linea_horizontal
    
    add x28, x28, 1   // x28 = x28 + 1
    sub x26, x26, 1     // x26 = x26 - 1
    
    
    cbnz x26, loopC    // si x9 != 0, loopC


    ldp x25, x26, [sp], 16
    ldp x27, x28, [sp], 16
    ldp x29, x30, [sp], 16
ret




triangulo_rectangulo:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x27, x28, [sp, -16]!
    stp x25, x26, [sp, -16]!
    stp x23, x24, [sp, -16]!

    mov x27, x1   // eje X
    mov x28, x2   // eje y
    mov x25, x5    // base
    mov x26, x6     // altura
    mov x24, 0     //contador

loopF:
    mov x1, x27        // x actual
    mov x2, x28        // y actual
    mov x5, x25    // cantidad de pixeles a avanzar
    bl linea_horizontal

    sub x28, x28, 1     // (eje y - 1)  sube una linea
    sub x25, x25, 1
    add x24, x24, 1
    cmp x24, x26        // compara x26 y x24
    b.lt loopF         // loopF si x26 es mayor que x24. Sino termina

    ldp x23, x24, [sp], 16     // libera memoria
    ldp x25, x26, [sp], 16
    ldp x27, x28, [sp], 16
    ldp x29, x30, [sp], 16
ret



obtuso:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x27, x28, [sp, -16]!
    stp x25, x26, [sp, -16]!

    mov x27, x1   // eje X
    mov x28, x2   // eje y
    mov x25, x5    // diametro


loopG:
    mov x1, x27        // x actual
    mov x2, x28        // y actual
    mov x5, x25    // cantidad de pixeles a avanza
    bl linea_horizontal

    sub x27, x27, 1
    sub x28, x28, 1

    sub x25, x25, 1

    cbnz x25, loopG

    ldp x25, x26, [sp], 16
    ldp x27, x28, [sp], 16
    ldp x29, x30, [sp], 16
ret

triangulo_rectangulo_reflejado:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x27, x28, [sp, -16]!
    stp x25, x26, [sp, -16]!
    stp x23, x24, [sp, -16]!

    mov x27, x1   // eje X
    mov x28, x2   // eje y
    mov x25, x5    // diametro
    mov x26, x6     // alto
    mov x24, 0     //contador


loopH:
    mov x1, x27        // x actual
    mov x2, x28        // y actual
    mov x5, x25    // cantidad de pixeles a avanzar

    bl linea_horizontal

    sub x28, x28, 1     // (eje y - 1)  sube una linea
    add x27, x27, 1     // (eje x - 1)  
    sub x25, x25, 1     // (base - 2)

    add x24, x24, 1
    cmp x24, x26
    b.lt loopH

    ldp x23, x24, [sp], 16     // libera memoria
    ldp x25, x26, [sp], 16
    ldp x27, x28, [sp], 16
    ldp x29, x30, [sp], 16
ret


triangulo_equilatero:

    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x27, x28, [sp, -16]!
    stp x25, x26, [sp, -16]!
    stp x23, x24, [sp, -16]!

    mov x27, x1   // eje X
    mov x28, x2   // eje y
    mov x25, x5    // base
    mov x26, x6     // alto


loopI:
    mov x1, x27        // x actual
    mov x2, x28        // y actual
    mov x5, x25    // cantidad de pixeles a avanzar

    bl linea_horizontal

    sub x28, x28, 1     // (eje y - 1)  sube una linea
    add x27,x27, 1
    sub x25, x25, 2    // (base - 2)


    sub x26, x26, 1
    cbnz x26, loopI

    ldp x23, x24, [sp], 16     // libera memoria
    ldp x25, x26, [sp], 16
    ldp x27, x28, [sp], 16
    ldp x29, x30, [sp], 16
ret



