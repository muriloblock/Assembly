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
    mtc1 $v0, $f12          # Move o primeiro número para o registrador de ponto flutuante $f12

    # Imprime mensagem para digitar o segundo número
    li $v0, 4               # Carrega o código do sistema para imprimir string
    la $a0, prompt_num2     # Carrega o endereço da mensagem para imprimir
    syscall                 # Chama a syscall para imprimir a mensagem

    # Lê o segundo número
    li $v0, 5               # Carrega o código do sistema para ler inteiro
    syscall                 # Chama a syscall para ler o número
    mtc1 $v0, $f14          # Move o primeiro número para o registrador de ponto flutuante $f12

    # Imprime o resultado da divisão
    li $v0, 4               # Carrega o código do sistema para imprimir string
    la $a0, result_msg      # Carrega o endereço da mensagem para imprimir
    syscall                 # Chama a syscall para imprimir a mensagem

   # Calcula a divisão em ponto flutuante
    cvt.s.w $f12, $f12      # Converte o primeiro número para ponto flutuante
    cvt.s.w $f14, $f14      # Converte o segundo número para ponto flutuante
    div.s $f0, $f12, $f14   # Divide $f12 por $f14 e armazena o resultado em $f0

    # Imprime o resultado da divisão em ponto flutuante com 2 casas decimais
    li $v0, 2               # Carrega o código do sistema para imprimir float
    mov.s $f12, $f0         # Move o resultado da divisão para o registrador de ponto flutuante $f12
    syscall                 # Chama a syscall para imprimir o resultado em ponto flutuante

    # Sair do programa
    li $v0, 10              # Carrega o código do sistema para sair do programa
    syscall                 # Chama a syscall para sair             # Chama a syscall para sair
