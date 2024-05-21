.data
    nomeArquivo: .asciiz "arquivo.bin"
    fileWords: .space 1024
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
        
        li $v0, 14                 # Código da syscall para ler o arquivo
	move $a0, $s0              # Descritor de arquivo
	la $a1, fileWords          # Buffer para armazenar os bytes lidos
	li $a2, 4                  # Número de bytes a serem lidos (4 bytes)
	syscall

	move $s7, $a1              # Salva o endereço do buffer em $t1
        
        jal pega_tipo_instrucao    # Determina o tipo da instrução
        
        li $v0, 14                 # Código da syscall para ler o arquivo
	move $a0, $s0              # Descritor de arquivo
	la $a1, fileWords          # Buffer para armazenar os bytes lidos
	li $a2, 4                  # Número de bytes a serem lidos (4 bytes)
	syscall

	move $s7, $a1              # Salva o endereço do buffer em $t1
        
        jal pega_tipo_instrucao    # Determina o tipo da instrução
        
        li $v0, 14                 # Código da syscall para ler o arquivo
	move $a0, $s0              # Descritor de arquivo
	la $a1, fileWords          # Buffer para armazenar os bytes lidos
	li $a2, 4                  # Número de bytes a serem lidos (4 bytes)
	syscall

	move $s7, $a1              # Salva o endereço do buffer em $t1
        
        jal pega_tipo_instrucao    # Determina o tipo da instrução
        
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
        j tipoI                    # Caso contrário, é do tipo I
        
tipoR:
	subi $sp,$sp,4
	sw $ra, 0($sp)

	jal pegaRS                   #Pega qual registrador esta no RS do binario e deixa em $t5
	jal pegaRT                   #Pega qual registrador esta no RT do binario e deixa em $t6
	jal pegaRD
	jal pegaSHAM
	jal pegaFUNCT

        li $v0, 1                  # Prepara o resultado para imprimir 1
        addi $a0, $zero, 1
        syscall
        b fim                      # Pula para o final da função
        
tipoJ:
        li $v0, 1                  # Prepara o resultado para imprimir 2
        addi $a0, $zero, 2
        syscall
        b fim                      # Pula para o final da função
        
tipoI:
	subi $sp,$sp,4
	sw $ra, 0($sp)

   	li $v0, 1
   	addi $a0, $zero, 3 
   	syscall
	
	jal pegaRS                   #Pega qual registrador esta no RS do binario e deixa em $t5
	jal pegaRT                   #Pega qual registrador esta no RT do binario e deixa em $t6
	jal pegaImediato             #Pega valor do Imdiato do binario e deixa em $t7
	
	move $t4, $t5
	jal pegaRegistradorVirtual
	move $t5, $t4
	
	move $t4, $t6
	jal pegaRegistradorVirtual
	move $t6, $t4
	
	addi $t9, $zero, 9
	beq $t8,$t9, processaADDI
	addi $t9, $zero, 43
	beq $t8, $t9, processaSW
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
        
pegaImediato:
   	lw $t0, 0($s7)
   	li  $t1, 0x0000FFFF
   	li  $t3  0x0000000F
   	and $t0, $t0, $t1          # $v0 = 5 BITS DE RS
   	
   	srl $t2,$t0, 12
   	beq $t2, $t3, extenderSinal
   	
        move $t7, $t0
        jr $ra
pegaRegistradorVirtual:
	mul $t4, $t4, 4
	la $t3, registers
	
	add $t3, $t4, $t3
	lw $t4, 0($t3)
	
	jr $ra
        
processaADDI:
	add $t5,$t6,$t7
	sw $t5, 0($t3)
	j retornaTipoI

processaSW:
	add $t7,$t5,$t7
	sw $t6, 0($t7)
	
	j retornaTipoI

fim:
        sw $v0, resultado          # Salva o resultado do processamento em resultado
        jr $ra                     # Retorna ao procedimento chamador

extenderSinal:
	li $t1, 0xFFFF0000
	or $t7, $t0, $1
	
	jr $ra
