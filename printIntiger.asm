.data
	myIntiger: .word 10

.text
	li $v0, 1
	lw $a0, myIntiger
	syscall
