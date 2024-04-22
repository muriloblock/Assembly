.data
	prompt:    .asciiz "Enter your name: "
	message:   .asciiz "Hello, "
	userInput: .space 20
	
.text
	main:
		li $v0, 4
		la $a0, prompt
		syscall
		
		li $v0, 8
		la $a0, userInput
		li $a1, 20
		syscall
		
		li $v0, 4
		la $a0, message
		syscall
		
		li $v0, 4
		la $a0, userInput
		syscall