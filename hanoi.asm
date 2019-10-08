.data
.text
main:
	addi $s0, $zero, 8 #numero de discos
	addi $a1, $zero, 268500992 #posicion en memoria torre A
	addi $a2, $zero, 268501024 #posicion en memoria torre B
	addi $a3, $zero, 268501056 #posicion en memoria torre C
	
	
	add $t0, $zero, $s0
	jal initialize
	add $a0, $zero, $a1 #posicion en memoria del menor disco
		sw $s0, 0($a0)
	

	j end
	


initialize:
	sw $t0, 0($a1)
	addi $t0, $t0, -1 
	addi $a1, $a1, 4 
	
	bnez $t0, initialize
	addi $a1, $a1, -4 
	jr $ra
	
end: