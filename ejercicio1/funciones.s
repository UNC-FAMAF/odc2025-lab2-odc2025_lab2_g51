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


linea_vertical:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x27, x28, [sp, -16]!


    mov x27, x1   // eje X
    mov x28, x2   // eje y
    mov x9, x5    // cantidad de pixeles de largo

    loopB:
    mov x1, x27        // x actual
    mov x2, x28        // y actual
    bl pixel

    add x28, x28, 1   // x27 = x27 + 1
    sub x9, x9, 1     // x9 = x9 - 1
    cbnz x9, loopB    // si x9 != 0, loopB

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

//linea diagonal que avanza hacia abajo a la derecha
linea_diagonal:
    stp x29, x30, [sp, -16]!  // reserva memoria
    mov x29, sp
    stp x27, x28, [sp, -16]!
    stp x25, x26, [sp, -16]!
    stp x23, x24, [sp, -16]!


    mov x27, x1   // eje X
    mov x28, x2   // eje y
    mov x25, x5    // largo de la linea
    mov x24, x6     // cuantas lineas dura


loopD:
    mov x1, x27        // x actual
    mov x2, x28        // y actual
    mov x5, x25    // cantidad de pixeles a avanzar
    bl linea_horizontal

    add x27, x27, 1    // eje x - 1
    add x28, x28, 1   // eje y - 1
    sub x24, x24, 1     // cantidad de lineas - 1

    cbnz x24, loopD        // si (x24 != 0), loopD

    ldp x23, x24, [sp], 16      //libera memoria
    ldp x25, x26, [sp], 16
    ldp x27, x28, [sp], 16
    ldp x29, x30, [sp], 16
ret


// mismo que la funcion anterior pero avanza hacia arriba a la derecha
linea_diagonal2:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x27, x28, [sp, -16]!
    stp x25, x26, [sp, -16]!
    stp x23, x24, [sp, -16]!


    mov x27, x1   // eje X
    mov x28, x2   // eje y
    mov x25, x5    // largo de la linea
    mov x26, x6     // cuantas lineas dura el loop
    mov x24, 0     //contador


loopE:
    mov x1, x27        // x actual
    mov x2, x28        // y actual
    mov x5, x25    // cantidad de pixeles a avanzar
    bl linea_horizontal

    sub x28, x28, 1     // eje x - 1
    add x27, x27, 1     // eje y - 1
    add x24, x24, 1     // contador + 1
    cmp x26, x24        // compara x26 y x24
    b.ge loopE         // si x26 es mayor que x24, loopE. Sino termina


    ldp x23, x24, [sp], 16     // libera memoria
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


dentro_circulo:

        // teniendo en cuenta la formula de la circunferencia   (x - h)^2 + (y - k)^2 = r^2
        // si un valor es <= a r^2, estará dentro del circulo, sino afuera de este

    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x27, x28, [sp, -16]!
    stp x25, x26, [sp, -16]!
    stp x23, x24, [sp, -16]!
    stp x21, x22, [sp, -16]!
    stp x19, x20, [sp, -16]!

    mov x27, x3   // eje X de centro
    mov x28, x5   // eje y de centro
    mov x25, x6    // radio

    mul x26, x25, x25  // r^2
    sub x24, x10, x27  // (x - h)
    mul x24, x24, x24  // (x - h)^2
    sub x23, x11, x28  // (y - k)
    mul x23, x23, x23  // (y - k)^2
    add x22, x24, x23  // (x - h)^2 + (y - k)^2

    cmp x22, x26       // si x22 es menor que el radio^2, pinta un pixel
    b.ge fuera

    mov x1, x10       // x
    mov x2, x11       // y
    
    bl pixel

fuera:
    ldp x19, x20, [sp], 16
    ldp x21, x22, [sp], 16 
    ldp x23, x24, [sp], 16     // libera memoria
    ldp x25, x26, [sp], 16
    ldp x27, x28, [sp], 16
    ldp x29, x30, [sp], 16

ret

circulo:

    // ahora busco ver donde empieza y donde termina el circulo en los ejes
    // para eso haga (centro x - radio) y (centro x + radio) y los mismo en el eje y

    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x27, x28, [sp, -16]!
    stp x25, x26, [sp, -16]!
    stp x23, x24, [sp, -16]!
    stp x21, x22, [sp, -16]!


    mov x27, x1   // eje X de centro
    mov x28, x2   // eje y de centro
    mov x25, x5    // radio
    


    sub x24, x27, x25 // (centro x - radio)
    add x23, x27, x25 // (centro x + radio)

    sub x22, x28, x25 // (centro y - radio)
    add x21, x28, x25 // (centro y + radio)


    

loopY:
    cmp x22, x21
    b.gt fin_y

    mov x26, x24

loopX:
    cmp x26, x23
    b.gt sig_y

    mov x10, x26        // x
    mov x11, x22        // y

    mov x3, x27         // centro x
    mov x5, x28         // centro y
    mov x6, x25         // radio

    bl dentro_circulo

    add x26, x26, 1
    b loopX

sig_y: 
    add x22, x22, 1
    b loopY

fin_y:
    ldp x21, x22, [sp], 16
    ldp x23, x24, [sp], 16     // libera memoria
    ldp x25, x26, [sp], 16
    ldp x27, x28, [sp], 16
    ldp x29, x30, [sp], 16
ret

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

