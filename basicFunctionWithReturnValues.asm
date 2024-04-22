.data
	myIntigerA: .word 10
	myIntigerB: .word 5

.text 
	main:
		lw $a1, myIntigerA
		lw $a2, myIntigerB
		
		jal addNumbers
		
		li $v0, 1
		move $a0, $v1
		
		syscall
		
		li $v0, 10
		syscall
		
	addNumbers:
		add $v1, $a1, $a2
		jr $ra
		