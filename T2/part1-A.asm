.data
    g1: .word 0          # Variável global g1
    g2: .word 0          # Variável global g2
    inc1: .word 0        # Variável local inc1
    inc2: .word 0        # Variável local inc2

.text
.globl main

# Função main
main:
    # Inicialização das variáveis globais
    li $t0, 10           # Carrega 10 em $t0 (g1 = 10; g2 = 10;)
    sw $t0, g1           # Armazena 10 em g1
    sw $t0, g2           # Armazena 10 em g2

    # Antes das chamadas de função:
    # g1 = 10, g2 = 10, inc1 = não definido, inc2 = não definido
    
    # Chamada de incrementa1(g1)
    lw $a0, g1           # Carrega o valor de g1 em $a0 (inc1 = incrementa1(g1);)
    jal incrementa1      # Chama a função incrementa1
    sw $v0, inc1         # Armazena o valor retornado em inc1
    
    # Após incrementa1:
    # g1 = 10, g2 = 10, inc1 = 11, inc2 = não definido

    # Chamada de incrementa2(&g2)
    la $a0, g2           # Carrega o endereço de g2 em $a0 (inc2 = incrementa2(&g2);)
    jal incrementa2      # Chama a função incrementa2
    sw $v0, inc2         # Armazena o valor retornado em inc2

    # Após incrementa2:
    # g1 = 10, g2 = 11, inc1 = 11, inc2 = 11

    li $v0, 10           # Código para terminar o programa (return 0;)
    syscall              # Chama o sistema para terminar o programa

# Função incrementa2 (int incrementa2(int *y) {...})
incrementa2:
    # Mapa da pilha para incrementa2
    # |--------------------|
    # | Return address     | <- $ra (salvo)
    # |--------------------|
    
    addi $sp, $sp, -4    # Ajusta a pilha para salvar o endereço de retorno
    sw $ra, 0($sp)       # Salva o endereço de retorno

    lw $t0, 0($a0)       # Carrega o valor apontado por y (primeiro argumento) em $t0 (*y = *y + 1;)
    addi $t0, $t0, 1     # Incrementa o valor de $t0
    sw $t0, 0($a0)       # Armazena o valor incrementado de volta em *y
    move $v0, $t0        # Coloca o valor de retorno em $v0 (return *y;)

    lw $ra, 0($sp)       # Restaura o endereço de retorno
    addi $sp, $sp, 4     # Ajusta a pilha de volta
    jr $ra               # Retorna da função

# Função incrementa1 (int incrementa1(int x) {...})
incrementa1:
    # Mapa da pilha para incrementa1
    # |--------------------|
    # | Return address     | <- $ra (salvo)
    # |--------------------|
    
    addi $sp, $sp, -4    # Ajusta a pilha para salvar o endereço de retorno
    sw $ra, 0($sp)       # Salva o endereço de retorno

    addi $a0, $a0, 1     # Incrementa o valor de x (primeiro argumento) (x = x + 1;)
    move $v0, $a0        # Coloca o valor de retorno em $v0 (return x;)

    lw $ra, 0($sp)       # Restaura o endereço de retorno
    addi $sp, $sp, 4     # Ajusta a pilha de volta
    jr $ra               # Retorna da função
