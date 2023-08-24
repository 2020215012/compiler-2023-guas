.data
.align 2
_m6global03a03a3mod:
    .4byte 998244353
.bss
.align 2
_m6global03a03a4temp:
    .space 8388608
.align 2
_m6global03a03a1a:
    .space 8388608
.align 2
_m6global03a03a1b:
    .space 8388608
.globl main
.text

fft:
addi sp, sp, -104
sd ra, 0(sp)
sd x8, 8(sp)
sd x9, 16(sp)
sd x18, 24(sp)
sd x19, 32(sp)
sd x20, 40(sp)
sd x21, 48(sp)
sd x22, 56(sp)
sd x23, 64(sp)
sd x24, 72(sp)
sd x25, 80(sp)
sd x26, 88(sp)
sd x27, 96(sp)
mv x6, x10
mv x8, x11
mv ra, x12
mv x5, x13
li x7, 2
li x21, 1
beq ra, x21, .L2
j .L3
.L1:
mv x10, ra
ld ra, 0(sp)
ld x8, 8(sp)
ld x9, 16(sp)
ld x18, 24(sp)
ld x19, 32(sp)
ld x20, 40(sp)
ld x21, 48(sp)
ld x22, 56(sp)
ld x23, 64(sp)
ld x24, 72(sp)
ld x25, 80(sp)
ld x26, 88(sp)
ld x27, 96(sp)
addi sp, sp, 104
ret
.L2:
mv ra, x21
j .L1
.L3:
mv x9, x8
addiw x8, ra, -2
li x10, 0
j .L17
.L4:
blt x8, ra, .L6
mv x8, x6
la x6, _m6global03a03a4temp
addiw x7, ra, -4
li x10, 0
j .L29
.L6:
remw x11, x8, x7
li x10, 0
bne x11, x10, .L8
la x11, _m6global03a03a4temp
srai x10, x8, 1
slli x10, x10, 2
add x12, x11, x10
mv x11, x6
addw x10, x8, x9
slli x10, x10, 2
add x10, x11, x10
lw x10, 0(x10)
sw x10, 0(x12)
j .L9
.L8:
la x12, _m6global03a03a4temp
srai x11, ra, 1
srai x10, x8, 1
addw x10, x11, x10
slli x10, x10, 2
add x12, x12, x10
mv x11, x6
addw x10, x8, x9
slli x10, x10, 2
add x10, x11, x10
lw x10, 0(x10)
sw x10, 0(x12)
.L9:
addiw x8, x8, 1
j .L4
.L10:
blt x20, x19, .L12
li ra, 0
j .L1
.L12:
addw x5, x9, x20
slli ra, x5, 2
add x26, x8, ra
lw x24, 0(x26)
addw ra, x5, x19
slli ra, ra, 2
add x22, x8, ra
lw x25, 0(x22)
mv x10, x21
mv x11, x25
call multiply
mv ra, x10
addw x5, x24, ra
la x23, _m6global03a03a3mod
lw ra, 0(x23)
remw ra, x5, ra
sw ra, 0(x26)
mv x10, x21
mv x11, x25
call multiply
mv ra, x10
subw x5, x24, ra
lw ra, 0(x23)
addw x5, x5, ra
lw ra, 0(x23)
remw ra, x5, ra
sw ra, 0(x22)
mv x10, x21
mv x11, x18
call multiply
mv x6, x10
addiw ra, x20, 1
mv x5, ra
mv ra, x6
mv x20, x5
mv x21, ra
j .L10
.L13:
blt x11, ra, .L15
mv x18, x5
srai x19, ra, 1
mv x10, x18
mv x11, x18
call multiply
mv ra, x10
mv x10, x8
mv x11, x9
mv x12, x19
mv x13, ra
call fft
addw x20, x9, x19
mv x10, x18
mv x11, x18
call multiply
mv ra, x10
mv x10, x8
mv x11, x20
mv x12, x19
mv x13, ra
call fft
addiw x20, x19, -2
li ra, 0
mv x5, ra
mv ra, x21
mv x22, x5
mv x23, ra
j .L26
.L15:
addw x7, x9, x11
slli x7, x7, 2
add x10, x8, x7
slli x7, x11, 2
add x7, x6, x7
lw x7, 0(x7)
sw x7, 0(x10)
addiw x7, x11, 1
mv x11, x7
j .L13
.L16:
mv x8, x10
j .L4
.L17:
blt x10, x8, .L20
j .L16
.L18:
addiw x14, x10, 1
remw x12, x14, x7
li x11, 0
beq x12, x11, .L23
j .L24
.L19:
la x12, _m6global03a03a4temp
srai x11, x10, 1
slli x11, x11, 2
add x13, x12, x11
mv x12, x6
addw x11, x10, x9
slli x11, x11, 2
add x11, x12, x11
lw x11, 0(x11)
sw x11, 0(x13)
j .L18
.L20:
remw x12, x10, x7
li x11, 0
beq x12, x11, .L19
la x13, _m6global03a03a4temp
srai x12, ra, 1
srai x11, x10, 1
addw x11, x12, x11
slli x11, x11, 2
add x13, x13, x11
mv x12, x6
addw x11, x10, x9
slli x11, x11, 2
add x11, x12, x11
lw x11, 0(x11)
sw x11, 0(x13)
j .L18
.L22:
addiw x10, x10, 2
j .L17
.L23:
la x12, _m6global03a03a4temp
srai x11, x14, 1
slli x11, x11, 2
add x13, x12, x11
mv x12, x6
addw x11, x14, x9
slli x11, x11, 2
add x11, x12, x11
lw x11, 0(x11)
sw x11, 0(x13)
j .L22
.L24:
la x13, _m6global03a03a4temp
srai x12, ra, 1
srai x11, x14, 1
addw x11, x12, x11
slli x11, x11, 2
add x13, x13, x11
mv x12, x6
addw x11, x14, x9
slli x11, x11, 2
add x11, x12, x11
lw x11, 0(x11)
sw x11, 0(x13)
j .L22
.L25:
mv x5, x22
mv ra, x23
mv x20, x5
mv x21, ra
j .L10
.L26:
bge x22, x20, .L25
addw x5, x9, x22
slli ra, x5, 2
add x27, x8, ra
lw x25, 0(x27)
addw ra, x5, x19
slli ra, ra, 2
add x24, x8, ra
lw x26, 0(x24)
mv x10, x23
mv x11, x26
call multiply
mv ra, x10
addw x5, x25, ra
la x21, _m6global03a03a3mod
lw ra, 0(x21)
remw ra, x5, ra
sw ra, 0(x27)
mv x10, x23
mv x11, x26
call multiply
mv ra, x10
subw x5, x25, ra
lw ra, 0(x21)
addw x5, x5, ra
lw ra, 0(x21)
remw ra, x5, ra
sw ra, 0(x24)
mv x10, x23
mv x11, x18
call multiply
mv x24, x10
addiw ra, x22, 1
addw x5, x9, ra
slli ra, x5, 2
add x27, x8, ra
lw x25, 0(x27)
addw ra, x5, x19
slli ra, ra, 2
add x23, x8, ra
lw x26, 0(x23)
mv x10, x24
mv x11, x26
call multiply
mv ra, x10
addw x5, x25, ra
lw ra, 0(x21)
remw ra, x5, ra
sw ra, 0(x27)
mv x10, x24
mv x11, x26
call multiply
mv ra, x10
subw x5, x25, ra
lw ra, 0(x21)
addw x5, x5, ra
lw ra, 0(x21)
remw ra, x5, ra
sw ra, 0(x23)
mv x10, x24
mv x11, x18
call multiply
mv x6, x10
addiw ra, x22, 2
mv x5, ra
mv ra, x6
mv x22, x5
mv x23, ra
j .L26
.L28:
mv x7, x10
mv x11, x7
j .L13
.L29:
bge x10, x7, .L28
addw x11, x9, x10
slli x11, x11, 2
add x12, x8, x11
slli x11, x10, 2
add x11, x6, x11
lw x11, 0(x11)
sw x11, 0(x12)
addiw x13, x10, 1
addw x11, x9, x13
slli x11, x11, 2
add x12, x8, x11
slli x11, x13, 2
add x11, x6, x11
lw x11, 0(x11)
sw x11, 0(x12)
addiw x13, x10, 2
addw x11, x9, x13
slli x11, x11, 2
add x12, x8, x11
slli x11, x13, 2
add x11, x6, x11
lw x11, 0(x11)
sw x11, 0(x12)
addiw x13, x10, 3
addw x11, x9, x13
slli x11, x11, 2
add x12, x8, x11
slli x11, x13, 2
add x11, x6, x11
lw x11, 0(x11)
sw x11, 0(x12)
addiw x10, x10, 4
j .L29

main:
addi sp, sp, -104
sd ra, 0(sp)
sd x8, 8(sp)
sd x9, 16(sp)
sd x18, 24(sp)
sd x19, 32(sp)
sd x20, 40(sp)
sd x21, 48(sp)
sd x22, 56(sp)
sd x23, 64(sp)
sd x24, 72(sp)
sd x25, 80(sp)
sd x26, 88(sp)
sd x27, 96(sp)
li x21, 79
li x26, 998244352
li x25, 3
li x20, 0
li x18, 1
li x9, 60
la x19, _m6global03a03a1a
mv x10, x19
call getarray
mv x22, x10
la x24, _m6global03a03a1b
mv x10, x24
call getarray
mv x8, x10
mv x10, x9
call _sysy_starttime
mv ra, x18
mv x9, ra
.L32:
addw ra, x22, x8
addiw x18, ra, -1
blt x9, x18, .L34
divw x23, x26, x9
mv x10, x25
mv x11, x23
call power
mv ra, x10
mv x10, x19
mv x11, x20
mv x12, x9
mv x13, ra
call fft
mv x10, x25
mv x11, x23
call power
mv ra, x10
mv x10, x24
mv x11, x20
mv x12, x9
mv x13, ra
call fft
addiw x8, x9, -4
mv ra, x20
mv x22, ra
j .L42
.L34:
slli ra, x9, 1
mv x9, ra
j .L32
.L35:
blt x27, x9, .L37
subw ra, x26, x23
mv x10, x25
mv x11, ra
call power
mv ra, x10
mv x10, x19
mv x11, x20
mv x12, x9
mv x13, ra
call fft
mv ra, x20
mv x22, ra
j .L45
.L37:
slli ra, x27, 2
add x22, x19, ra
slli ra, x27, 2
add ra, x24, ra
lw x5, 0(x22)
lw ra, 0(ra)
mv x10, x5
mv x11, ra
call multiply
mv ra, x10
sw ra, 0(x22)
addiw ra, x27, 1
mv x27, ra
j .L35
.L38:
blt x22, x9, .L40
mv x10, x21
call _sysy_stoptime
mv x10, x18
mv x11, x19
call putarray
mv x10, x20
ld ra, 0(sp)
ld x8, 8(sp)
ld x9, 16(sp)
ld x18, 24(sp)
ld x19, 32(sp)
ld x20, 40(sp)
ld x21, 48(sp)
ld x22, 56(sp)
ld x23, 64(sp)
ld x24, 72(sp)
ld x25, 80(sp)
ld x26, 88(sp)
ld x27, 96(sp)
addi sp, sp, 104
ret
.L40:
slli ra, x22, 2
add x8, x19, ra
la ra, _m6global03a03a3mod
lw ra, 0(ra)
addiw ra, ra, -2
mv x10, x9
mv x11, ra
call power
mv x5, x10
lw ra, 0(x8)
mv x10, ra
mv x11, x5
call multiply
mv ra, x10
sw ra, 0(x8)
addiw ra, x22, 1
mv x22, ra
j .L38
.L41:
mv ra, x22
mv x27, ra
j .L35
.L42:
bge x22, x8, .L41
slli ra, x22, 2
add x27, x19, ra
slli ra, x22, 2
add ra, x24, ra
lw x5, 0(x27)
lw ra, 0(ra)
mv x10, x5
mv x11, ra
call multiply
mv ra, x10
sw ra, 0(x27)
addiw x5, x22, 1
slli ra, x5, 2
add x27, x19, ra
slli ra, x5, 2
add ra, x24, ra
lw x5, 0(x27)
lw ra, 0(ra)
mv x10, x5
mv x11, ra
call multiply
mv ra, x10
sw ra, 0(x27)
addiw x5, x22, 2
slli ra, x5, 2
add x27, x19, ra
slli ra, x5, 2
add ra, x24, ra
lw x5, 0(x27)
lw ra, 0(ra)
mv x10, x5
mv x11, ra
call multiply
mv ra, x10
sw ra, 0(x27)
addiw x5, x22, 3
slli ra, x5, 2
add x27, x19, ra
slli ra, x5, 2
add ra, x24, ra
lw x5, 0(x27)
lw ra, 0(ra)
mv x10, x5
mv x11, ra
call multiply
mv ra, x10
sw ra, 0(x27)
addiw ra, x22, 4
mv x22, ra
j .L42
.L44:
mv ra, x22
mv x22, ra
j .L38
.L45:
bge x22, x8, .L44
slli ra, x22, 2
add x23, x19, ra
la x24, _m6global03a03a3mod
lw ra, 0(x24)
addiw ra, ra, -2
mv x10, x9
mv x11, ra
call power
mv x5, x10
lw ra, 0(x23)
mv x10, ra
mv x11, x5
call multiply
mv ra, x10
sw ra, 0(x23)
addiw ra, x22, 1
slli ra, ra, 2
add x23, x19, ra
lw ra, 0(x24)
addiw ra, ra, -2
mv x10, x9
mv x11, ra
call power
mv x5, x10
lw ra, 0(x23)
mv x10, ra
mv x11, x5
call multiply
mv ra, x10
sw ra, 0(x23)
addiw ra, x22, 2
slli ra, ra, 2
add x23, x19, ra
lw ra, 0(x24)
addiw ra, ra, -2
mv x10, x9
mv x11, ra
call power
mv x5, x10
lw ra, 0(x23)
mv x10, ra
mv x11, x5
call multiply
mv ra, x10
sw ra, 0(x23)
addiw ra, x22, 3
slli ra, ra, 2
add x23, x19, ra
lw ra, 0(x24)
addiw ra, ra, -2
mv x10, x9
mv x11, ra
call power
mv x5, x10
lw ra, 0(x23)
mv x10, ra
mv x11, x5
call multiply
mv ra, x10
sw ra, 0(x23)
addiw ra, x22, 4
mv x22, ra
j .L45

multiply:
addi sp, sp, -48
sd ra, 0(sp)
sd x8, 8(sp)
sd x9, 16(sp)
sd x18, 24(sp)
sd x19, 32(sp)
sd x20, 40(sp)
mv x6, x10
mv x5, x11
li x20, 2
li x8, 998244353
li x9, 1
li ra, 0
mv x19, x5
beq x19, ra, .L48
j .L50
.L48:
mv x10, ra
ld ra, 0(sp)
ld x8, 8(sp)
ld x9, 16(sp)
ld x18, 24(sp)
ld x19, 32(sp)
ld x20, 40(sp)
addi sp, sp, 48
ret
.L49:
j .L48
.L50:
mv x18, x6
bne x19, x9, .L52
remw ra, x18, x8
j .L48
.L52:
srai ra, x19, 1
mv x10, x18
mv x11, ra
call multiply
mv ra, x10
addw ra, ra, ra
remw x5, ra, x8
remw ra, x19, x20
bne ra, x9, .L54
addw ra, x5, x18
remw ra, ra, x8
j .L48
.L54:
mv ra, x5
j .L48

power:
addi sp, sp, -40
sd ra, 0(sp)
sd x8, 8(sp)
sd x9, 16(sp)
sd x18, 24(sp)
sd x19, 32(sp)
mv x6, x10
mv x5, x11
li x19, 2
li x18, 1
li ra, 0
mv x9, x5
beq x9, ra, .L57
j .L58
.L56:
mv x10, ra
ld ra, 0(sp)
ld x8, 8(sp)
ld x9, 16(sp)
ld x18, 24(sp)
ld x19, 32(sp)
addi sp, sp, 40
ret
.L57:
mv ra, x18
j .L56
.L58:
mv x8, x6
srai ra, x9, 1
mv x10, x8
mv x11, ra
call power
mv ra, x10
mv x10, ra
mv x11, ra
call multiply
mv x5, x10
remw ra, x9, x19
bne ra, x18, .L60
mv x10, x5
mv x11, x8
call multiply
mv ra, x10
j .L56
.L60:
mv ra, x5
j .L56

