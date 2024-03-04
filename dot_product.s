.data
arr1: .word 1, 2, 3, 4, 5
arr2: .word 6, 7, 8, 9, 10
line: .string "The dot product is: "
newline: .string "\n"
.text
main:
    addi x5, x0, 5  # let x5 be size and set it to 10.
    addi x6, x0, 0   # let x6 be sop and set it to 0. 
    addi x8, x0, 0 # let x8 be i and set it to 0
    la x9, arr1 # loading the address of arr1 to x9
    la x21, arr2 # loading the address of arr2 to x21
loop1:
    bge x8 , x5, exit1 
    slli x18,x8, 2 # set x18 to i*4
    add x19, x18, x9 # add i*4 to the base address off arr1 and put it to x19
    add x23, x18, x21 # add i*4 to the base address off arr2 and put it to x21
    lw x20, 0(x19) # arr1 load word
    lw x24, 0(x23) # arr2 load word
    mul x25, x20, x24 # arr1 * arr2
    add x6, x6, x25 # sop = arr1 * arr2
    addi x8, x8, 1 # i++
    j loop1
    
exit1:
#   print a newline character; print_string
    addi a0, x0, 4
    la a1, line
    ecall
#   print value sop
    addi a0, x0, 1
    add a1, x0, x6
    ecall    
#   start new line
    addi a0, x0, 4
    la a1, newline
    ecall
#   exit program
    addi a0, x0, 10
    ecall