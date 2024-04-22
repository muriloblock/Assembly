.data
	myIntA: .word 10
	myIntB: .word 5

.text
	lw $t1,  myIntA
	lw $t2,  myIntB
	add $t0, $t1,$t2
	
	li $v0,  1
	move $a0, $t0
	syscall
	
	