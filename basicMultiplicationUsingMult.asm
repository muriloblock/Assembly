.data
	myIntigerA: .word 10
	myIntigerB: .word 5

.text
	lw $t1, myIntigerA
	lw $t2, myIntigerB
	mul $t0, $t1, $t2
	
	li $v0, 1
	move $a0, $t0
	syscall