#By:
#Alessandro Pallaro Gómez is709389
#Héctor Chávez Morales	is710003

.data
.text
main:
	addi $s0, $zero, 8 #total disks
	addi $a1, $zero, 268500992 #memory position for tower 1
	addi $a2, $zero, 268501024 #memory position for tower 2
	addi $a3, $zero, 268501056 #memory position for tower 3
	
	add $t0, $zero, $s0
	jal initialize #put all the disks in tower 1
	
	addi $a0, $zero, 268501472 #pointers to towers
	sw $a1, 0($a0)#tower 1 pointer
	sw $a2, 4($a0)#tower 2 pointer
	sw $a3, 8($a0)#tower 3 pointer
	addi $a1, $zero, 268501472#memory position for tower 1 pointer
	addi $a2, $zero, 268501476#memory position for tower 2 pointer
	addi $a3, $zero, 268501480#memory position for tower 3 pointer
	
	sw $s0, 4($sp)#first push to stack, size
	sw $a1, 8($sp)#first push to stack, tower 1
	sw $a2, 12($sp)#first push to stack, tower 2
	sw $a3, 16($sp)#first push to stack , tower 3
	
	jal hanoi
		
	j end
		
initialize:
	sw $t0, 0($a1) #add disk to tower A
	addi $t0, $t0, -1 #change disk value
	addi $a1, $a1, 4 #change memory position
	
	bnez $t0, initialize#do it until the disk value is zero
	jr $ra	
	
hanoi:	
	sw $ra, 0($sp)#push to stack, return address
	
	lw $t0, 4($sp)#obtain size
	lw $s1, 8($sp)#obtain source tower
	lw $s2, 12($sp)#obtain auxiliar tower
	lw $s3, 16($sp)#obtain destination tower
	
	addi $t0, $t0, -1#change size
	beqz $t0, return#if size is zero then stop

	addi $sp, $sp, -20#push stack
			
	sw $t0, 4($sp)#push to stack new size
	sw $s1, 8($sp)#push to stack source as source
	sw $s3, 12($sp)#push to stack destination as auxiliar
	sw $s2, 16($sp)#push to stack auxiliar as destination
	
	jal hanoi	
	
	addi $sp, $sp, 20#pop stack
	
	jal movedisk	
	
	lw $t0, 4($sp)#obtain size
	lw $s1, 8($sp)#obtain source tower
	lw $s2, 12($sp)#obtain auxiliar tower
	lw $s3, 16($sp)#obtain destination tower
	
	addi $t0, $t0, -1#change size
	
	addi $sp, $sp, -20#push stack
	sw $t0, 4($sp)#push to stack new size
	sw $s2, 8($sp)#push to stack auxiliary as source
	sw $s1, 12($sp)#push to stack source as auxiliar
	sw $s3, 16($sp)#push to stack destination as destination
    	
	jal hanoi
		
	
	addi $sp, $sp, 20#pop stack
	
	lw $t5, 0($sp)	#obtain return address
	jr $t5
	
movedisk:
	lw $t1, 8($sp)#obtain pointer position for source tower
	lw $t3, 0($t1)#obtain source tower position
	lw $t2, 16($sp)#obtain pointer position for destination tower
	lw $t4, 0($t2)#obtain destination tower position
	
	addi $t3, $t3, -4 #change source tower position to match with the position of the last disk
	lw $t5, 0($t3)#obtain the value of the disk
	
	sw $zero, 0($t3)#erase the disk from the tower
	sw $t5, 0($t4)#put the disk in the new tower
	
	
	addi $t4, $t4, 4#change destination tower position to match with the position of the last disk
	
	sw $t3, 0($t1)#update the source tower pointer
	sw $t4, 0($t2)#update the destination tower pointer
	
	jr $ra		
	
return:
	jal movedisk
	lw $t5, 0($sp)#obtain return address
	jr $t5
	
end:
	