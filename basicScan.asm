.data
	prompt:  .asciiz "Enter your age: "
	message: .asciiz "Your age is "
	
.text
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0
	
	li $v0, 4
	la $a0, message
	syscall

	li $v0, 1
	move $a0, $s0
	syscall	
