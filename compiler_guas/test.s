
.section .text
.global __create_threads
.global __join_threads


sys_clone = 220
clone_vm = 256
sigchld = 17
__create_threads:
	addi	sp,sp,-32
	sd	s1,8(sp)
	sd	ra,24(sp)
	sd	s0,16(sp)
	addiw	s1,a0,-1
	blez	s1,.L4
	li	s0,0
.L3:
    li  a7,sys_clone
	li	a4,0
	li	a3,0
	li	a2,0
    mv  a1,sp
	li	a0,(clone_vm | sigchld)
	ecall
	bnez	a0,.L5
	addiw	s0,s0,1
	bne	s1,s0,.L3
	ld	ra,24(sp)
	ld	s0,16(sp)
	mv	a0,s1
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
.L5:
	mv	s1,s0
	ld	ra,24(sp)
	ld	s0,16(sp)
	mv	a0,s1
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
.L4:
	ld	ra,24(sp)
	ld	s0,16(sp)
	li	s1,0
	mv	a0,s1
	ld	s1,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	__create_threads, .-__create_threads


sys_waitid = 95
sys_exit = 93
p_all = 0
wexited = 4
__join_threads:
	addi	sp,sp,-16
	sd	s0,0(sp)
	sd	ra,8(sp)
	addiw	a1,a1,-1
	mv	s0,a0
	bne	a1,a0,.L6
	bnez	s0,.L7
.L1:
	ld	ra,8(sp)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
.L6:
    li  a7,sys_waitid
	li	a3,wexited
	li	a2,0
	li	a1,0
	li	a0,p_all
	ecall
	beqz	s0,.L1
.L7:
    li  a7,sys_exit
	li	a0,0
	ecall
	.size	__join_threads, .-__join_threads

main:
	addi	sp,sp,-16
	li	a3,255
	li	a2,0
	li	a1,0
	li	a0,255
	sd	ra,8(sp)
	
	li	a0,0
	call	_exit@plt
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
