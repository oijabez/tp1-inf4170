#
  
.data
# le tableau a des chiffres pas ordones
tableau: .word 84, 27, 55, 3, 5, 20, 13, 2, 86, 11, 58, 19, 21, 85, 1, 23, 60, 93, 80, 24, 37, 7, 8, 35, 18
taille: .word 25
espace: .asciiz " "
nouvelle_ligne: .asciiz "\n"


.text
.globl main

main:

	la	$a0, tableau	# a0 = &tableau
  
	la	$t0, taille
	lw	$a1, 0($t0)	# a1 = taille(tableau)
  
	jal	Tas_sort

	# imprimer letableau
	move	$t0, $a0
	add	$t1, $zero, $zero

	imprimer_boucle:
  		li	$v0, 1
  		lw	$a0, 0($t0)
  		
  		addi	$t0, $t0, 4
		addi 	$t1, $t1, 1
  		syscall
		
		li 	$v0, 4
		la	$a0, espace 
		syscall
  
		bne	$t1, $a1, imprimer_boucle	# while( t1 != taille )
		
		li	$v0, 4
		la	$a0, nouvelle_ligne
		syscall
		li	$v0,10
		syscall
  
	Faire:
  		jr	$ra

	
	# a0 = &tableau, a1 = taille(tableau)
	Tas_sort:	
		addi 	$sp, $sp, -12
		sw	$a1, 0($sp)	# garder taille
  		sw 	$a2, 4($sp)  	# garder a2
  		sw 	$ra, 8($sp)  	# garder l'adresse a retourner
  
  		move 	$a2, $a1  	# n garde dans a2
  		addi 	$a2, $a2, -1	# n = taille - 1
  		
  		ble 	$a2,$zero, Tas_Fin 	# if (n <= 0 ) return;
  		jal 	creer_tas		# a0 = tab, a1 = taille
  		add 	$a1, $zero, $zero 	# clear $a1
  		
  		
	# void swap(int i,int j) 		
	Boucle_Tas_sort:
	
  		lw 	$t0, 0($a0)
  		sll 	$t1, $a2, 2  
  		add 	$t1, $t1, $a0
  		
  		lw 	$t2, 0($t1)
  		sw 	$t0, 0($t1)
  		sw 	$t2, 0($a0)
  
  		addi	$a2, $a2, -1 
  		jal	getLeftChildIndex  
 		bnez 	$a2, Boucle_Tas_sort

	Tas_Fin:
  		lw 	$ra, 8($sp)
  		lw 	$a2, 4($sp)
  		lw 	$a1, 0($sp)
  		addi 	$sp, $sp, 12
  		jr 	$ra
  
creer_tas: # a0 = &tableau, a1 = taille
  addi $sp, $sp, -12
  sw $a1, 0($sp)
  sw $a2, 4($sp)
  sw $ra, 8($sp)
  
  addi $a2, $a1, -1  # a2 = taille - 1
  
  addi $a1, $a1, -1  # debout_indice = taille - 1
  srl $a1, $a1, 1  # debout_indice /= 2
  
  blt $a1, $zero, finalizer_tas  # if(debout_indice < 0) return

  
#fixHeap(int rootIndex, int lastIndex)     
boucle_tas:
	jal 	getLeftChildIndex 
  	addi 	$a1, $a1, -1
  	ble 	$zero, $a1, boucle_tas
  
finalizer_tas:
  lw $ra, 8($sp)
  lw $a2, 4($sp)
  lw $a1, 0($sp)
  addi $sp, $sp, 12
  jr $ra


#int getLeftChildIndex(int index)
getLeftChildIndex: 
  	move 	$t0, $a1  
  	sll 	$t1, $t0, 1  
  	addi 	$t1, $t1, 1
  	#return 2 * index + 1
  	bgt 	$t1, $a2, Fin_boucleLeftChild
  
boucleLeftChild:

  #if ( enfant < fin && tab[enfant] < tab[enfant+1] )
  ble $a2, $t1, Changement
  sll $t3, $t1, 2  # get bytes(enfant)
  add $t3, $t3, $a0
  lw $t3, 0($t3)  # t3 = tab[enfant]
  sll $t4, $t1, 2 #get bytes(enfant)
  addi $t4, $t4, 4 #t4 = bytes(enfant+1)
  add $t4, $t4, $a0
  lw $t4, 0($t4)  #t4 = tab[enfant+1]
  ble $t4, $t3, Changement
  
  addi $t1, $t1, 1  # enfant++
  
Changement:
  sll $t3, $t0, 2  # get bytes(index)
  add $t3, $t3, $a0
  lw $t4, 0($t3)  #t4 = tab[index], t3 = &tab[index]
  
  sll $t5, $t1, 2  # get bytes(enfant)
  add $t5, $t5, $a0
  lw $t6, 0($t5)  #t6 = tab[enfant], t5 = &tab[enfant]
  
  ble $t6, $t4, Fin_boucleLeftChild
  
  # swap(tab[index],tab[enfant])
  # note: t4 = tab[index], t6 = tab[enfant], t3 = &tab[index], t5 = &tab[enfant]
  sw $t4, 0($t5)
  sw $t6, 0($t3)
  
  move $t0, $t1  # indice = enfant
  
  sll $t1, $t0, 1  # enfant = indice * 2 + 1
  addi $t1, $t1, 1
  ble $t1, $a2, boucleLeftChild
  
Fin_boucleLeftChild:
  jr $ra
