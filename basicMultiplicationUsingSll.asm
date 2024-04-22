.data
	myIntiger: .word 2

.text
	lw $t0, myIntiger
	sll $t0, $t0, 1
	
	li $v0, 1
	move $a0, $t0
	syscall
	