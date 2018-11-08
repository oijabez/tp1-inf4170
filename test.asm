		.data
list:		.word 5
        .word 7
        .word 4
        .word 6
        .word 3
        .word 8
        .word 2
        .word 9
        .word 0
        .word 30
        .word 31
        .word 39
        .word 32
        .word 38
        .word 33
        .word 37
        .word 34
        .word 36
        .word 35
        .word 20
        .word 21
        .word 29
        .word 22
        .word 28
        .word 23
        .word 27
        .word 24
        .word 26
        .word 25
        .word 10
        .word 11
        .word 19
        .word 12
        .word 18
        .word 13
        .word 17
        .word 14
        .word 16
        .word 15
        .word 1			# last array element
        .word -1			# not part of array
prompt1:.asciiz "\nPlease enter an array element: "
prompt2:.asciiz "\nPlease enter a search target: "
space:	.asciiz " "
nfound:	.asciiz "\nThe target was not found."
found:	.asciiz "\nThe target was found at array location "

        .text
        .globl main
main:		add $t0, $zero, $zero	# [main]
        add $t1, $zero, $zero	#
        addi $t2, $zero, 39	#
        addi $t3, $zero, 39	#
        add $t4, $zero, $zero	#
        add $t5, $zero, $zero	#
        add $t6, $zero, $zero	#
    #		add $t7, $zero, $zero	#
        la $t8, list

read:		addi $v0, $zero, 4	# [read]
        la $a0, prompt1		#
        syscall
        addi $v0, $zero, 5	#
        syscall
        sll $t7, $t0, 2		#
        add $t9, $t8, $t7
        sw $v0, 0($t9)
        addi $t0, $t0, 1		#
        ble $t0, $t2, read	#
		
# add the code that is missing from right here
        add $t0, $zero, $zero	#
		
search:	add $t1, $zero, $zero

search2:	lw $t4, 0($t9)
        lw $t5, 1($t9)
        sgt $t7, $t4, $t5
        sw $t4, 0($t9)
        sw $t5, 1($t9)
        add $t1, $t1, 1
        blt $t1, $t3, search2
        sub $t3, $t3, 1
        add $t0, $t0, 1
        blt $t0, $t2, search
		
print:	addi $v0, $zero, 1	# [print]
        sll $t7, $t0, 2		#
        add $t9, $t8, $t7
        lw $a0, 0($t9)
        syscall
        addi $v0, $zero, 4	#
        la $a0, space		#
        syscall
        addi $t0, $t0, 1		#
        ble $t0, $t2, print	#

end:		addi $v0, $zero, 10	# [end]
		    syscall