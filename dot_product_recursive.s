.data
arr1: .word 1, 2, 3, 4, 5
arr2: .word 6, 7, 8, 9, 10
line: .string "The dot product is: "
.text
main:
    la a0, arr1        # Loading address of arr1[] to x8
    la a1, arr2        # Loading address of arr2[] to x9
    li a2, 5           # x5 = 5
    addi t0, x0, 1     # t0 = 1
    
    jal recu
    
    mv t3, a0
    # print line
    li a0, 4                    
    la a1, line
    ecall
    # print value
    li a0, 1                    
    mv a1, t3
    ecall
    # break program
    li a0, 10                       
    ecall
    
    
recu:
    # size == 1 jump to exit
    beq a2, t0, exit         
    
    # save ra register on to the stack
    addi sp, sp, -12
    sw a0, 8(sp)
    sw a1, 4(sp)
    sw ra, 0(sp)
    
    addi a0, a0, 4 # arr1 += 1
    addi a1, a1, 4  # arr2 += 1
    addi a2, a2, -1  # size -= 1
    
    jal recu

    # load ra register on to the stack
    lw t1, 8(sp)
    lw t2, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 12

    lw t1, 0(t1)
    lw t2, 0(t2)
    
    mul t1, t1, t2
    add a0, a0, t1
   
    jr ra
    
exit:
    # return
    lw t1, 0(a0)                    # arr1[0]
    lw t2, 0(a1)                    # arr2[0]
    mul a0, t1, t2                  # arr1[0]*arr2[0]
    jr ra