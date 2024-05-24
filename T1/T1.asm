.data
    nomeArquivo: .asciiz "arquivo.bin"
    bufferArquivo: .space 1024
    resultado: .word 0          # Variável para armazenar o resultado do processamento

    stack: .space 1024    # Definindo a pilha com 1024 bytes (4 bytes por palavra)
    registers: .space 128 # Define a memoria virtual para os 32 registradores

.text
    .globl main
    main:
    	la $t0, stack
    	la $t1, registers
    	addi $t1, $t1, 116
    	sw $t0, 0($t1)  # Guarda o endere�o da pilha no �ndice 29 do array registers
    
        la $a0, nomeArquivo        # Endereço do arquivo a ser aberto
        jal abrirArquivo           # Chama a função para abrir o arquivo
        
        move $s0, $v0              # Salva o descritor de arquivo em $s0
	
	lerArquivo:
        	li $v0, 14                 # Código da syscall para ler o arquivo
		move $a0, $s0              # Descritor de arquivo
		la $a1, bufferArquivo          # Buffer para armazenar os bytes lidos
		li $a2, 1024               
		syscall

		move $s7, $a1
	pegaUmaInstrucao:
		la $s7, bufferArquivo      # Carrega o endere�o do buffer no registrador $s7 tornandoa assim o $s7 o PC do arquivo
		addi $s6, $s6, 59
		loopPegaUmaInstrucao:
        		jal pega_tipo_instrucao
	        	addi $s7, $s7, 4  #PC + 4
	        	beq  $zero, $s6, saiLooploopPegaUmaInstrucao
	        	subi $s6, $s6, 1
        		j loopPegaUmaInstrucao

		saiLooploopPegaUmaInstrucao:
		
	        li $v0, 10                 # Código da syscall para sair do programa
	        syscall

abrirArquivo:
        li $v0, 13                 # Código da syscall para abrir arquivo
        li $a1, 0                  # Modo de abertura (0 para leitura)
        syscall
        jr $ra

pega_tipo_instrucao:
	lw $t0, 0($s7)             # Carrega o valor lido do arquivo de $t1 para $t0
        li $t1, 0xFC000000         # Máscara para isolar os primeiros 6 bits do opcode
        and $t0, $t0, $t1          # Isola os primeiros 6 bits do opcode
        srl $t0, $t0, 26           # Desloca para a direita para obter o valor do opcode
        
        addi $t8, $t0, 0
        # Verifica o tipo da instrução com base no opcode
        beq $t0, 0, tipoR          # Se opcode == 0, é do tipo R
        beq $t0, 2, tipoJ          # Se opcode == 2, é do tipo J
        beq $t0, 3, tipoJ          # Se opcode == 3, é do tipo J
        beq $t0, 28, tipoR         # Se opcode == 2, é do tipo J
        j tipoI                    # Caso contrário, é do tipo I
        
tipoR:
	subi $sp,$sp,4
	sw $ra, 0($sp)

	jal pegaRS                   #Pega qual registrador esta no RS do binario e deixa em $t5
	jal pegaRT                   #Pega qual registrador esta no RT do binario e deixa em $t6
	jal pegaRD                   #Pega qual registrador esta no RS do binario e deixa em $t7
	jal pegaSHAM                 #Pega qual registrador esta no RS do binario e deixa em $t8
	jal pegaFUNCT                #Pega qual registrador esta no RS do binario e deixa em $t9

	move $t4, $t5
	jal pegaRegistradorVirtual   #Pega o valor guardado no registrador colocado em $t4 e o retorna em $t4
	move $t5, $t4

	move $t4, $t6
	jal pegaRegistradorVirtual   #Pega o valor guardado no registrador colocado em $t4 e o retorna em $t4
	move $t6, $t4

	addi $s4, $zero, 2
	beq  $s4,$t9, processaMUL
	addi $s4, $zero, 8
	beq  $s4,$t9, processaJR
	addi $s4, $zero, 32
	beq  $s4,$t9, processaADD

	retornaTipoR:

        li $v0, 1                  # Prepara o resultado para imprimir 1
        addi $a0, $zero, 1
        syscall
        
        lw $ra, 0($sp)
	addi $sp, $sp, 4
   	jr $ra
        
tipoJ:
	subi $sp,$sp,4
	sw $ra, 0($sp)

        li $v0, 1                  # Prepara o resultado para imprimir 2
        addi $a0, $zero, 2
        syscall
        
        jal pegaJump
        
        addi $t9, $zero, 2
	beq  $t8,$t9, processaJUMP
        addi $t9, $zero, 3
	beq  $t8,$t9, processaJAL
        
        retornaTipoJ:
        
      	lw $ra, 0($sp)
	addi $sp, $sp, 4
   	jr $ra
   	
tipoI:
	subi $sp,$sp,4
	sw $ra, 0($sp)

   	li   $v0, 1
   	addi $a0, $zero, 3 
   	syscall
	
	jal pegaRS                   #Pega qual registrador esta no RS do binario e deixa em $t5
	jal pegaRT                   #Pega qual registrador esta no RT do binario e deixa em $t6
	jal pegaImediato             #Pega valor do Imdiato do binario e deixa em $t7
	
	move $t4, $t5
	jal pegaRegistradorVirtual   #Pega o valor guardado no registrador colocado em $t4 e o retorna em $t4
	move $t5, $t4
	
	addi $t9, $zero, 35	     #Coloquei aqui pq eu preciso do numero do RT nao de seu valor	
	beq  $t8, $t9, processaLW
	
	move $t4, $t6
	jal pegaRegistradorVirtual   #Pega o valor guardado no registrador colocado em $t4 e o retorna em $t4
	move $t6, $t4
	
	addi $t9, $zero, 5
	beq  $t8,$t9, processaBNE
	addi $t9, $zero, 8
	beq  $t8,$t9, processaADDI
	addi $t9, $zero, 9
	beq  $t8,$t9, processaADDIU
	addi $t9, $zero, 43
	beq  $t8, $t9, processaSW
	retornaTipoI:
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
   	jr $ra
   	
pegaRS:
   	lw $t0, 0($s7)             # Carrega o valor lido do arquivo de $t1 para $t0
        li  $t1, 0x03E00000        # $t1 = MASCARA PARA ISOLAR 5 BITS DE RS
        and $t0, $t0, $t1          # $v0 = 5 BITS DE RS
        srl $t0, $t0, 21 	   # $v0 = SHIFT DIREITA 21 BITS
        move $t5, $t0
        
        jr $ra

pegaRT:
   	lw $t0, 0($s7)
   	li  $t1, 0x001F0000        # $t1 = MASCARA PARA ISOLAR 5 BITS DE RT
   	and $t0, $t0, $t1          # $v0 = 5 BITS DE RS
        srl $t0, $t0, 16 	   # $v0 = SHIFT DIREITA 16 BITS
        move $t6, $t0
        
        jr $ra 
   
pegaRD:
   	lw $t0, 0($s7)
   	li  $t1, 0x0000F800        # $t1 = MASCARA PARA ISOLAR 5 BITS DE RT
   	and $t0, $t0, $t1          # $v0 = 5 BITS DE RS
        srl $t0, $t0, 11 	   # $v0 = SHIFT DIREITA 16 BITS
        move $t7, $t0
        
        jr $ra
      
pegaSHAM:
	lw $t0, 0($s7)  
	li $t1, 0x000007C0
	and $t0, $t0, $t1          # $v0 = 5 BITS DE RS
        srl $t0, $t0, 6	   # $v0 = SHIFT DIREITA 16 BITS
        move $t8, $t0
        
        jr $ra   
      
pegaFUNCT:     
        lw $t0, 0($s7)
   	li  $t1, 0x0000003F        # $t1 = MASCARA PARA ISOLAR 5 BITS DE RT
   	and $t0, $t0, $t1          # $v0 = 5 BITS DE RS
        move $t9, $t0
        
        jr $ra
pegaImediato:
   	lw $t0, 0($s7)
   	li  $t1, 0x0000FFFF
   	li  $t3  0x0000000F
   	and $t0, $t0, $t1          # $v0 = 5 BITS DE RS
   	
   	srl $t2,$t0, 12
   	beq $t2, $t3, extenderSinal
   	
        move $t7, $t0
        jr $ra      

pegaJump:
	lw $t0, 0($s7)
        li  $t1, 0x03FFFFFF       # $t1 = MASCARA PARA ISOLAR 26 BITS DE TARGET
        and $t0, $t0, $t1         # $a0 = 26 BITS DE TARGET
        
        sll $t0, $t0, 2           # TARGET = TARGET * 4
	move $t7, $t0
        jr $ra                    # RETORNA AO PROCEDIMENTO CHAMADOR

pegaRegistradorVirtual:
	mul $t4, $t4, 4
	la $t3, registers
	
	add $t3, $t4, $t3
	lw $t4, 0($t3)
	
	jr $ra
 
processaBNE:
	bne $t5, $t6, aceitouBNE
	j retornaTipoI
	
aceitouBNE:
	mul   $t7, $t7, 4
	add, $s7, $s7, $t7
	j retornaTipoI	 
	            
processaADDIU:
	add $t5,$t6,$t7
	sw $t5, 0($t3)
	j retornaTipoI
	
processaADDI:
	add $t5,$t6,$t7
	sw $t5, 0($t3)
	j retornaTipoI

processaLW:
	add $t7,$t5,$t7
	lw $t8, 0($t7)
	
	mul $t6, $t6, 4     #Calcula qual o registrado do RD
	la $t3, registers   #Pega o endereco dos registradores
	add $t6, $t3, $t6   #Calcula efetivamente o valor do RD, somando o endereco dos registradores deslocando o valor do RD
	sw $t8, 0($t6)
	
	j retornaTipoI
	
processaSW:
	add $t7,$t5,$t7
	sw $t6, 0($t7)
	
	j retornaTipoI

processaADD:
	mul $t7, $t7, 4     #Calcula qual o registrado do RD
	la $t3, registers   #Pega o endereco dos registradores
	add $t7, $t3, $t7   #Calcula efetivamente o valor do RD, somando o endereco dos registradores deslocando o valor do RD

	add $t5, $t5, $t6  #Faz a soma dos valores
	sw $t5, 0($t7)     #Retorna o registrador RD para a memoria virtual
	
	j retornaTipoR	
processaMUL:
	mul $t7, $t7, 4     #Calcula qual o registrado do RD
	la $t3, registers   #Pega o endereco dos registradores
	add $t7, $t3, $t7   #Calcula efetivamente o valor do RD, somando o endereco dos registradores deslocando o valor do RD

	mul $t5, $t5, $t6  #Faz a soma dos valores
	sw $t5, 0($t7)     #Retorna o registrador RD para a memoria virtual
	j retornaTipoR	
	
processaJR:
	move $s7, $t5
	j retornaTipoR	

processaJUMP:
	la $t6, bufferArquivo
	li $t1, 0x00400000
	sub $t7, $t7, $t1
	add $s7, $t7, $t6
	subi $s7, $s7, 4
	
	j retornaTipoJ	
			
processaJAL:
	la $t6,registers
	addi $t6,$t6, 124 #Calcula o endereco do $ra virtual 
	sw $s7, 0($t6)    #Salva o pc do arquivo no $ra
	
	#tenho que somar o valor do jump no pc
	la $t6, bufferArquivo
	li $t1, 0x00400000
	sub $t7, $t7, $t1
	add $s7, $t7, $t6
	subi $s7, $s7, 4
	
	j retornaTipoJ
fim:
        sw $v0, resultado          # Salva o resultado do processamento em resultado
        jr $ra                     # Retorna ao procedimento chamador

extenderSinal:
	li $t1, 0xFFFF0000
	or $t7, $t0, $1
	
	jr $ra
