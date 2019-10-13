.data
.text
main:
	addi $s0, $zero, 8 #numero de discos
	addi $a1, $zero, 268500992 #posicion en memoria torre 1
	addi $a2, $zero, 268501024 #posicion en memoria torre 2
	addi $a3, $zero, 268501056 #posicion en memoria torre 3
	
	add $t0, $zero, $s0
	jal initialize #llenar torre 1
	
	addi $a0, $zero, 268501472 #apuntadores a las torres
	sw $a1, 0($a0)
	sw $a2, 4($a0)
	sw $a3, 8($a0)	
	addi $a1, $zero, 268501472
	addi $a2, $zero, 268501476
	addi $a3, $zero, 268501480
	
	add $t0, $zero, $s0
	
	sw $s0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	
	jal hanoi
	

	
	j end

		
initialize:
	sw $t0, 0($a1)
	addi $t0, $t0, -1 
	addi $a1, $a1, 4 
	
	bnez $t0, initialize
	jr $ra
	
	
hanoi:	
	sw $ra, 0($sp)
	
	lw $t0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	
	addi $t0, $t0, -1
	beqz $t0, return

	addi $sp, $sp, -20
			
	sw $t0, 4($sp)
	sw $s1, 8($sp)
	sw $s3, 12($sp)
	sw $s2, 16($sp)
	
	
	jal hanoi
	
	
	addi $sp, $sp, 20
	
	jal movedisk	
	
	lw $t0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	
	addi $t0, $t0, -1
	
	addi $sp, $sp, -20
	sw $t0, 4($sp)
	sw $s2, 8($sp)
	sw $s1, 12($sp)
	sw $s3, 16($sp)
    	
	jal hanoi
		
	
	addi $sp, $sp, 20
	
	lw $t5, 0($sp)	
	jr $t5
	
movedisk:
	lw $t1, 8($sp)
	lw $t3, 0($t1)
	lw $t2, 16($sp)
	lw $t4, 0($t2)
	
	addi $t3, $t3, -4 
	lw $t5, 0($t3)
	
	sw $zero, 0($t3)	
	sw $t5, 0($t4)
	
	
	addi $t4, $t4, 4
	
	sw $t3, 0($t1)	
	sw $t4, 0($t2)
	
	jr $ra		
	
return:
	jal movedisk
	lw $t5, 0($sp)
	jr $t5
	
end:
	