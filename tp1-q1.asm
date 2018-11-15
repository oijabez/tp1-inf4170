.data
	msg1:	.asciiz	"Ecrire la taille du tableau : "
	msg2:	.asciiz	"\nEntrer les valeurs du tableau avec enter : "
.text
.globl 	


	# Lire l'entrée
	li	$v0, 4 			
	la	$a0, msg1 	# Mettre la valeur de l'argument à partir de l'entrée
	syscall
	
	# Lire l'entier dans $v0
	li	$v0, 5 		
	syscall
	
	add	$a0, $v0, $0 	# Mettre $v0 en tant qu'une entrée ($a0) $a0 = $v0 + 0
	#jal 	fib_iter 	# Copier l'adresse de sortie dans $ra et executer Tableau


	# Imprimer la taille de tableau
	add	$a0, $v0, $0	# Mettre $v0 en tant qu'une entrée ($a0) $a0 = $v0 + 0
	li	$v0, 1		# Imprimer l'entier dans $a0
	syscall			
	
	#-----------------------------------------------------------
	
	# Lire l'entrée de donnéss
	li	$v0, 4 			
	la	$a0, msg2 	# Mettre la valeur de l'argument à partir de l'entrée
	syscall
	
	# Lire l'entier dans $v0
	li	$v0, 5 		
	syscall
	
	add	$a0, $v0, $0 	# Mettre $v0 en tant qu'une entrée ($a0) $a0 = $v0 + 0
	#jal 	fib_iter 	# Copier l'adresse de sortie dans $ra et executer Tableau

	
	# Imprimer le resultat
	add	$a0, $v0, $0	# Mettre $v0 en tant qu'une entrée ($a0) $a0 = $v0 + 0
	li	$v0, 1		# Imprimer l'entier dans $a0
	syscall			
	

	# Exit 
	li	$v0, 10 	#Code 10 de syscall
	syscall


	#-----------------------------------------------------------

	#int getLeftChildIndex(int index)
	getLeftChildIndex: 
  		move 	$t0, $a1  
  		sll 	$t1, $t0, 1  
  		addi 	$t1, $t1, 1
  		#return 2 * index + 1
  		bgt 	$t1, $a2, Fin_boucleLeftChild
  	
  	
  	#-------------------------------------------------------------
  	
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
