.data
    myIntegerA: .word 9       # Define a variable myIntegerA with value 9
    myIntegerB: .word 2       # Define a variable myIntegerB with value 2

.text
    lw $t0, myIntegerA       # Load the value of myIntegerA into $t0
    mtc1.d $t0, $f0          # Move the integer value from $t0 to $f0 (floating-point register)
    cvt.d.w $f0, $f0         # Convert the integer value in $f0 to double precision

    lw $t1, myIntegerB       # Load the value of myIntegerB into $t1
    mtc1.d $t1, $f2          # Move the integer value from $t1 to $f2 (floating-point register)
    cvt.d.w $f2, $f2         # Convert the integer value in $f2 to double precision

    div.d $f12, $f0, $f2     # Divide the double values in $f0 and $f2, store the result in $f12 (double register)

    li $v0, 3                # Load the system call code for printing a double
    syscall                  # Execute the system call to print the double value in $f12
