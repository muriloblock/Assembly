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
	
	jal printTheValue
	
	li   $v0, 10
	syscall
	
	increaseMyRegister:
		subi $sp, $sp, 8
		sw   $s0, 0($sp)
		sw   $ra, 4($sp)
		
		lw   $s0, myIntigerB
		
		jal printTheValue
		
		lw   $s0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		
		jr $ra
		
	printTheValue:
		li $v0, 1
		move $a0, $s0
		syscall
		
		jr $ra	
	