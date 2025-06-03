.section .data
.global letra_0
.global letra_1
.global letra_Y
.global letra_O
.global letra_D
.global letra_C
.global numero_5
.global numero_2
.global tabla_letras1
.global tabla_letras2
.global tabla_letras3
.global tabla_general

letra_0:
    .byte 0b01110
    .byte 0b10001
    .byte 0b10011
    .byte 0b10101
    .byte 0b11001
    .byte 0b10001
    .byte 0b01110

letra_1:
    .byte 0b00100
    .byte 0b00110
    .byte 0b00100
    .byte 0b00100
    .byte 0b00100
    .byte 0b00100
    .byte 0b01110

letra_Y:
    .byte 0b10001
    .byte 0b01010
    .byte 0b00100
    .byte 0b00100
    .byte 0b00100
    .byte 0b00100
    .byte 0b00100

letra_O:
    .byte 0b01110
    .byte 0b10001
    .byte 0b10001
    .byte 0b10001
    .byte 0b10001
    .byte 0b10001
    .byte 0b01110

letra_D:
    .byte 0b00111
    .byte 0b01001
    .byte 0b10001
    .byte 0b10001
    .byte 0b10001
    .byte 0b01001
    .byte 0b00111

letra_C:
    .byte 0b01110
    .byte 0b10001
    .byte 0b00001
    .byte 0b00001
    .byte 0b00001
    .byte 0b10001
    .byte 0b01110

numero_2:
    .byte 0b01110
    .byte 0b10001
    .byte 0b10000
    .byte 0b01000
    .byte 0b00100
    .byte 0b00010
    .byte 0b11111

numero_5:
    .byte 0b11111
    .byte 0b00001
    .byte 0b00001
    .byte 0b01111
    .byte 0b10000
    .byte 0b10001
    .byte 0b01110

tabla_letras1:
    .quad letra_O
    .quad letra_D
    .quad letra_C
    .quad numero_2
    .quad letra_0
    .quad numero_2
    .quad numero_5
    .quad letra_Y

tabla_letras2:
    .quad numero_2
    .quad letra_D
    .quad letra_Y
    .quad letra_0
    .quad numero_5
    .quad letra_C
    .quad letra_1
    .quad letra_O

tabla_letras3:
    .quad letra_D
    .quad letra_O
    .quad numero_2
    .quad letra_Y
    .quad letra_C
    .quad letra_1
    .quad numero_5
    .quad letra_0

tabla_letras4:
    .quad numero_5
    .quad letra_O
    .quad letra_C
    .quad numero_2
    .quad letra_Y
    .quad letra_1
    .quad letra_0
    .quad letra_D

tabla_letras5:
    .quad letra_0
    .quad letra_1
    .quad numero_2
    .quad letra_Y
    .quad letra_O
    .quad letra_C
    .quad numero_5
    .quad letra_D


tabla_letras6:
    .quad letra_C
    .quad letra_0
    .quad letra_1
    .quad letra_D
    .quad numero_2
    .quad letra_O
    .quad numero_5
    .quad letra_Y
    
tabla_letras7:
    .quad numero_5
    .quad letra_0
    .quad letra_1
    .quad letra_Y
    .quad numero_2
    .quad letra_D
    .quad letra_O
    .quad letra_C

tabla_letras8:
    .quad numero_2
    .quad letra_0
    .quad letra_Y
    .quad letra_O
    .quad letra_C
    .quad numero_5
    .quad letra_D
    .quad letra_1

tabla_general:
    .quad tabla_letras1
    .quad tabla_letras2
    .quad tabla_letras3
    .quad tabla_letras4
    .quad tabla_letras5
    .quad tabla_letras6
    .quad tabla_letras7
    .quad tabla_letras8
