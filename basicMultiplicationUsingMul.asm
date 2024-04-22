.data
	myIntigerA: .word 10
	myIntigerB: .word 5

.text
	lw $t1, myIntigerA
	lw $t2, myIntigerB
	mult $t1, $t2
	
	li $v0, 1
	mflo $a0
	syscall