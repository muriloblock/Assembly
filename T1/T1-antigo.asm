.data
    nomeArquivo: .asciiz "arquivo.bin"
    fileWords: .space 1024
    resultado: .word 0          # Variável para armazenar o resultado do processamento

.text
    .globl main
    main:
        la $a0, nomeArquivo        # Endereço do arquivo a ser aberto
        jal abrirArquivo           # Chama a função para abrir o arquivo
        
        move $s0, $v0              # Salva o descritor de arquivo em $s0
        
        li $v0, 14                 # Código da syscall para ler o arquivo
	move $a0, $s0              # Descritor de arquivo
	la $a1, fileWords          # Buffer para armazenar os bytes lidos
	li $a2, 4                  # Número de bytes a serem lidos (4 bytes)
	syscall

	move $t7, $a1              # Salva o endereço do buffer em $t7

	li $v0, 14                 # Código da syscall para ler o arquivo
	move $a0, $s0              # Descritor de arquivo
	la $a1, fileWords          # Buffer para armazenar os bytes lidos
	li $a2, 4                  # Número de bytes a serem lidos (4 bytes)
	syscall

	move $t7, $a1              # Salva o endereço do buffer em $t7

        jal pega_tipo_instrucao    # Determina o tipo da instrução
        jal processa_instrucao
        
        li $v0, 10                 # Código da syscall para sair do programa
        syscall

abrirArquivo:
        li $v0, 13                 # Código da syscall para abrir arquivo
        li $a1, 0                  # Modo de abertura (0 para leitura)
        syscall
        jr $ra

pega_tipo_instrucao:
	lw $t0, 0($t7)             # Carrega o valor lido do arquivo de $t1 para $t0
        li $t1, 0xFC000000         # Máscara para isolar os primeiros 6 bits do opcode
        and $t0, $t0, $t1          # Isola os primeiros 6 bits do opcode
        srl $t0, $t0, 26           # Desloca para a direita para obter o valor do opcode
        
        move $t6, $t0
        
        # Verifica o tipo da instrução com base no opcode
        beq $t0, 0, tipoR          # Se opcode == 0, é do tipo R
        beq $t0, 2, tipoJ          # Se opcode == 2, é do tipo J
        beq $t0, 3, tipoJ          # Se opcode == 3, é do tipo J
        j tipoI                    # Caso contrário, é do tipo I
        
tipoR:
        li $v0, 1                  # Prepara o resultado para imprimir 1
        addi $a0, $zero, 1
        syscall
        jr $ra
        
tipoJ:
        li $v0, 1                  # Prepara o resultado para imprimir 2
        addi $a0, $zero, 2
        syscall
        jr $ra
        
tipoI:
   	li $v0, 1
   	addi $a0, $zero, 3 
   	syscall
   	
   	lw $t0, 0($t7)             # Carrega o valor lido do arquivo de $t1 para $t0
        li  $t1, 0x03E00000        # $t1 = MASCARA PARA ISOLAR 5 BITS DE RS
        and $t0, $t0, $t1          # $v0 = 5 BITS DE RS
        srl $t0, $t0, 21 	   # $v0 = SHIFT DIREITA 21 BITS
        move $t3, $t0	     
   	
   	lw $t0, 0($t7)             # Carrega o valor lido do arquivo de $t1 para $t0
   	li  $t1, 0x001F0000        # $t1 = MASCARA PARA ISOLAR 5 BITS DE RT
   	and $t0, $t0, $t1          # $v0 = 5 BITS DE RS
        srl $t0, $t0, 16 	   # $v0 = SHIFT DIREITA 21 BITS
        move $t4, $t0
   	
   	lw $t0, 0($t7)             # Carrega o valor lido do arquivo de $t1 para $t0
   	li  $t1, 0x0000FFFF
   	and $t0, $t0, $t1          # $v0 = 5 BITS DE RS
        srl $t0, $t0, 0 	   # $v0 = SHIFT DIREITA 21 BITS
        move $t5, $t0
        
        jr $ra
        
processa_instrucao:
    addi $sp, $sp, -4         # Aloca espaço na pilha para salvar $ra
    sw $ra, 0($sp)            # Salva $ra na pilha

    beq $t6, 9, addi          # Se $t6 for igual a 9, pula para addi
    j addi                    # Caso contrário, pula diretamente para addi

    lw $ra, 0($sp)            # Restaura $ra da pilha
    addi $sp, $sp, 4          # Libera o espaço da pilha
    jr $ra                    # Retorna ao procedimento chamador

addi:	
    jal preocessaRs
    jal preocessaRt
    add $s0, $s1, $t5 
    lw $ra, 0($sp)            # Restaura $ra da pilha
    addi $sp, $sp, 4          # Libera o espaço da pilha
    jr $ra                    # Retorna ao procedimento chamador

preocessaRs:
    addi $sp, $sp, -4         # Aloca espaço na pilha para salvar $ra
    sw $ra, 0($sp)            # Salva $ra na pilha

    beq $t3, 0x1D, registradorSp
    move $t4, $s0

    lw $ra, 0($sp)            # Restaura $ra da pilha
    addi $sp, $sp, 4          # Libera o espaço da pilha
    jr $ra                    # Retorna ao procedimento chamador

registradorSp:
    move $t4, $s0
    lw $ra, 0($sp)            # Restaura $ra da pilha
    addi $sp, $sp, 4          # Libera o espaço da pilha
    jr $ra                    # Retorna ao procedimento chamador

preocessaRt:
    addi $sp, $sp, -4         # Aloca espaço na pilha para salvar $ra
    sw $ra, 0($sp)            # Salva $ra na pilha

    beq $t4, 0x1D, registradorSp2
    move $t4, $s1

    lw $ra, 0($sp)            # Restaura $ra da pilha
    addi $sp, $sp, 4          # Libera o espaço da pilha
    jr $ra                    # Retorna ao procedimento chamador

registradorSp2:
    move $t4, $s1
    lw $ra, 0($sp)            # Restaura $ra da pilha
    addi $sp, $sp, 4          # Libera o espaço da pilha
    jr $ra                    # Retorna ao procedimento chamador

