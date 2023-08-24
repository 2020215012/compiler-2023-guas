.bss
.align 2
_m6global03a03a6matrix:
    .space 80000000
.align 2
_m6global03a03a1a:
    .space 400000
.globl main
.text

main:
addi sp, sp, -64
sd ra, 0(sp)
sd x8, 8(sp)
sd x9, 16(sp)
sd x18, 24(sp)
sd x19, 32(sp)
sd x20, 40(sp)
sd x21, 48(sp)
sd x22, 56(sp)
li x19, 10
li x18, 47
li x22, 28
li x9, 0
call getint
mv x21, x10
la x20, _m6global03a03a1a
mv x10, x20
call getarray
mv x8, x10
mv x10, x22
call _sysy_starttime
addiw x10, x21, -4
mv ra, x9
mv x7, ra
j .L22
.L1:
blt x6, x21, .L3
mv ra, x9
mv x5, ra
j .L4
.L3:
la x5, _m6global03a03a6matrix
slli ra, x6, 2
add ra, x5, ra
sw x6, 0(ra)
addiw ra, x6, 1
mv x6, ra
j .L1
.L4:
blt x5, x8, .L6
addiw ra, x8, -4
mv x5, x9
mv x6, x9
mv x7, x6
j .L25
.L6:
slli ra, x5, 2
add ra, x20, ra
lw ra, 0(ra)
mv x6, x9
j .L12
.L7:
blt x10, x8, .L9
mv ra, x7
mv x8, ra
blt x7, x9, .L10
j .L11
.L9:
mulw x6, x10, x10
la x5, _m6global03a03a6matrix
slli ra, x10, 2
add ra, x5, ra
lw ra, 0(ra)
mulw ra, x6, ra
addw x6, x7, ra
addiw ra, x10, 1
mv x5, ra
mv ra, x6
mv x10, x5
mv x7, ra
j .L7
.L10:
sub ra, zero, x7
mv x8, ra
.L11:
mv x10, x18
call _sysy_stoptime
mv x10, x8
call putint
mv x10, x19
call putch
mv x10, x9
ld ra, 0(sp)
ld x8, 8(sp)
ld x9, 16(sp)
ld x18, 24(sp)
ld x19, 32(sp)
ld x20, 40(sp)
ld x21, 48(sp)
ld x22, 56(sp)
addi sp, sp, 64
ret
.L12:
divw x7, x21, ra
blt x6, x7, .L14
addiw ra, x5, 1
mv x5, ra
j .L4
.L14:
mv x10, x9
mv x14, x10
.L15:
blt x14, ra, .L17
addiw x6, x6, 1
j .L12
.L17:
blt x6, x14, .L19
j .L20
.L18:
mv x14, x10
j .L15
.L19:
addiw x10, x14, 1
j .L18
.L20:
la x11, _m6global03a03a6matrix
mulw x10, x6, ra
addw x10, x10, x14
slli x10, x10, 2
add x13, x11, x10
lw x12, 0(x13)
mulw x10, x14, x7
addw x10, x10, x6
slli x10, x10, 2
add x11, x11, x10
lw x10, 0(x13)
sw x10, 0(x11)
sw x12, 0(x13)
addiw x10, x14, 1
j .L18
.L21:
mv ra, x7
mv x6, ra
j .L1
.L22:
bge x7, x10, .L21
la x6, _m6global03a03a6matrix
slli ra, x7, 2
add ra, x6, ra
sw x7, 0(ra)
addiw x5, x7, 1
slli ra, x5, 2
add ra, x6, ra
sw x5, 0(ra)
addiw x5, x7, 2
slli ra, x5, 2
add ra, x6, ra
sw x5, 0(ra)
addiw x5, x7, 3
slli ra, x5, 2
add ra, x6, ra
sw x5, 0(ra)
addiw ra, x7, 4
mv x7, ra
j .L22
.L24:
mv ra, x7
mv x10, x5
mv x7, ra
j .L7
.L25:
bge x5, ra, .L24
mulw x11, x5, x5
la x6, _m6global03a03a6matrix
slli x10, x5, 2
add x10, x6, x10
lw x10, 0(x10)
mulw x10, x11, x10
addw x11, x7, x10
addiw x7, x5, 1
mulw x10, x7, x7
slli x7, x7, 2
add x7, x6, x7
lw x7, 0(x7)
mulw x7, x10, x7
addw x11, x11, x7
addiw x7, x5, 2
mulw x10, x7, x7
slli x7, x7, 2
add x7, x6, x7
lw x7, 0(x7)
mulw x7, x10, x7
addw x11, x11, x7
addiw x7, x5, 3
mulw x10, x7, x7
slli x7, x7, 2
add x6, x6, x7
lw x6, 0(x6)
mulw x6, x10, x6
addw x6, x11, x6
addiw x5, x5, 4
mv x7, x6
j .L25

