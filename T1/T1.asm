.data
    nomeArquivo: .asciiz "arquivo.bin"
    fileWords: .space 1024
    resultado: .word 0          # Vari�vel para armazenar o resultado do processamento

.text
    .globl main
    main:
        la $a0, nomeArquivo        # Endere�o do arquivo a ser aberto
        jal abrirArquivo           # Chama a fun��o para abrir o arquivo
        
        move $s0, $v0              # Salva o descritor de arquivo em $s0
        
        li $v0, 14                 # C�digo da syscall para ler o arquivo
	move $a0, $s0              # Descritor de arquivo
	la $a1, fileWords          # Buffer para armazenar os bytes lidos
	li $a2, 4                  # N�mero de bytes a serem lidos (4 bytes)
	syscall

	move $t7, $a1              # Salva o endere�o do buffer em $t1

        
        jal pega_tipo_instrucao    # Determina o tipo da instru��o
        
        li $v0, 10                 # C�digo da syscall para sair do programa
        syscall

abrirArquivo:
        li $v0, 13                 # C�digo da syscall para abrir arquivo
        li $a1, 0                  # Modo de abertura (0 para leitura)
        syscall
        jr $ra

pega_tipo_instrucao:
	lw $t0, 0($t7)             # Carrega o valor lido do arquivo de $t1 para $t0
        li $t1, 0xFC000000         # M�scara para isolar os primeiros 6 bits do opcode
        and $t0, $t0, $t1          # Isola os primeiros 6 bits do opcode
        srl $t0, $t0, 26           # Desloca para a direita para obter o valor do opcode
        
        # Verifica o tipo da instru��o com base no opcode
        beq $t0, 0, tipoR          # Se opcode == 0, � do tipo R
        beq $t0, 2, tipoJ          # Se opcode == 2, � do tipo J
        beq $t0, 3, tipoJ          # Se opcode == 3, � do tipo J
        j tipoI                    # Caso contr�rio, � do tipo I
        
tipoR:
        li $v0, 1                  # Prepara o resultado para imprimir 1
        addi $a0, $zero, 1
        syscall
        b fim                      # Pula para o final da fun��o
        
tipoJ:
        li $v0, 1                  # Prepara o resultado para imprimir 2
        addi $a0, $zero, 2
        syscall
        b fim                      # Pula para o final da fun��o
        
tipoI:
   	li $v0, 1
   	addi $a0, $zero, 3 
   	syscall
   	
   	lw $t0, 0($t7)             # Carrega o valor lido do arquivo de $t1 para $t0
        li  $t1, 0x03E00000        # $t1 = MASCARA PARA ISOLAR 5 BITS DE RS
        and $t0, $t0, $t1          # $v0 = 5 BITS DE RS
        srl $t0, $t0, 21 	   # $v0 = SHIFT DIREITA 21 BITS
        move $t5, $t0	     
   	
   	li  $t1, 0x001F0000        # $t1 = MASCARA PARA ISOLAR 5 BITS DE RT
   	and $t0, $t0, $t1          # $v0 = 5 BITS DE RS
        srl $t0, $t0, 21 	   # $v0 = SHIFT DIREITA 21 BITS
   	
   	li  $t1, 0x0000FFFF
   	and $t0, $t0, $t1          # $v0 = 5 BITS DE RS
        srl $t0, $t0, 21 	   # $v0 = SHIFT DIREITA 21 BITS

   	
fim:
        sw $v0, resultado          # Salva o resultado do processamento em resultado
        jr $ra                     # Retorna ao procedimento chamador
