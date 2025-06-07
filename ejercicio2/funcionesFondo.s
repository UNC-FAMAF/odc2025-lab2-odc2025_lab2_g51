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

    mov x21, x1      // guardar posición X de la columna
    mov x22, x2      // Y actual
    mov x23, x3      // puntero a tabla de letras
    mov w24, w4      // color

    mov x27, 0       // índice de letra

.loop_columna:
    ldr x26, [x23, x27, lsl #3]
    // preparar y llamar a dibujar_letra
    mov x1, x21       
    mov x2, x22       
    mov x3, x26
    mov w4, w24
    bl dibujar_letra

    add x27, x27, 1
    cmp x27, 8
    blt .skip_reset
    mov x27, 0        // reinicia si llegó al final

.skip_reset:
    add x22, x22, 8 
    cmp x22, #488
    blt .loop_columna

    ldr x27,  [sp], 16
    ldp x25, x26, [sp], 16
    ldp x23, x24, [sp], 16
    ldp x21, x22, [sp], 16
    ldp x29, x30, [sp], 16    
    
    ret
