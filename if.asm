.data
prompt_num1: .asciiz "Digite o primeiro n�mero: "
prompt_num2: .asciiz "Digite o segundo n�mero: "
result_msg: .asciiz "O resultado da divis�o �: "

.text
main:
    # Imprime mensagem para digitar o primeiro n�mero
    li $v0, 4               # Carrega o c�digo do sistema para imprimir string
    la $a0, prompt_num1     # Carrega o endere�o da mensagem para imprimir
    syscall                 # Chama a syscall para imprimir a mensagem

    # L� o primeiro n�mero
    li $v0, 5               # Carrega o c�digo do sistema para ler inteiro
    syscall                 # Chama a syscall para ler o n�mero
    move $s0, $v0           # Salva o primeiro n�mero em $s0

    # Imprime mensagem para digitar o segundo n�mero
    li $v0, 4               # Carrega o c�digo do sistema para imprimir string
    la $a0, prompt_num2     # Carrega o endere�o da mensagem para imprimir
    syscall                 # Chama a syscall para imprimir a mensagem

    # L� o segundo n�mero
    li $v0, 5               # Carrega o c�digo do sistema para ler inteiro
    syscall                 # Chama a syscall para ler o n�mero
    move $s1, $v0           # Salva o segundo n�mero em $s1

    # Divide os n�meros
    div $s0, $s1            # Divide $s0 (primeiro n�mero) por $s1 (segundo n�mero)

    # Imprime o resultado da divis�o
    li $v0, 4               # Carrega o c�digo do sistema para imprimir string
    la $a0, result_msg      # Carrega o endere�o da mensagem para imprimir
    syscall                 # Chama a syscall para imprimir a mensagem

    # Imprime o resultado da divis�o (em $lo)
    mflo $a0                # Move o resultado da divis�o (em $lo) para $a0 para imprimir
    li $v0, 1               # Carrega o c�digo do sistema para imprimir inteiro
    syscall                 # Chama a syscall para imprimir o resultado

    # Sair do programa
    li $v0, 10              # Carrega o c�digo do sistema para sair do programa
    syscall                 # Chama a syscall para sair
