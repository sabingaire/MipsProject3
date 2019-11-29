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

          #Now loading the register with the input of the user
           la $s0, max_input
           li $s1, 0 			#start pointer
           li $s2, 0			#end pointer

           word_list:
               la $s1, ($s2)

           substring:
               add $t1, $s0, $s2 	#iterator
               lb $t2, 0($t1) 		#loading the current character

            #Now checking for the different values where substring stops
            beq $t2, 0, end_of_substring  #Checking null value
            beq $t2, 10, end_of_substring   #Checking for space
            beq $t2, 44, end_of_substring   #Checking for command

            #Now increasing the counter
            add $s2, $s2, 1
            j substring

        end_of_substring:
        	#loading arguments to make a subprogram_2 call
            la $a0, ($s1)
            la $a1, ($s2)
            
            #Calling subprogram to call other function
            jal subprogram_2

            #calling subprogram3 using jump-and-link
            jal subprogram_3
