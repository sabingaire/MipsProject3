//Created new file
.data
    max_input: .space 10000
    start1: .asciiz "Enter the string: "
    not_valid: .asciiz "NaN"
    large_than_4: .asciiz "NaN"
.text
    main:
    li $v0, 4
    la $a0, start1
    syscall

    #Taking input from the user
          li $v0, 8
          la $a0, max_input
          li $a1, 1001
          syscall
