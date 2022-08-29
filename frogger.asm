#####################################################################
#
# By Benjamin Lee
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 512
# - Base Address for Display: 0x10008000 ($gp)
# 1. Added a third row of cars and logs
# 2. Display the number of lives remaining
# 3. Implemented a pause feature and showed a pause screen
# 4. Added a death scene
# 5. Have objects in different rows move at different speeds
# 6. Added a freeze time powerup and extra life powerup



.data
displayAddress: .word 0x10008000
water_row3:	.space 32
water_row2:	.space 32
water_row1:	.space 32
road_row3:	.space 32
road_row2:	.space 32
road_row1:	.space 32
time:		.space 30
frog_x:		.word 0x00000010 # Holds the value 16
frog_y:		.word 0x00000030 # Holds the value 48
lives:		.word 0x00000003 # Holds the value 3
wins:		.word 0x00000000 # Stores 0
powerup_life:	.word 0x00ffc0cb # Stores the colour pink
powerup_freeze:	.word 0x00add8e6 # Stores the colour light blue
.text

main:
li $t1, 0xff0000 # $t1 stores the red colour for cars
li $t2, 0x00ff00 # $t2 stores ligth green for the grass
li $t3, 0x0000ff # $t3 stores the blue colour for water
li $t4, 0x000000 # $t3 stores the black colour for the road
li $t5, 0x8B4513 # $t5 stores saddle brown for the logs

#Colour in water_row3
la $t6, water_row3
sw $t3, 0($t6)
addi $t6, $t6, 4
sw $t5, 0($t6)
addi $t6, $t6, 4
sw $t5, 0($t6)
addi $t6, $t6, 4
sw $t3, 0($t6)
addi $t6, $t6, 4
sw $t3, 0($t6)
addi $t6, $t6, 4
sw $t5, 0($t6)
addi $t6, $t6, 4
sw $t5, 0($t6)
addi $t6, $t6, 4
sw $t3, 0($t6)

#Colour in water_row2
la $t6, water_row2
sw $t3, 0($t6)
addi $t6, $t6, 4
sw $t3, 0($t6)
addi $t6, $t6, 4
sw $t5, 0($t6)
addi $t6, $t6, 4
sw $t5, 0($t6)
addi $t6, $t6, 4
sw $t3, 0($t6)
addi $t6, $t6, 4
sw $t3, 0($t6)
addi $t6, $t6, 4
sw $t5, 0($t6)
addi $t6, $t6, 4
sw $t5, 0($t6)

#Colour in water_row1
la $t6, water_row1
sw $t5, 0($t6)
addi $t6, $t6, 4
sw $t5, 0($t6)
addi $t6, $t6, 4
sw $t5, 0($t6)
addi $t6, $t6, 4
sw $t3, 0($t6)
addi $t6, $t6, 4
sw $t3, 0($t6)
addi $t6, $t6, 4
sw $t3, 0($t6)
addi $t6, $t6, 4
sw $t5, 0($t6)
addi $t6, $t6, 4
sw $t3, 0($t6)

#Colour in road_row3
la $t6, road_row3
sw $t1, 0($t6)
addi $t6, $t6, 4
sw $t1, 0($t6)
addi $t6, $t6, 4
sw $t4, 0($t6)
addi $t6, $t6, 4
sw $t4, 0($t6)
addi $t6, $t6, 4
sw $t1, 0($t6)
addi $t6, $t6, 4
sw $t1, 0($t6)
addi $t6, $t6, 4
sw $t4, 0($t6)
addi $t6, $t6, 4
sw $t4, 0($t6)

#Colour in road_row2
la $t6, road_row2
sw $t1, 0($t6)
addi $t6, $t6, 4
sw $t4, 0($t6)
addi $t6, $t6, 4
sw $t4, 0($t6)
addi $t6, $t6, 4
sw $t1, 0($t6)
addi $t6, $t6, 4
sw $t1, 0($t6)
addi $t6, $t6, 4
sw $t4, 0($t6)
addi $t6, $t6, 4
sw $t4, 0($t6)
addi $t6, $t6, 4
sw $t1, 0($t6)

#Colour in road_row1
la $t6, road_row1
sw $t4, 0($t6)
addi $t6, $t6, 4
sw $t4, 0($t6)
addi $t6, $t6, 4
sw $t4, 0($t6)
addi $t6, $t6, 4
sw $t1, 0($t6)
addi $t6, $t6, 4
sw $t4, 0($t6)
addi $t6, $t6, 4
sw $t4, 0($t6)
addi $t6, $t6, 4
sw $t4, 0($t6)
addi $t6, $t6, 4
sw $t1, 0($t6)
# Set the colours back
li $t1, 0xff0000 # $t1 stores the red colour for cars
li $t2, 0x00ff00 # $t2 stores ligth green for the grass
li $t3, 0x0000ff # $t3 stores the blue colour for water
li $t4, 0x000000 # $t3 stores the black colour for the road
li $t5, 0x8B4513 # $t5 stores saddle brown for the logs

#Create the end zone
# Assume that the height and width of the rectangle are in $a0 and $a1
# Colour is in $a2
addi $a0, $zero, 16	# set height = 16
addi $a1, $zero, 32	# set width = 32
add $a2, $zero, $t2	# set colour
lw $a3, displayAddress	# $a3 stores the base address for display

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal make_rectangle
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

# Fill in the end zone
addi $a0, $zero, 4	# set height = 4
addi $a1, $zero, 4	# set width = 32
add $a2, $zero, $t3	# set colour
lw $a3, displayAddress	# $a3 stores the base address for display
addi $a3, $a3, 1536
jal make_rectangle

lw $a3, displayAddress	# $a3 stores the base address for display
addi $a3, $a3, 1568
jal make_rectangle

lw $a3, displayAddress	# $a3 stores the base address for display
addi $a3, $a3, 1568
jal make_rectangle

lw $a3, displayAddress	# $a3 stores the base address for display
addi $a3, $a3, 1616
jal make_rectangle

jal draw_frog_lives
jal draw_everything

main_loop:
addi $t5, $zero, 360
add $t9, $zero, $zero
# Keep refreshing to see if there is input
input_loop:
beq $t9, $t5, end_input_loop # If $t9 == 360 end
lw $t8, 0xffff0000


bne $t8, 1, skip_keyboard_input		# If the user pressed something go to keyboard_input
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal keyboard_input
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_keyboard_input:

# Make different speeds so check if the index is at a specific value and do shifts
addi $t4, $zero, 30
bne $t4, $t9, skip_five
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_three
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_five:

addi $t4, $zero, 45
bne $t4, $t9, skip_one
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_two			# Shift water_row1 right
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_one:

addi $t4, $zero, 60
bne $t4, $t9, skip_seven
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_three
jal shift_water_row_one
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_seven:

addi $t4, $zero, 90
bne $t4, $t9, skip_two
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_three 		# Shift water_row1 right
jal shift_water_row_two			#Shift water_row2 left
jal shift_road_row_three
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_two:

addi $t4, $zero, 120
bne $t4, $t9, skip_eight
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_three
jal shift_water_row_one
jal shift_road_row_two
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_eight:

addi $t4, $zero, 135
bne $t4, $t9, skip_three
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_two			# Shift water_row1 right
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_three:

addi $t4, $zero, 150
bne $t4, $t9, skip_nine
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_three
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_nine:

addi $t4, $zero, 180
bne $t4, $t9, skip_four
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_three
jal shift_water_row_one 		# Shift water_row1 right
jal shift_road_row_three			#Shift road_row1 right
jal shift_water_row_two			#Shift water_row2 left
jal shift_road_row_one
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_four:

addi $t4, $zero, 210
bne $t4, $t9, skip_ten
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_three
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_ten:

addi $t4, $zero, 225
bne $t4, $t9, skip_eleven
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_two
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_eleven:

addi $t4, $zero, 240
bne $t4, $t9, skip_twelve
li $t1, 0xff0000 # $t1 stores the red colour for cars
li $t2, 0x00ff00 # $t2 stores ligth green for the grass
la $t6, powerup_freeze
add $t7, $t1, $t2	# set colour
sw $t7 0($t6)
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_three
jal shift_water_row_one
jal shift_road_row_two
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_twelve:

addi $t4, $zero, 270
bne $t4, $t9, skip_six
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_three		# Shift water_row1 right
jal shift_water_row_two			#Shift water_row2 left
jal shift_road_row_three
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_six:

addi $t4, $zero, 300
bne $t4, $t9, skip_thirteen
li $t1, 0xff0000 # $t1 stores the red colour for cars
li $t2, 0x00ff00 # $t2 stores ligth green for the grass
la $t6, powerup_life
add $t7, $t1, $t2	# set colour
sw $t7 0($t6)
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_three		# Shift water_row1 right
jal shift_water_row_one
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_thirteen:

addi $t4, $zero, 315
bne $t4, $t9, skip_fourteen
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_two			# Shift water_row1 right
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_fourteen:

addi $t4, $zero, 330
bne $t4, $t9, skip_fifteen
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_three		# Shift water_row1 right
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_fifteen:

addi $t4, $zero, 359
bne $t4, $t9, skip_sixteen
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t5, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_water_row_two			# Shift water_row1 right
jal shift_water_row_one			# Shift water_row1 right
jal shift_water_row_one
jal shift_road_row_three
jal shift_road_row_two
jal shift_road_row_one
jal draw_everything
lw $t5, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_sixteen:

li $v0, 32		# Sleep
li $a0, 17		# Sleep for 60 times a second
syscall
addi $t9, $t9, 1
j input_loop
end_input_loop:

j main_loop
end_main:
j Exit

shift_water_row_three:
la $a1, water_row3			# $a1 points to water_row3
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_arr_right
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
# Check to see if the frog moves with a log
lw $t1, frog_y				# $t1 holds frog_y
addi $t2, $zero, 16
bne $t1, $t2, skip_move_frog_right1
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal move_frog_right
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_move_frog_right1:
jr $ra

shift_water_row_two:
la $a1, water_row2			# $a1 points to water_row2
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_arr_left
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
# Check to see if the frog moves with a log
lw $t1, frog_y				# $t1 holds frog_y
addi $t2, $zero, 20
bne $t1, $t2, skip_move_frog_left
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal move_frog_left
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_move_frog_left:
jr $ra

shift_water_row_one:
la $a1, water_row1			# $a1 points to water_row1
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_arr_right
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
# Check to see if the frog moves with a log
lw $t1, frog_y				# $t1 holds frog_y
addi $t2, $zero, 24
bne $t1, $t2, skip_move_frog_right2
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal move_frog_right
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_move_frog_right2:
jr $ra

shift_road_row_three:
la $a1, road_row3			# $a1 points to road_row3
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_arr_left
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
jr $ra

shift_road_row_two:
la $a1, road_row2			# $a1 points to road_row2
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_arr_right
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
jr $ra

shift_road_row_one:
la $a1, road_row1			# $a1 points to road_row1
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal shift_arr_left
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
jr $ra

draw_frog_lives:
addi $a0, $zero, 4	# set height = 16
addi $a1, $zero, 32	# set width = 32
li $a2, 0x00ff00	# Get the light green colour
lw $a3, displayAddress	# $a3 stores the base address for display

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal make_rectangle
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

add $t3, $zero, $zero
lw $t2, lives	# Get the number of lives
draw_life_loop:
beq $t3, $t2, end_draw_life_loop

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t3, 0($sp)				# Push $t3 onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t2, 0($sp)				# Push $t2 onto the stack, to keep it safe

addi $a0, $zero, 2	# set height = 2
addi $a1, $zero, 2	# set width = 2
li $a2, 0x006400	# Get the dark green value of the frog
lw $a3, displayAddress	# $a3 stores the base address for display
addi $a3, $a3, 64
add $t4, $zero, $zero
keep_adding:
beq $t4, $t3, end_keep_adding
addi $a3, $a3, 16
addi $t4, $t4, 1
j keep_adding
end_keep_adding:

jal make_rectangle

lw $t2, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t3, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

addi $t3, $t3, 1
j draw_life_loop
end_draw_life_loop:
jr $ra

frog_died:
# Draw the death animation
lw $t9, frog_x		# $t9 holds frog_x
lw $t1, frog_y		# $t1 holds frog_y
sll $t9, $t9, 2		# multiply it by 4
sll $t1, $t1, 7		# multiply it by 128
lw $a3, displayAddress # Get the display address of the frog
add $a3, $a3, $t9	# Make the location of the frog
add $a3, $a3, $t1
lw $t3, 0($a3)		# Get the colour of the spot of the frog
add $t2, $a3, $zero	# Save the initial position of the frog

addi $a0, $zero, 1	# set height = 1
addi $a1, $zero, 4	# set width = 4
li $a2, 0x000000	# Make the colour black
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t2, 0($sp)				# Push $t2 onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t3, 0($sp)				# Push $t2 onto the stack, to keep it safe
jal make_rectangle
lw $t3, 0($sp)				# Pop $t2 off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t2, 0($sp)				# Pop $t2 off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
li $v0, 32		# Sleep
li $a0, 500		# Sleep for half a second
syscall

lw $t9, frog_x		# $t9 holds frog_x
lw $t1, frog_y		# $t1 holds frog_y
sll $t9, $t9, 2		# multiply it by 4
sll $t1, $t1, 7		# multiply it by 128
lw $a3, displayAddress # Get the display address of the frog
add $a3, $a3, $t9	# Make the location of the frog
add $a3, $a3, $t1
addi $a3, $a3, 128
addi $a0, $zero, 1	# set height = 1
addi $a1, $zero, 4	# set width = 4
li $a2, 0x000000	# Make the colour black
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t2, 0($sp)				# Push $t2 onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t3, 0($sp)				# Push $t2 onto the stack, to keep it safe
jal make_rectangle
lw $t3, 0($sp)				# Pop $t2 off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t2, 0($sp)				# Pop $t2 off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
li $v0, 32		# Sleep
li $a0, 500		# Sleep for half a second
syscall

lw $t9, frog_x		# $t9 holds frog_x
lw $t1, frog_y		# $t1 holds frog_y
sll $t9, $t9, 2		# multiply it by 4
sll $t1, $t1, 7		# multiply it by 128
lw $a3, displayAddress # Get the display address of the frog
add $a3, $a3, $t9	# Make the location of the frog
add $a3, $a3, $t1
addi $a3, $a3, 256
addi $a0, $zero, 1	# set height = 1
addi $a1, $zero, 4	# set width = 4
li $a2, 0x000000	# Make the frog dark green

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t2, 0($sp)				# Push $t2 onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t3, 0($sp)				# Push $t2 onto the stack, to keep it safe
jal make_rectangle
lw $t3, 0($sp)				# Pop $t2 off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t2, 0($sp)				# Pop $t2 off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
li $v0, 32		# Sleep
li $a0, 500		# Sleep for half a second
syscall

lw $t9, frog_x		# $t9 holds frog_x
lw $t1, frog_y		# $t1 holds frog_y
sll $t9, $t9, 2		# multiply it by 4
sll $t1, $t1, 7		# multiply it by 128
lw $a3, displayAddress # Get the display address of the frog
add $a3, $a3, $t9	# Make the location of the frog
add $a3, $a3, $t1
addi $a3, $a3, 384
addi $a0, $zero, 1	# set height = 1
addi $a1, $zero, 4	# set width = 4
li $a2, 0x000000	# Make the colour black
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t2, 0($sp)				# Push $t2 onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t3, 0($sp)				# Push $t2 onto the stack, to keep it safe
jal make_rectangle
lw $t3, 0($sp)				# Pop $t2 off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t2, 0($sp)				# Pop $t2 off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
li $v0, 32		# Sleep
li $a0, 500		# Sleep for half a second
syscall

# Draw the frog back in case it reached the end
add $a3, $t2, $zero
addi $a0, $zero, 4	# set height = 4
addi $a1, $zero, 4	# set width = 4

add $a2, $t3, $zero	# Make the frog dark green
add $a3, $t2, $zero
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal make_rectangle
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

la $t1, lives	# Get the address of the lives
lw $t2, lives	# Get the number of lives
add $t3, $zero, $zero
addi $t2, $t2, -1 # Decrease the number of lives
sw $t2, 0($t1)

#Draw the frog lives
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal draw_frog_lives
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
# If there are no lives left stop
lw $t2, lives	# Get the number of lives
add $t3, $zero, $zero
beq $t2, $t3, Exit

#Otherwise
la $t1, frog_x		# Holds the address for frog_x
la $t2, frog_y		# $t9 holds frog_x
addi $t3, $zero, 16	# Change the value of frog_x to original
addi $t4, $zero, 48	# Change value of frog_y to original

sw $t3, 0($t1)		# frog_x = 16
sw $t4, 0($t2)		# frog_y = 48
jr $ra

move_frog_right:	
la $t1, frog_x		# Holds the address for frog_x
lw $t9, frog_x		# $t9 holds frog_x
addi $t3, $zero, 28
beq $t9, $t3, frog_edge_right
end_frog_edge_right:
addi $t9, $t9, 4
sw $t9, 0($t1)
jr $ra

frog_edge_right:
addi $t9, $zero, -4
j end_frog_edge_right

move_frog_left:	
la $t1, frog_x		# Holds the address for frog_x
lw $t9, frog_x		# $t9 holds frog_x
add $t3, $zero, $zero
beq $t9, $t3, frog_edge_left
end_frog_edge_left:
addi $t9, $t9, -4
sw $t9, 0($t1)
jr $ra

frog_edge_left:
addi $t9, $zero, 32
j end_frog_edge_left

reset_frog:
la $t3, wins		# Holds the address for frog_x
lw $t2, wins		# Get the number of lives
addi $t1, $zero, 5
addi $t2, $t2, 1
sw $t2, 0($t3)		# Increase the lives by 1
beq $t1, $t2, Exit

la $t1, frog_x		# Holds the address for frog_x
la $t2, frog_y		# $t9 holds frog_x
addi $t3, $zero, 16	# Change the value of frog_x to original
addi $t4, $zero, 48	# Change value of frog_y to original

sw $t3, 0($t1)		# frog_x = 16
sw $t4, 0($t2)		# frog_y = 48
jal draw_everything
j end_reset_frog

keyboard_input:
lw $t2, 0xffff0004
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
beq $t2, 0x61, respond_to_a
beq $t2, 0x77, respond_to_w
beq $t2, 0x73, respond_to_s
beq $t2, 0x64, respond_to_d
beq $t2, 0x70, respond_to_p
after_response:
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
jr $ra 

respond_to_p:
addi $a0, $zero, 8	# set height = 8
addi $a1, $zero, 8	# set width = 8
li $a2, 0x000000	# Get the black colour
lw $a3, displayAddress	# $a3 stores the base address for display
addi $a3, $a3, 3616
jal make_rectangle

addi $a0, $zero, 6	# set height = 16
addi $a1, $zero, 1	# set width = 32
li $a2, 0xffffff	# Get the white colour
lw $a3, displayAddress	# $a3 stores the base address for display
addi $a3, $a3, 3752
jal make_rectangle

addi $a0, $zero, 6	# set height = 16
addi $a1, $zero, 1	# set width = 32
li $a2, 0xffffff	# Get the white colour
lw $a3, displayAddress	# $a3 stores the base address for display
addi $a3, $a3, 3764
jal make_rectangle

wait_for_p:
li $v0, 32
li $a0, 1000
syscall
lw $t8, 0xffff0000
beq $t8, 1, p_check_input
j wait_for_p

#If the user pressed p again then go to p
p_check_input:
lw $t2, 0xffff0004
beq $t2, 0x70, fix_after_p
j wait_for_p

fix_after_p:
jal draw_everything
j after_response

respond_to_w:
la $t6, frog_y		# $t6 holds the address of frog_y
lw $t4, 0($t6)		# t4 holds the value of frog_y
add $t1, $zero, $zero	# Contains the highest value of the frog
beq $t1, $t4, after_response		# Check to see if the frog can go higher if it can't stop
addi $t7, $t4, -4	# Decrease the value of $t4 by 4 and store in $t7
sw $t7, 0($t6)		# frog_y = $t7 

lw $t9, frog_x		# $t9 holds frog_x
lw $t1, frog_y		# $t1 holds frog_y
sll $t9, $t9, 2		# multiply it by 4
sll $t1, $t1, 7		# multiply it by 128
lw $t2, displayAddress # Get the display address of the frog
add $t2, $t2, $t9	# Make the location of the frog
add $t2, $t2, $t1
li $t1, 0x006400	# Get the dark green value of the frog
lw $t3, 0($t2)		# Get the colour of the spot of the frog
bne $t1, $t3, skip_frog_died_w
jal frog_died
skip_frog_died_w:
jal draw_everything


addi $t5, $zero, 12
la $t6, frog_y		# $t6 holds the address of frog_y
lw $t4, 0($t6)		# t4 holds the value of frog_y
beq $t5, $t4, reset_frog	# If frog reached end reset
end_reset_frog:		# Give spot to jump back to

j after_response

respond_to_a:
la $t6, frog_x		# $t6 holds the address of frog_x
lw $t4, 0($t6)		# t4 holds the value of frog_x
add $t1, $zero, $zero	# Contains the highest vaaue of the frog
beq $t1, $t4, after_response		# Check to see if the frog go higher if it can't stop
addi $t7, $t4, -4	# Decrease the value of $t4 by 4 and store in $t7
sw $t7, 0($t6)		# frog_x = $t7 
jal draw_everything
j after_response

respond_to_s:
la $t6, frog_y	# $t6 holds the address of frog_y
lw $t4, 0($t6)	# t4 holds the value of frog_x
addi $t1, $zero, 60	# Contains the lowest vlaaue of the frog
beq $t1, $t4, after_response		# Check to see if the frog go higher if it can't stop
addi $t7, $t4, 4	# Increase the value of $t4 by 4 and store in $t7
sw $t7, 0($t6)	# frog_x = $t7 
jal draw_everything
j after_response

respond_to_d:
la $t6, frog_x	# $t6 holds the address of frog_x
lw $t4, 0($t6)	# t4 holds the value of frog_x
addi $t1, $zero, 28	# Contains the lowest vlaaue of the frog
beq $t1, $t4, after_response		# Check to see if the frog go higher if it can't stop
addi $t7, $t4, 4	# Decrease the value of $t4 by 4 and store in $t7
sw $t7, 0($t6)	# frog_x = $t7 
jal draw_everything
j after_response

draw_everything:
#Create the moving row for water_row3
la $t4, water_row3	# $t4 points to the address of the list of colours
lw $a2, 0($t4)		# set colour based on row loop
lw $a3, displayAddress #reset a3
addi $a3, $a3, 2048

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal draw_moving_row
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
#Create the moving row for water_row2
la $t4, water_row2	# $t4 points to the address of the list of colours
lw $a2, 0($t4)		# set colour based on row loop
lw $a3, displayAddress #reset a3
addi $a3, $a3, 2560

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal draw_moving_row
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

#Create the moving row for water_row1
la $t4, water_row1	# $t4 points to the address of the list of colours
lw $a2, 0($t4)		# set colour based on row loop
lw $a3, displayAddress #reset a3
addi $a3, $a3, 3072

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal draw_moving_row
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

#Create the moving row for road_row3
la $t4, road_row3	# $t4 points to the address of the list of colours
lw $a2, 0($t4)		# set colour based on row loop
lw $a3, displayAddress #reset a3
addi $a3, $a3, 4608

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal draw_moving_row
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

#Create the moving row for road_row2
la $t4, road_row2	# $t4 points to the address of the list of colours
lw $a2, 0($t4)		# set colour based on row loop
lw $a3, displayAddress #reset a3
addi $a3, $a3, 5120

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal draw_moving_row
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

#Create the moving row for road_row1
la $t4, road_row1	# $t4 points to the address of the list of colours
lw $a2, 0($t4)		# set colour based on row loop
lw $a3, displayAddress #reset a3
addi $a3, $a3, 5632

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal draw_moving_row
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

# Set the colours back
li $t1, 0xff0000 # $t1 stores the red colour for cars
li $t2, 0x00ff00 # $t2 stores ligth green for the grass
li $t3, 0x0000ff # $t3 stores the blue colour for water
li $t4, 0x000000 # $t3 stores the black colour for the road
li $t5, 0x8B4513 # $t5 stores saddle brown for the logs

#Draw the safe zone
addi $a0, $zero, 8	# set height = 4
addi $a1, $zero, 32	# set width = 32
add $a2, $t1, $t2	# set colour
lw $a3, displayAddress # reset a3
addi $a3, $a3, 3584

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal make_rectangle

# Draw the powerups
addi $a0, $zero, 4	# set height = 4
addi $a1, $zero, 4	# set width = 32
lw $a2, powerup_life	# set colour
lw $a3, displayAddress # reset a3
addi $a3, $a3, 3584
jal make_rectangle

addi $a0, $zero, 4	# set height = 4
addi $a1, $zero, 4	# set width = 32
lw $a2, powerup_freeze	# set colour
lw $a3, displayAddress # reset a3
addi $a3, $a3, 3696
jal make_rectangle

lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

#Draw the start
addi $a0, $zero, 16	# set height = 4
addi $a1, $zero, 32	# set width = 32
add $a2, $zero, $t2	# set colour
lw $a3, displayAddress # reset a3
addi $a3, $a3, 6144	# set location

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal make_rectangle
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

#Check to see if the frog will be hit by a car or go in water
lw $t9, frog_x		# $t9 holds frog_x
lw $t1, frog_y		# $t1 holds frog_y
sll $t9, $t9, 2		# multiply it by 4
sll $t1, $t1, 7		# multiply it by 128

lw $t2, displayAddress # Get the display address of the frog
add $t2, $t2, $t9	# Make the start location of the frog
add $t2, $t2, $t1

lw $t1, 0($t2)		# Get the colour of the spot of the frog
li $t9, 0xff0000 	# $t9 stores the red colour for cars
li $t3, 0x0000ff 	# $t3 stores the blue colour for water
li $t2, 0x00ffc0cb	# Stores the extra life thing

bne $t1, $t9, skip_frog_died_car
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t1, 0($sp)				# Push $t1 onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t3, 0($sp)				# Push $t3 onto the stack, to keep it safe
jal frog_died
lw $t3, 0($sp)				# Pop $t3 off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t1, 0($sp)				# Pop $t1 off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_frog_died_car:

bne $t3, $t1, skip_frog_died_water
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal frog_died
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_frog_died_water:

bne $t1, $t2, skip_frog_extra_life
li $t1, 0xff0000 # $t1 stores the red colour for cars
li $t2, 0x00ff00 # $t2 stores ligth green for the grass
la $t6, powerup_life
add $t7, $t1, $t2	# set colour
sw $t7 0($t6)

la $t6, lives
lw $t7, lives
addi $t7, $t7, 1
sw $t7 0($t6)
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal draw_frog_lives
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_frog_extra_life:

li $t9, 0x00add8e6  	
bne $t1, $t9, skip_freeze_powerup
#Draw the frog
la $t6, powerup_freeze
li $t1, 0xff0000 # $t1 stores the red colour for cars
li $t2, 0x00ff00 # $t2 stores ligth green for the grass
add $t7, $t1, $t2	# set colour
sw $t7 0($t6)

lw $t9, frog_x		# $t9 holds the address of frog_x
lw $t1, frog_y		# $t1 holds the address of frog_y
sll $t9, $t9, 2		# multiply it by 4
sll $t1, $t1, 7		# multiply it by 128
addi $a0, $zero, 4	# set height = 4
addi $a1, $zero, 4	# set width = 4 
li $a2, 0x006400	# Make the frog dark green
lw $a3, displayAddress # reset a3
add $a3, $a3, $t9	# Make the start location of the frog
add $a3, $a3, $t1

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal make_rectangle
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

add $t9, $zero, $zero
# Keep refreshing to see if there is input
freeze_input_loop:
addi $t5, $zero, 180
beq $t9, $t5, skip_freeze_powerup # If $t9 == 360 end
lw $t8, 0xffff0000


bne $t8, 1, skip_freeze_keyboard_input	# If the user pressed something go to keyboard_input
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $t9, 0($sp)				# Push $ra onto the stack, to keep it safe			# Push $ra onto the stack, to keep it safe
addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal keyboard_input
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
lw $t9, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack
skip_freeze_keyboard_input:
li $v0, 32		# Sleep
li $a0, 17		# Sleep for 60 times a second
syscall
addi $t9, $t9, 1
j freeze_input_loop
skip_freeze_powerup:
#Draw the frog
lw $t9, frog_x		# $t9 holds the address of frog_x
lw $t1, frog_y		# $t1 holds the address of frog_y
sll $t9, $t9, 2		# multiply it by 4
sll $t1, $t1, 7		# multiply it by 128
addi $a0, $zero, 4	# set height = 4
addi $a1, $zero, 4	# set width = 4 
li $a2, 0x006400	# Make the frog dark green
lw $a3, displayAddress # reset a3
add $a3, $a3, $t9	# Make the start location of the frog
add $a3, $a3, $t1

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal make_rectangle
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

end_draw_everything:
jr $ra



#Draw the moving row
draw_moving_row:
addi $a0, $zero, 4	# set height = 4
addi $a1, $zero, 4	# set width = 4
addi $t5, $zero, 8	# stop the loop at 8
add $t9, $zero, $zero	# initialize $t9 to 0

# Offset the location with index $t6
create_row_loop:
beq $t9, $t5, end_row_loop  # If $t9 == row length, jump to end
add $t6, $zero, $zero

addi $sp, $sp, -4			# Move stack pointer to empty location
sw $ra, 0($sp)				# Push $ra onto the stack, to keep it safe
jal make_rectangle
lw $ra, 0($sp)				# Pop $ra off the stack
addi $sp, $sp, 4			# Move stack pointer to top element on stack

addi $a3, $a3, -496
addi $t4, $t4, 4
lw $a2, 0($t4)		# set colour based on row loop
addi $t9, $t9, 1
j create_row_loop
end_row_loop:
jr $ra

# Draw a rectangle:
make_rectangle:
add $t6, $zero, $zero	# Set index value ($t6) to zero
draw_rect_loop:
beq $t6, $a0, end_rectangle  	# If $t6 == height ($a0), jump to end

# Draw a line:
add $t7, $zero, $zero	# Set index value ($t7) to zero
draw_line_loop:
beq $t7, $a1, end_draw_line  # If $t7 == width ($a1), jump to end
sw $a2, 0($a3)		#   - Draw a pixel at memory location $a3
addi $a3, $a3, 4	#   - Increment $a3 by 4
addi $t7, $t7, 1	#   - Increment $t7 by 1
j draw_line_loop	#   - Jump to start of line drawing loop
end_draw_line:

addi $t8, $zero, 128	# Find the value of the first pixel on the next line
sub $t8, $t8, $a1	# Subtract the width do it four timessince there is 128 per line
sub $t8, $t8, $a1
sub $t8, $t8, $a1
sub $t8, $t8, $a1

add $a3, $a3, $t8	# Set $t0 to the first pixel of the next line.
addi $t6, $t6, 1	#   - Increment $t6 by 1
j draw_rect_loop	#   - Jump to start of rectangle drawing loop
end_rectangle:
jr $ra

# Move an array with 8 elements right
shift_arr_right:
lw $t6, 0($a1)		# $t6 = a1[0]
addi $a1, $a1, 4
lw $t7, 0($a1)		# $t7 = a1[4]
sw $t6, 0($a1)		# a1[4] = a[0]
addi $a1, $a1, 4
lw $t6, 0($a1)		# $t6 = a1[8]
sw $t7, 0($a1)		# a1[8] = $a[4]
addi $a1, $a1, 4
lw $t7, 0($a1)		# $t7 = a1[12]
sw $t6, 0($a1)		# a1[12] = a[8]
addi $a1, $a1, 4
lw $t6, 0($a1)		# $t6 = a1[16]
sw $t7, 0($a1)		# a1[16] = $a[12]
addi $a1, $a1, 4
lw $t7, 0($a1)		# $t7 = a1[20]
sw $t6, 0($a1)		# a1[20] = a[16]
addi $a1, $a1, 4
lw $t6, 0($a1)		# $t6 = a1[24]
sw $t7, 0($a1)		# a1[24] = $a[20]
addi $a1, $a1, 4
lw $t7, 0($a1)		# $t7 = a1[28]
sw $t6, 0($a1)		# a1[28] = a[24]
addi $a1, $a1, -28
sw $t7, 0($a1)		# a[0] = a[28]
end_shift_arr_right:
jr $ra

# Move an array with 8 elements left
shift_arr_left:
lw $t6, 0($a1)		# $t6 = a1[0]
addi $a1, $a1, 28
lw $t7, 0($a1)		# $t7 = a1[28]
sw $t6, 0($a1)		# a1[28] = a[0]
addi $a1, $a1, -4
lw $t6, 0($a1)		# $t6 = a1[24]
sw $t7, 0($a1)		# a1[24] = $a[28]
addi $a1, $a1, -4
lw $t7, 0($a1)		# $t7 = a1[20]
sw $t6, 0($a1)		# a1[20] = a[24]
addi $a1, $a1, -4
lw $t6, 0($a1)		# $t6 = a1[16]
sw $t7, 0($a1)		# a1[16] = $a[20]
addi $a1, $a1, -4
lw $t7, 0($a1)		# $t7 = a1[12]
sw $t6, 0($a1)		# a1[12] = a[16]
addi $a1, $a1, -4
lw $t6, 0($a1)		# $t6 = a1[8]
sw $t7, 0($a1)		# a1[8] = $a[12]
addi $a1, $a1, -4
lw $t7, 0($a1)		# $t7 = a1[4]
sw $t6, 0($a1)		# a1[4] = a[8]
addi $a1, $a1, -4
sw $t7, 0($a1)		# a[0] = a[4]
end_shift_arr_left:
jr $ra

Exit:
li $v0, 10 # terminate the program gracefully
syscall
