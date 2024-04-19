.data
    espaco: .asciiz " "        # String para espaço
    asterisco: .asciiz "*"     # String para asterisco
    altura: .word 0             # Variável para armazenar a altura

.text
    li $v0, 5                   # Carrega a syscall 5 (leitura de inteiro)
    syscall                     # Chama a syscall para ler um inteiro
    sw $v0, altura              # Armazena o valor lido em altura

    loop_externo:
        lw $t0, altura          # Carrega o valor de altura em $t0
        beq $t0, $zero, sair    # Se altura for zero, sai do loop externo
        subi $t0, $t0, 1        # Subtrai 1 de $t0
        sw $t0, altura          # Armazena o novo valor de altura
        j loop_linha            # Pula para o loop interno

    loop_linha:
        lw $t0, altura          # Carrega o valor de altura em $t0
        beq $t0, $zero, sair_loop_linha  # Se altura for zero, sai do loop
        subi $t0, $t0, 1        # Subtrai 1 de $t0
        li $v0, 4               # Carrega a syscall 4 (impressão de string)
        la $a0, asterisco       # Carrega o endereço da string asterisco em $a0
        syscall                 # Chama a syscall para imprimir o asterisco
        j loop_linha            # Volta para o início do loop

    sair_loop_linha:
        j loop_externo           # Volta para o loop externo

    sair:
        li $v0, 10              # Carrega a syscall 10 (saída do programa)
        syscall                 # Chama a syscall para sair do programa
