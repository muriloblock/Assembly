.data
	prompt:      .asciiz "Enter the value of PI: "
	message:     .asciiz "The value of PI is "
.text
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 6
	syscall
	
	li $v0, 4
	la $a0, message
	syscall

	li $v0, 2
	mov.s $f12, $f0
	syscall	
