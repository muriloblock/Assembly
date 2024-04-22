.data
	message: .asciiz "Hello World!"
	
.text
	main:
		jal displayMessage
		
		addi $s0, $zero, 5
		
		li $v0, 1
		move $a0, $s0
		syscall
		
		li $v0, 10
		syscall
		
	displayMessage:
		li $v0, 4
		la $a0, message
		syscall
		
		jr $ra
		 
