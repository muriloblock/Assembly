.data
    msg: .asciiz "Digite um numero inteiro: "
    newline: .asciiz "\n"
    asterisco: .asciiz "*"
    espaco: .asciiz " "
    altura: .word 0

.text
    main:
        # imprimir mensagem
        li $v0, 4           # carrega o código da syscall 4 (imprimir string)
        la $a0, msg         # carrega o endereço da mensagem para imprimir
        syscall             # chama a syscall para imprimir a mensagem

        # ler número inteiro
        li $v0, 5           # carrega o código da syscall 5 (ler inteiro)
        syscall             # chama a syscall para ler o número
        sw $v0, altura      # move o número lido para a variável altura

        # inicializar contador de linhas
        li $t1, 0           # contador de linhas

    loop:
        lw $t0, altura
        beq $t0, $zero, sair  # Verifica se a altura (armazenada em $t2) chegou a zero
        jal loop_linha        # Chama a função para imprimir uma linha de asteriscos
        lw $t0, altura
        addi $t0, $t0, -1     # Subtrai 1 do número carregado
        sw $t0, altura
        j loop                # Volta para o início do loop

    sair:
        # sair do programa
        li $v0, 10            # carrega o código da syscall 10 (sair do programa)
        syscall               # chama a syscall para sair do programa

    loop_linha:
        lw $t0, altura        # carrega o número lido para o registrador $t0
        beq $t1, $t0, fim_loop  # verifica se o contador de linhas é igual à altura digitada
        addi $t1, $t1, 1      # incrementa o contador de linhas
        jal imprimir_asterisco  # chama a sub-rotina para imprimir asteriscos
        j loop_linha          # volta para o início do loop de linhas

    fim_loop:
        jr $ra                # retorna para o chamador da sub-rotina

    imprimir_asterisco:
        li $v0, 4             # carrega o código da syscall 4 (imprimir string)
        la $a0, asterisco     # carrega o endereço do asterisco para imprimir
        syscall               # chama a syscall para imprimir o asterisco
        jr $ra                # retorna para o chamador da sub-rotina
