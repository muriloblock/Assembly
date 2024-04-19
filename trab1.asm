.data  
myFile: .asciiz "C:\\Users\\Murilo\\Desktop\\trabalho_01-2024_1.bin"      # filename for input
buffer: .space 1024
.text

# Open file for reading

li   $v0, 13          # system call for open file
la   $a0, myFile      # input file name
li   $a1, 0           # flag for reading
li   $a2, 0           # mode is ignored
syscall               # open a file 
move $s0, $v0         # save the file descriptor  


# reading from file just opened

li   $v0, 14        # system call for reading from file
move $a0, $s0       # file descriptor 
la   $a1, buffer    # address of buffer from which to read
li   $a2,  1000     # hardcoded buffer length
syscall             # read from file

#la $t0, buffer         # carregar endere�o do buffer
#jal execute_instructions  # chamar fun��o para executar instru��es

# Printing File Content
li  $v0, 4          # system Call for PRINT STRING
la  $a0, buffer     # buffer contains the values
syscall             # print int

li $v0, 10      # Finish the Program
syscall