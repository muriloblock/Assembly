.data
    valor: .word 10         # Definindo uma vari�vel chamada 'valor' com o valor inicial 10

.text
    main:
        lw $t1, valor      # Carrega o valor da vari�vel 'valor' para o registrador $t0
        addi $t0, $t1, 5   # Adiciona o valor imediato 5 ao registrador $t0
        # Agora $t0 cont�m 10 + 5 = 15
        
        # Aqui voc� pode realizar outras opera��es com $t0 ou us�-lo conforme necess�rio
        
        # Sa�da do programa (exemplo):
        li $v0, 1           # Carrega o c�digo do sistema para imprimir inteiro ($v0 = 1)
        move $a0, $t0       # Move o conte�do de $t0 para o argumento $a0 (para ser impresso)
        syscall             # Chama o sistema para imprimir o conte�do de $a0 (15 neste caso)

        li $v0, 10          # C�digo do sistema para encerrar o programa ($v0 = 10)
        syscall             # Chama o sistema para encerrar o programa
