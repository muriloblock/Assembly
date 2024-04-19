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
    mtc1 $v0, $f12          # Move o primeiro n�mero para o registrador de ponto flutuante $f12

    # Imprime mensagem para digitar o segundo n�mero
    li $v0, 4               # Carrega o c�digo do sistema para imprimir string
    la $a0, prompt_num2     # Carrega o endere�o da mensagem para imprimir
    syscall                 # Chama a syscall para imprimir a mensagem

    # L� o segundo n�mero
    li $v0, 5               # Carrega o c�digo do sistema para ler inteiro
    syscall                 # Chama a syscall para ler o n�mero
    mtc1 $v0, $f14          # Move o primeiro n�mero para o registrador de ponto flutuante $f12

    # Imprime o resultado da divis�o
    li $v0, 4               # Carrega o c�digo do sistema para imprimir string
    la $a0, result_msg      # Carrega o endere�o da mensagem para imprimir
    syscall                 # Chama a syscall para imprimir a mensagem

   # Calcula a divis�o em ponto flutuante
    cvt.s.w $f12, $f12      # Converte o primeiro n�mero para ponto flutuante
    cvt.s.w $f14, $f14      # Converte o segundo n�mero para ponto flutuante
    div.s $f0, $f12, $f14   # Divide $f12 por $f14 e armazena o resultado em $f0

    # Imprime o resultado da divis�o em ponto flutuante com 2 casas decimais
    li $v0, 2               # Carrega o c�digo do sistema para imprimir float
    mov.s $f12, $f0         # Move o resultado da divis�o para o registrador de ponto flutuante $f12
    syscall                 # Chama a syscall para imprimir o resultado em ponto flutuante

    # Sair do programa
    li $v0, 10              # Carrega o c�digo do sistema para sair do programa
    syscall                 # Chama a syscall para sair             # Chama a syscall para sair
