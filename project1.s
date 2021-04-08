#Daniel Rea
#Project 1
#CSC35 - 01
#December 11, 2018



.data


Title:
	.ascii "Welcome to Dragon Ball Z Battle Royale! \n"
	.ascii "\nBy Daniel Rea of CSC35 - 01.\n\0"

Art:
	.ascii "				DRAGON BALL				\n"
	.ascii "			-----------------------------			\n"
	.ascii "                           _______________________			\n"
	.ascii "                          /                      ,'			\n"
	.ascii "                         /      ___            ,'			\n"
	.ascii "                        /   _.-'  ,'        ,-'   			\n"
	.ascii "                       / ,-' ,--.'        ,'    /			\n"
	.ascii "                      /.'     `.         '.    / 			\n"
	.ascii "                     /'     ,'        ,'  ,'  /				\n"
	.ascii "                    /'     ,-'      ,' .-'   /				\n"
	.ascii "                    ________________________/				\n\0"

	
FighterPrompt:
	
	.ascii "\nHow many fighters will be participating? (Enter at least 2)\n\0" # Prompts the player for at least 2 players

CurrentPlayer:
	
	.quad 0 						#Storage that tracks the current player

CurrentPlayerPrompt:

	.ascii "\n\nPLAYER \0"

PlayerName0:

	.ascii ": Goku\n\0"

PlayerName1:

	.ascii ": Vegeta\n\0"

PlayerName2:

	.ascii ": Hit\n\0"

PlayerName3:

	.ascii ": Majin Buu\n\0"

TargetPrompt:

	.ascii "Target Selection: \0"

#-------------------------------------

Player0:

	.quad 100#

Player1:

	.quad 100#

Player2:
		 # Player health starts at 100
	.quad 100#

Player3:

	.quad 100#

#-------------------------------------

AttackSelection:

	.ascii "\nPick an attack: \0"

PlayerHealth:

	.ascii "\nHealth: \0"
	
TargetSelection:

	.ascii "\nYour target: \0"

EnteredPlayers:

	.quad 0 #The amount of players entered by the user

TotalPlayers:

	.quad 0 						#Total players in the game. Decreases by one each time a player is eliminated

AttackChoice:

	.ascii "Choose attack:\n\0"

AttackPlayer0Prompt:

	.ascii " points of damage done to Goku\n\0"
	
AttackPlayer1Prompt:

	.ascii " points of damage done to Vegeta\n\0"

AttackPlayer2Prompt:

	.ascii " points of damage done to Hit\n\0"

AttackPlayer3Prompt:

	.ascii " points of damage done to Buu\n\0"

GokuAttack1Prompt:

	.ascii "\n1. Kamehameha\n\0"

GokuAttack2Prompt:

	.ascii "2. Dragon Fist\n\0"

GokuAttack3Prompt:

	.ascii "3. Spirit Bomb\n\0"

VegetaAttack1Prompt:

	.ascii "\n1. Galick Gun\n\0"

VegetaAttack2Prompt:
 
	.ascii "2. Big Bang Attack\n\0"

VegetaAttack3Prompt:

	.ascii "3. Final Flash\n\0"

HitAttack1Prompt:

	.ascii "\n1. Vital Point Attack\n\0"

HitAttack2Prompt:
 
	.ascii "2. Time-Skip/Molotov\n\0"

HitAttack3Prompt:

	.ascii "3. Flat Fist Crush\n\0"

BuuAttack1Prompt:

	.ascii "\n1. Double Blast\n\0"

BuuAttack2Prompt:

	.ascii "2. Mystic Ball Attack\n\0"

BuuAttack3Prompt:

	.ascii "3. Planet Buster\n\0"

SelectionPrompt:

	.ascii "Your selection: \0"

EliminationPrompt:

	.ascii "\nFighter has been eliminated!\n\0"

MissAttack:

	.ascii "\nAttack missed!\n\0"

GameOver:

	.ascii "\nMatch over!\n\0" 

.text

.global _start

_start:

#------------------------ Displays title and art, prompts the user for the player amount, adds that number to TotalPlayers and moves to EnteredPlayers
mov $Title, %rcx
call PrintCString
mov $Art, %rcx
call PrintCString
mov $FighterPrompt, %rcx
call PrintCString
call ScanInt
add %rcx, TotalPlayers
mov %rcx, EnteredPlayers
#------------------------

#-------------------------------- Checks to see if more than 2 players left in the game. Jumps to 'End" if less than 2 is left or entered initially
While:
	cmp $2, TotalPlayers
	jl End
	jmp Do
#-------------------------------

#------------------------------ Loop checks for at least two players. If only 2 players are entered, cycles through Player0Turn and Player1Turn ONLY
Do:
	cmp $2, EnteredPlayers
	jl End
	Player0Turn:
	cmp $0, Player0	# Checks to see if health is more than 0. Skips the player of not.	
	jg Turn0
	jmp Next
	Turn0:

		mov $CurrentPlayerPrompt, %rcx # Turn0, Turn1, Turn2, and Turn3 all do the same thing: Prints the player name, health status, and prompts the player for target and attack choice.
		call PrintCString	       # If each players health reaches 0, that respective player is skipped in the loop, eliminating them from the game
		movb $0, CurrentPlayer
		mov CurrentPlayer, %rcx
		call PrintInt
		mov $PlayerName0, %rcx
		call PrintCString
		mov $PlayerHealth, %rcx
		call PrintCString
		mov Player0, %rcx
		call PrintInt
		mov %rcx, Player0
		mov $TargetSelection, %rcx
		call PrintCString
		mov $6, %rcx
		call SetForeColor
		call ScanInt
		mov %rcx, %rax
		mov $AttackSelection, %rcx
		call PrintCString
		mov $GokuAttack1Prompt, %rcx
		call PrintCString
		mov $GokuAttack2Prompt, %rcx
		call PrintCString
		mov $GokuAttack3Prompt, %rcx
		call PrintCString
		mov $SelectionPrompt, %rcx
		call PrintCString
		call ScanInt
		call GokuAttackCases
		mov $7, %rcx
		call SetForeColor	
		jmp Player1Turn

	Next:
	Player1Turn:
	cmp $0, Player1 # Checks health
	jg Turn1
	jmp Next2
	Turn1:

		mov $CurrentPlayerPrompt, %rcx
		call PrintCString
		movb $1, CurrentPlayer
		mov CurrentPlayer, %rcx
		call PrintInt
		mov $PlayerName1, %rcx
		call PrintCString
		mov $PlayerHealth, %rcx
		call PrintCString
		mov Player1, %rcx
		call PrintInt
		mov %rcx, Player1
		mov $TargetSelection, %rcx
		call PrintCString
		mov $6, %rcx
		call SetForeColor
		call ScanInt
		mov %rcx, %rax
		mov $AttackSelection, %rcx
		call PrintCString
		mov $VegetaAttack1Prompt, %rcx
		call PrintCString
		mov $VegetaAttack2Prompt, %rcx
		call PrintCString
		mov $VegetaAttack3Prompt, %rcx
		call PrintCString
		mov $SelectionPrompt, %rcx
		call PrintCString
		call ScanInt
		call VegetaAttackCases
		mov $7, %rcx
		call SetForeColor
		jmp Next2
		
	

	Next2:
	cmp $3, EnteredPlayers # Checks to see if 3 players are selected. If so, then Turn2 is executed. If not, then loops back to the "While" label
	jl While
	Player2Turn:
	cmp $0, Player2 # Checks health
	jg Turn2
	jmp Next3
	Turn2:
	

		mov $CurrentPlayerPrompt, %rcx
		call PrintCString
		movb $2, CurrentPlayer
		mov CurrentPlayer, %rcx
		call PrintInt
		mov $PlayerName2, %rcx
		call PrintCString
		mov $PlayerHealth, %rcx
		call PrintCString
		mov Player2, %rcx
		call PrintInt
		mov %rcx, Player2
		mov $TargetSelection, %rcx
		call PrintCString
		mov $6, %rcx
		call SetForeColor
		call ScanInt
		mov %rcx, %rax
		mov $AttackSelection, %rcx
		call PrintCString
		mov $HitAttack1Prompt, %rcx
		call PrintCString
		mov $HitAttack2Prompt, %rcx
		call PrintCString
		mov $HitAttack3Prompt, %rcx
		call PrintCString
		mov  $SelectionPrompt, %rcx
		call PrintCString
		call ScanInt
		call HitAttackCases
		mov $7, %rcx
		call SetForeColor
		jmp Next3
		
	Next3:	
	cmp $4, EnteredPlayers # Like above, checks to see if 4 players are entered. Loop is included if so, skipped if not.
	jl While
	Player3Turn:
	cmp $0, Player3 # Checks health
	jg Turn3
	jmp Return
	Turn3:
		mov $CurrentPlayerPrompt, %rcx
		call PrintCString
		movb $3, CurrentPlayer
		mov CurrentPlayer, %rcx
		call PrintInt
		mov $PlayerName3, %rcx
		call PrintCString
		mov $PlayerHealth, %rcx
		call PrintCString
		mov Player3, %rcx
		call PrintInt
		mov %rcx, Player3
		mov $TargetSelection, %rcx
		call PrintCString
		mov $6, %rcx
		call SetForeColor
		call ScanInt
		mov %rcx, %rax
		mov $AttackSelection, %rcx
		call PrintCString
		mov $BuuAttack1Prompt, %rcx
		call PrintCString
		mov $BuuAttack2Prompt, %rcx
		call PrintCString
		mov $BuuAttack3Prompt, %rcx
		call PrintCString
		mov $SelectionPrompt, %rcx
		call PrintCString
		call ScanInt
		call BuuAttackCases
		mov $7, %rcx
		call SetForeColor
		jmp Return
	
	jmp Return

Return:

	jmp While # Loops back around to the beginning
	

GokuAttackCases: # Checks what the user entered for player 0, jumps to the respective case statements. Returns to players respective turn 
	
	cmp $1, %rcx
	je GokuAttack
	cmp $2, %rcx
	je GokuAttack2
	cmp $3, %rcx
	je GokuAttack3
	ret

GokuAttack: # Light attack: If random number is between 5 and 25, do that amount in damage and jump to player selections. Otherwise, jump to "Miss"
	
	mov $25, %rcx
	sub $1, %rcx
	call Random
	cmp $5, %rcx
	jge Cases
	jmp Miss
	ret


GokuAttack2: # Heavy attack: Smaller chance to hit but greater range of damage. Jump to player selection if hit. Skip if miss
	
	mov $60, %rcx
	sub $1, %rcx
	call Random
	cmp $30, %rcx
	jge Cases
	jmp Miss
	ret

GokuAttack3: # Power attack: very low chance to hit, but massive damage. Jump to player selection if hit. Skip if miss
	mov $100, %rcx
	sub $1, %rcx
	call Random
	cmp $85, %rcx
	jge Cases
	jmp Miss
	ret

#------------------------------------------------------------------------------------

VegetaAttackCases: # Same as above, but with player 1 
	
	cmp $1, %rcx
	je VegetaAttack
	cmp $2, %rcx
	je VegetaAttack2
	cmp $3, %rcx
	je VegetaAttack3
	ret

VegetaAttack:

	mov $25, %rcx
	sub $1, %rcx
	call Random
	cmp $5, %rcx
	jge Cases
	jmp Miss
	ret

VegetaAttack2:
	
	mov $60, %rcx
	sub $1, %rcx
	call Random
	cmp $30, %rcx
	jge Cases
	jmp Miss
	ret

VegetaAttack3:
	
	mov $100, %rcx
	sub $1, %rcx
	call Random
	cmp $85, %rcx
	jge Cases
	jmp Miss
	ret

#-----------------------------------------------------------------

HitAttackCases: # Same as above, but with player 2
	
	cmp $1, %rcx
	je HitAttack
	cmp $2, %rcx
	je HitAttack2
	cmp $3, %rcx
	je HitAttack3
	ret

HitAttack:
	
	mov $25, %rcx
	sub $1, %rcx
	call Random
	cmp $5, %rcx
	jge Cases
	jmp Miss
	ret

HitAttack2:
	
	mov $60, %rcx
	sub $1, %rcx
	call Random
	cmp $30, %rcx
	jge Cases
	jmp Miss
	ret

HitAttack3:
        
	mov $100, %rcx
        sub $1, %rcx
        call Random
        cmp $85, %rcx
        jge Cases
        jmp Miss
        ret

#-----------------------------------------------------------------

BuuAttackCases: # Same as above, but with player 3
	
	cmp $1, %rcx
	je BuuAttack
	cmp $2, %rcx
	je BuuAttack2
	cmp $3, %rcx
	je BuuAttack3
	ret

BuuAttack:
	
	mov $25, %rcx
	sub $1, %rcx
	call Random
	cmp $5, %rcx
	jge Cases
	jmp Miss
	ret

BuuAttack2:
	
	mov $60, %rcx
	sub $1, %rcx
	call Random
	cmp $30, %rcx
	jge Cases
	jmp Miss
	ret

BuuAttack3:
	
	mov $100, %rcx
	sub $1, %rcx
	call Random
	cmp $85, %rcx
	jge Cases
	jmp Miss
	ret

#------------------------------------------------------------------------

Miss: # If players miss, jumps here and notifies the player attack missed. No damage done. Goes to next player
	
	mov $MissAttack, %rcx 
	call PrintCString
	ret

Cases: # The seperate selections to decide which player the current player wants to attack. Jumps to that specific subroutine

	cmp $0, %rax
	je AttackPlayer0
	cmp $1, %rax
	je AttackPlayer1
	cmp $2, %rax
	je AttackPlayer2
	cmp $3, %rax
	je AttackPlayer3
	ret

#-----------------------------------------------------------------------------
		
AttackPlayer0: # If player 0 is selected when prompted, program jumps here and subtracts the amount randomly generated previously from the selected players health. Notifies how much damage was done to that player. 
	       # If eliminated, jumps to "Elimination". Exact same way for AttackPlayer1, AttackPlayer2, and AttackPlayer3	

	
	mov %rcx, %rax
	mov $1, %rcx
	call SetForeColor
	mov %rax, %rcx
	call PrintInt
	sub %rcx, Player0
	mov Player0, %rbx
	mov $7, %rcx
	call SetForeColor
	mov $AttackPlayer0Prompt, %rcx
	call PrintCString
	mov %rbx, %rcx
	mov %rcx, Player0
	cmp $0, Player0
	jle Elimination
	ret

AttackPlayer1:

	mov %rcx, %rax
	mov $1, %rcx
	call SetForeColor
	mov %rax, %rcx
	call PrintInt
	sub %rcx, Player1
	mov Player1, %rbx
	mov $7, %rcx
	call SetForeColor
	mov $AttackPlayer1Prompt, %rcx
	call PrintCString
	mov %rbx, %rcx
	mov %rcx, Player1
	cmp $0, Player1
	jle Elimination
	ret

AttackPlayer2:
	
	mov %rcx, %rax
	mov $1, %rcx
	call SetForeColor
	mov %rax, %rcx
	call PrintInt
	sub %rcx, Player2
	mov Player2, %rbx
	mov $7, %rcx
	call SetForeColor
	mov $AttackPlayer2Prompt, %rcx
	call PrintCString
	mov %rbx, %rcx
	mov %rcx, Player2
	cmp $0, Player2
	jle Elimination
	ret

AttackPlayer3:
		
	mov %rcx, %rax
	mov $1, %rcx
	call SetForeColor
	mov %rax, %rcx
	call PrintInt
	sub %rcx, Player3
	mov Player3, %rbx
	mov $7, %rcx
	call SetForeColor
	mov $AttackPlayer3Prompt, %rcx
	call PrintCString
	mov %rbx, %rcx
	mov %rcx, Player3
	cmp $0, Player3
	jle Elimination
	ret

#------------------------------------------------


Elimination: # If a players health reaches 0 after an attack, subtracts 1 from TotalPlayers and notifies the players. Jumps to "End" when only one player remains

	sub $1, TotalPlayers
	mov $EliminationPrompt, %rcx
	call PrintCString
	cmp $1, TotalPlayers
	je End
	ret

End: # Notifies all players that only one player remains. Game ends.
	
	mov $GameOver, %rcx
	call PrintCString
	call EndProgram
