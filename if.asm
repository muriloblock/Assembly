.data
prompt_num1: .asciiz "Digite o primeiro número: "
prompt_num2: .asciiz "Digite o segundo número: "
result_msg: .asciiz "O resultado da divisão é: "

.text
main:
    # Imprime mensagem para digitar o primeiro número
    li $v0, 4               # Carrega o código do sistema para imprimir string
    la $a0, prompt_num1     # Carrega o endereço da mensagem para imprimir
    syscall                 # Chama a syscall para imprimir a mensagem

    # Lê o primeiro número
    li $v0, 5               # Carrega o código do sistema para ler inteiro
    syscall                 # Chama a syscall para ler o número
    move $s0, $v0           # Salva o primeiro número em $s0

    # Imprime mensagem para digitar o segundo número
    li $v0, 4               # Carrega o código do sistema para imprimir string
    la $a0, prompt_num2     # Carrega o endereço da mensagem para imprimir
    syscall                 # Chama a syscall para imprimir a mensagem

    # Lê o segundo número
    li $v0, 5               # Carrega o código do sistema para ler inteiro
    syscall                 # Chama a syscall para ler o número
    move $s1, $v0           # Salva o segundo número em $s1

    # Divide os números
    div $s0, $s1            # Divide $s0 (primeiro número) por $s1 (segundo número)

    # Imprime o resultado da divisão
    li $v0, 4               # Carrega o código do sistema para imprimir string
    la $a0, result_msg      # Carrega o endereço da mensagem para imprimir
    syscall                 # Chama a syscall para imprimir a mensagem

    # Imprime o resultado da divisão (em $lo)
    mflo $a0                # Move o resultado da divisão (em $lo) para $a0 para imprimir
    li $v0, 1               # Carrega o código do sistema para imprimir inteiro
    syscall                 # Chama a syscall para imprimir o resultado

    # Sair do programa
    li $v0, 10              # Carrega o código do sistema para sair do programa
    syscall                 # Chama a syscall para sair
