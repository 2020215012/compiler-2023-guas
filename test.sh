compiler_guas/build/compiler -S -o test.s test.sy
riscv64-linux-gnu-gcc -static test.s sylib.c -o run
qemu-riscv64 ./run
#echo $?