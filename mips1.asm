.data
    valor: .word 10         # Definindo uma variável chamada 'valor' com o valor inicial 10

.text
    main:
        lw $t1, valor      # Carrega o valor da variável 'valor' para o registrador $t0
        addi $t0, $t1, 5   # Adiciona o valor imediato 5 ao registrador $t0
        # Agora $t0 contém 10 + 5 = 15
        
        # Aqui você pode realizar outras operações com $t0 ou usá-lo conforme necessário
        
        # Saída do programa (exemplo):
        li $v0, 1           # Carrega o código do sistema para imprimir inteiro ($v0 = 1)
        move $a0, $t0       # Move o conteúdo de $t0 para o argumento $a0 (para ser impresso)
        syscall             # Chama o sistema para imprimir o conteúdo de $a0 (15 neste caso)

        li $v0, 10          # Código do sistema para encerrar o programa ($v0 = 10)
        syscall             # Chama o sistema para encerrar o programa
