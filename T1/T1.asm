.data
    nomeArquivo: .asciiz "arquivo.txt"
    fileWords: .space 1024	
	
.text
    .globl main
    main:
        la $a0, nomeArquivo     	# Carrega o endereço do arquivo.txt
        jal abrirArquivo
        
        move $s0, $v0        	# Salva o descritor de arquivo em $s0
        
        li $v0, 14		        # Código da syscall para ler o arquivo = 14
        move $a0, $s0		    # Descritor de arquivo
        la $a1, fileWords  	    # O buffer que contém a string do arquivo inteiro
        li $a2, 4		        # Número de bytes a serem lidos (4 bytes)
        syscall
        
        # Imprime o que está no arquivo
        li $v0, 4		        # Código da syscall para imprimir string = 4
        la $a0, fileWords
        syscall
        
        # Fecha o arquivo
        li $v0, 16         	# Código da syscall para fechar o arquivo = 16
        move $a0, $s0      	# Descritor de arquivo a fechar
        syscall
        
        li $v0, 10          # Código da syscall para sair do programa
        syscall

abrirArquivo:
        li $v0, 13          # Código da syscall para abrir arquivo = 13
        li $a1, 0           # Modo de abertura (0 para leitura)
        syscall

        jr $ra
