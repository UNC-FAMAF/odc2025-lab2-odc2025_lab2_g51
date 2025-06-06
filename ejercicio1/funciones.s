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


loop_delay:
    stp x29, x30, [sp, -16]! 
    mov x29, sp
    str x19, [sp, -8]! 

    mov x19, x18 // x18 es la duración, se copia este valor en x19

    sub x19, x19, 1 // resta 1 a la duracion
    cbnz x19, loop_delay // si no es cero el loop sigue
  
    ldr x19, [sp], 8 
    ldp x29, x30, [sp], 16 
    ret



silla:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x19, x20, [sp, -16]!
    
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

    ldp x19, x20, [sp], 16
    ldp x29, x30, [sp], 16
ret



gaturro:

    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x19, x20, [sp, -16]!

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

    ldp x19, x20, [sp], 16
    ldp x29, x30, [sp], 16
ret



lentes:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x19, x20, [sp, -16]!

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

    ldp x19, x20, [sp], 16
    ldp x29, x30, [sp], 16
ret



mesa:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x19, x20, [sp, -16]!

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

    ldp x19, x20, [sp], 16
    ldp x29, x30, [sp], 16
ret





teclado:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x19, x20, [sp, -16]!

     // Dibuja un teclado con perspectiva usando llenar_cuadrado

    //rectangulo chiquito del borde
    mov w4, #0x0000
    mov x1, 300              // x inicial
    mov x2, 410             // y inicial
    mov x5, 220             // ancho
    mov x6, 10              // alto
    bl llenar_cuadrado

    // base del teclado rectangulo
    mov w4, #0x0000
    mov x1, 400           // posición x
    mov x2, 361            // posición y
    mov x5, 120            // ancho del rectángulo
    mov x6, 50            // alto del rectángulo
    bl llenar_cuadrado

    // triangulo da perspectiva
    mov w4, #0x0000
    mov x1, 300        // posición X de inicio
    mov x2, 410        // posición Y de inicio
    mov x5, 100         // base
    mov x6, 50         // altura
    bl triangulo_rectangulo_reflejado

    // linea horizontal
    mov w4, #0x0000
    mov x1, 300         // posición X (ajustá según necesidad)
    mov x2, 410        // posición Y (ajustá según necesidad)
    mov w4, 0xFF   // color negro
    mov x5, 170       // largo de la línea en píxeles
    bl linea_horizontal

    mov w4, #0x0000
    mov x1, 470          // x inicial
    mov x2, 409         // y inicial
    mov x5, 1            // ancho
    mov x6, 48           // alto
    mov w4, 0xFF   // color negro
    bl linea_diagonal2

    //teclas

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

    mov x1, 320            // x
    mov x2, 390            // y
    mov x5, 160            // largo
    movz w4, 0xFFFF, lsl 0    
    movk w4, 0x00FF, lsl 16 
    bl linea_horizontal


    mov x1, 310            // x
    mov x2, 400            // y
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

    mov x1, 360          // x inicial
    mov x2, 400          // y inicial
    mov x5, 1            // ancho de línea
    mov x6, 40           // alto de línea
    movz w4, 0xFFFF, lsl 0    
    movk w4, 0x00FF, lsl 16 
    bl linea_diagonal2

    mov x1, 380          // x inicial
    mov x2, 400          // y inicial
    mov x5, 1            // ancho de línea
    mov x6, 40           // alto de línea
    movz w4, 0xFFFF, lsl 0    
    movk w4, 0x00FF, lsl 16 
    bl linea_diagonal2

    mov x1, 400          // x inicial
    mov x2, 400          // y inicial
    mov x5, 1            // ancho de línea
    mov x6, 40           // alto de línea
    movz w4, 0xFFFF, lsl 0    
    movk w4, 0x00FF, lsl 16 
    bl linea_diagonal2

    mov x1, 420          // x inicial
    mov x2, 400          // y inicial
    mov x5, 1            // ancho de línea
    mov x6, 40           // alto de línea
    movz w4, 0xFFFF, lsl 0    
    movk w4, 0x00FF, lsl 16 
    bl linea_diagonal2

    mov x1, 440          // x inicial
    mov x2, 400          // y inicial
    mov x5, 1            // ancho de línea
    mov x6, 40           // alto de línea
    movz w4, 0xFFFF, lsl 0    
    movk w4, 0x00FF, lsl 16 
    bl linea_diagonal2

    mov x1, 460          // x inicial
    mov x2, 400          // y inicial
    mov x5, 1            // ancho de línea
    mov x6, 40           // alto de línea
    movz w4, 0xFFFF, lsl 0    
    movk w4, 0x00FF, lsl 16 
    bl linea_diagonal2

    mov x1, 470          // x inicial
    mov x2, 400          // y inicial
    mov x5, 1            // ancho de línea
    mov x6, 40           // alto de línea
    movz w4, 0xFFFF, lsl 0    
    movk w4, 0x00FF, lsl 16 
    bl linea_diagonal2



    
    //Triangulo tapa teclado para dar perspectiva

    
    mov x1, 460        // posición X de inicio
    mov x2, 430        // posición Y de inicio
    mov x5, 70         // base
    mov x6, 60         // altura
    movz w4, 0x6633
    movk w4, 0x0099, lsl #16
    bl triangulo_rectangulo_reflejado

    ldp x19, x20, [sp], 16
    ldp x29, x30, [sp], 16
    ret

mano:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x27, x28, [sp, -16]!
    stp x25, x26, [sp, -16]!
    stp x23, x24, [sp, -16]!
    stp x21, x22, [sp, -16]!
    stp x19, x20, [sp, -16]!
    
    mov x19, 300
    mov x20, 320
    mov x21, 320
    mov x22, 320
    mov x23, 318
    mov x24, 330
    mov x25, 370
    mov x26, 320
    mov x27, 320

    mov x1, 340     // x
    mov x2, x19       // y
    mov x5, 40      // largo
    mov x6, 40     // alto
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl llenar_cuadrado

    /// parte redonda de la mano
    mov x1, 350     // x
    mov x2, x20      // y
    mov x5, 22
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl circulo

    // linea dedo
    mov x1, 348    // x
    mov x2, x21      // y
    mov x5, 22
    movz w4, 0xba, lsl 16
	movk w4, 0x8207, lsl 0
    bl circulo


    // dedo
    mov x1,350     // x
    mov x2, x22      // y
    mov x5, 22
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl circulo

        /// linea dedo indice
    mov x1, 343        // X inicial
    mov x2, x23         // Y inicial
    mov x5, 25         // alto
    mov x6, 1           // grosor
    movz w4, 0xba, lsl 16
	movk w4, 0x8207, lsl 0
    bl linea_vertical



    /// dedo indice
    mov x1, 359     // x
    mov x2, x24     // y
    mov x5, 15      // largo
    mov x6, 40     // alto
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl llenar_cuadrado

    /// punta del dedo
    mov x1, 366     // x
    mov x2, x25      // y
    mov x5, 8
    movz w4, 0xdd, lsl 16
	movk w4, 0xb436, lsl 0
    bl circulo

        /// linea dedo indice
    mov x1, 374        // X inicial
    mov x2, x26         // Y inicial
    mov x5, 57         // alto
    mov x6, 1           // grosor
    movz w4, 0xba, lsl 16
	movk w4, 0x8207, lsl 0
    bl linea_vertical

            /// linea dedo indice
    mov x1, 359        // X inicial
    mov x2, x27         // Y inicial
    mov x5, 57         // alto
    mov x6, 1           // grosor
    movz w4, 0xba, lsl 16
	movk w4, 0x8207, lsl 0
    bl linea_vertical

    ldp x19, x20, [sp], 16
    ldp x21, x22, [sp], 16
    ldp x23, x24, [sp], 16
    ldp x25, x26, [sp], 16
    ldp x27, x28, [sp], 16
    ldp x29, x30, [sp], 16
ret



    lampara:
    stp x29, x30, [sp, -16]!
    mov x29, sp
    stp x19, x20, [sp, -16]!

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

    ldp x19, x20, [sp], 16
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

