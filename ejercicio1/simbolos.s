.section .data
.global letra_0
.global letra_1
.global letra_Y
.global letra_O
.global letra_D
.global letra_C
.global numero_5
.global numero_2
.global tabla_letras

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

tabla_letras:
    .quad letra_O
    .quad letra_D
    .quad letra_C
    .quad numero_2
    .quad numero_5
    .quad letra_Y
    .quad letra_0
    .quad letra_1



