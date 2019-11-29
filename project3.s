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

            beq $t2, 0, end_wl
            beq $t2, 10, end_wl

            addi $s2, $s2, 1 	# $s2 += 1

            #formatting the print values with comma
            li $v0, 11
            li $a0, 44
            syscall
            j word_list
        end_wl:
        	#This following set of lines is to end the program
            li $v0, 10
            syscall

            subprogram_2:
                la $s7, ($ra)	#loading the value from $ra to register $s7
                la $t9, ($a0)	#loading the value from $a0 to register $t9

                addi $t8, $a1, 0 #storing the end address
                la $t7, max_input  #loading the first address of the user input


            space_front:
                beq $t9, $t8, end_deletion  #exiting the loop
                add $t6, $t7, $t9
                lb $t5, ($t6)
                #keep looping if there is still space
                beq $t5, 32, addup
                beq $t5, 9, addup
                j space_back #clearing the spaces from the end if the current char is not a space.
            addup:
                addi $t9, $t9, 1
                j space_front

            space_back:
                beq $t9, $t8, end_deletion
                add $t6, $t7, $t8
                addi $t6, $t6, -1
                lb $t5, ($t6)
                beq $t5, 32, adddown
                beq $t5, 9, adddown
                j end_deletion

          adddown:
                  addi $t8, $t8, -1
                  j space_back

          end_deletion:
              beq $t9, $t8, not_a_number # if there is no character in a string, it's a NAN
              li $t4, 0 				   # first decimal value
              li $s6, 0 				   #length of the string

          convert:
            #converting the characters calling the subprogram1 and the returned values will be in $v0 and $v1
              beq $t9, $t8, end_convert
              add $t6, $t7, $t9
              lb $t5, ($t6)
              la $a0, ($t5)
              jal sub_program1
              bne $v0, 0, continue
              j not_a_number
