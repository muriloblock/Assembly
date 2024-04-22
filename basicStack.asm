.data
	myIntigerA: .word 10
	myIntigerB: .word 20
	newLine: .asciiz "\n"
	
.text
	lw   $s0, myIntigerA
	
	jal increaseMyRegister
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	
	li   $v0, 1
	move $a0, $s0
	syscall
	
	
	li   $v0, 10
	syscall
	
	increaseMyRegister:
		subi $sp, $sp, 4
		sw   $s0, 0($sp)
		
		lw   $s0, myIntigerB
		
		li   $v0, 1
		move $a0, $s0
		syscall
		
		lw   $s0, 0($sp)
		addi $sp, $sp, 4
		
		jr $ra
	