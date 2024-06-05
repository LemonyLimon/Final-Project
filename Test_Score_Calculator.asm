;CIS-11 Final Project: Test Score Calculator

;Team - Coding Crusaders:
;Celeste Hernandez
;Melanie Caines 
;Talia Craft
;;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;;;


.ORIG x3000

LEA	 R0, WEL
PUTS 
WEL	.STRINGZ "Welcome! Please enter 5 scores: (0 - 99)"

LD R0, NEWLINE
OUT			

;Calls jumps to get_grade function to get the numeric grade, then stores grade
;into grades array. We then jump to get the get letter function. After we jump to the pop function.

JSR GET_GRADE
LEA R6, GRADES
STR R3, R6, #0
JSR GET_LETTER
JSR POP


LD R0, NEWLINE
OUT

;It does the same as the top function, except this time it uses G2 instead of G1. 
;The grade into the grades array.

JSR GET_GRADE
LEA R6, GRADES
STR R3, R6, #1
JSR GET_LETTER
JSR POP


LD R0, NEWLINE
OUT

;NOW USING G3

JSR GET_GRADE
LEA R6, GRADES
STR R3, R6, #2
JSR GET_LETTER
JSR POP

LD R0, NEWLINE
OUT

;NOW USING G4 

JSR GET_GRADE
LEA R6, GRADES
STR R3, R6, #3
JSR GET_LETTER
JSR POP


LD R0, NEWLINE
OUT

;NOW USING G5

JSR GET_GRADE
LEA R6, GRADES
STR R3, R6, #4
JSR GET_LETTER
JSR POP


LD R0, NEWLINE
OUT

; FALL THRU FUNCTION IN MAIN
; R1 = NUM_TESTS (5)
; R2 = GRADES ARRAY
; R3 = MIN_GRADE
; R4 = GRADES(x)
; R5 = -G(x) / PLATFORM FOR COMPARISON 



CALCULATE_MAX
	LD R1, NUM_TESTS 	;R1 holds the total number of test 
 	LEA R2, GRADES 		;R2 holds the starting address of grades 
	LD R4, GRADES		; G(0)
	ST R4, MAX_GRADE
	ADD R2, R2, #1

LOOP1 	LDR R5, R2, #0		;Access pointer value in grades
	NOT R4, R4
	ADD R4, R4, #1
	ADD R5, R5, R4
	BRp NEXT1
	LEA R0, MAX
	PUTS
	LD R3, MAX_GRADE
	AND R1, R1, #0
	JSR BREAK_INT
	LD R0, SPACE
	OUT

LD R0, NEWLINE
OUT	
JSR CLEAR_REG




; CALCULATE MIN
; R1 = NUM_TESTS (5)
; R2 = GRADES ARRAY
; R3 = MIN_GRADE
; R4 = GRADES(x)
; R5 = -G(x) / PLATFORM FOR COMPARISON 

CALCULATE_MIN
	LD R1, NUM_TESTS 	;R1 holds the total number of test 
 	LEA R2, GRADES 		;R2 holds the starting address of grades 
	LD R4, GRADES		; G(0)
	ST R4, MIN_GRADE
	ADD R2, R2, #1
	ADD R1, R1, #-1

LOOP2 	LDR R5, R2, #0		;Access pointer value in grades
	
	NOT R4, R4
	ADD R4, R4, #1		
	ADD R5, R5, R4
	BRn NEXT2

	
	ADD R2, R2, #1
	LD R4, GRADES
	AND R5, R5,#0
	ADD R1,R1,#-1
	BRp LOOP2

	LEA R0, MIN
	PUTS
	LD R3, MIN_GRADE
	AND R1, R1, #0
	JSR BREAK_INT
	LD R0, SPACE
	OUT
	
JSR CLEAR_REG
LD R0, NEWLINE
OUT


; CALCULATE AVG
; R1 = NUM_TESTS (5) 
; R2 = GRADES ARRAY
; R3 = SUM
; R4 - GRADES[i] / SUM / PLATFORM FOR SUBTRACTION
; R5 = DEC -> 
; R6 = COUNTER / DIV (QUOTIENT)


CALC_AVG
	LD R1, NUM_TESTS 	;R1 holds the total number of test 
 	LEA R2, GRADES 		;R2 holds the starting address of grades 

GEN_SUM LDR R4, R2, #0
	ADD R3, R3, R4		;Sum will be stored in R3
	ADD R2, R2, #1
	ADD R1, R1, #-1
	BRp GEN_SUM

	LD R1, NUM_TESTS
 	NOT R1, R1
	ADD R1, R1, #1 		;R1 has value of -5
 	ADD R4, R3, #0

LOOP3 	ADD R4, R4, #0
	BRnz DONE_AVG
 	ADD R6, R6, #1		;Increment every time
	ADD R4, R4, R1		;Subtract 5 from total
 	BRp LOOP3

DONE_AVE 
	ST R6, AVERAGE_SCORE
	LEA R0, AVG
	PUTS
	AND R3, R3, #0
	AND R1, R1, #0
	AND R4, R4, #0
	ADD R3, R3, R6
	JSR BREAK_INT

		
JSR RESTART_PROG

HALT


NEWLINE			.FILL xA
SPACE			.FILL X20
DECODE_DEC 		.FILL #-48
DECODE_SYM		.FILL #48
DECODE_THIRTY		.FILL #-30
NUM_TESTS		.FILL 5
RESTART2		.FILL x3000

MAX_GRADE		.BLKW 1
MIN_GRADE		.BLKW 1
DONE_AVG		.BLKW 1
AVERAGE_SCORE		.BLKW 1




; BRANCHES AND VARIABLES
; FOR CALCULATE MIN AND MAX


NEXT2 
	LDR R4, R2, #0
	ST R4, MIN_GRADE
	ADD R2, R2, #1		;Grades array move up
	ADD R1, R1, #-1		;Counter move down
	BRnzp LOOP2

NEXT1 
	LDR R4, R2, #0
	ST R4, MAX_GRADE
	ADD R2, R2, #1		;Grades array move up
	ADD R1, R1, #-1		;Counter move down
	BRp LOOP1


GRADES 	.BLKW 5

MIN	.STRINGZ "MIN "
MAX	.STRINGZ "MAX "
AVG	.STRINGZ "AVG "



; SUBROUTINE
; RESTART_PROG
; RESTARTS THE PROGRAM ON 'y'
; R7 = JSR LOCATION
; R0 = INPUT/ OUTPUT
; R1 = VALUE OF LOWERCASE Y(- 121)
; R2 = ORIGIN x3000
; R3 = VALUE OF UPPERCASE Y (-89)


RESTART_PROG
	ST R7, SAVELOC1			;Save jsr location
	LD R1, LOWER_Y			;Load neg value of y
	LD R3, UPPER_Y
	LD R2, ORIGIN			;Load origin (x3000)
	
	LD R0, NEWLINE
	OUT
	LEA R0 RESTARTPROG_STR		;Restart prompt string
	PUTS
	LD R0, NEWLINE
	OUT

	GETC	
	ADD R1, R1, R0			;Compare user input with -y
	BRz RESTART_TRUE 		;If true branch to restart
	ADD R3, R3, R0			;Compare user input with -y
	BRz RESTART_TRUE 		;If true branch to restart

HALT					;Else halt program

;Branches or restart_prog

RESTART_TRUE	
	JMP R2



;Variables for restart_prog

RESTARTPROG_STR 	.STRINGZ "Program Completed. Would you like to run this program again? Y/N "
LOWER_Y			.FILL xFF87	; -121
UPPER_Y			.FILL xFFA7	; -89
ORIGIN			.FILL x3000

SAVELOC1 .FILL X0
SAVELOC2 .FILL X0
SAVELOC3 .FILL X0
SAVELOC4 .FILL X0
SAVELOC5 .FILL X0


; Subroutine
; Get_Grade read in two numbers and put
; Together as one double digit by multiplying first number by 
; 10 then adding to second.
; R1 = input from r0
; R2 = counter for mult10
; R3 = platform for mult10 / answer
; R4 = ascii -> decimal translation



;Get_Grade function this function I used to store jsr location
;It also uses a jsr to clear the register it also 
;Uses another function to decode the grade into decimal.

GET_GRADE	ST R7, SAVELOC1		;Store jsr location
		JSR CLEAR_REG		;Clear registers
		LD R4, DECODE_DEC	;Load translation

		GETC			;Get first char
		JSR VALIDA
		OUT			;Echo input
	
		ADD R1, R0, #0		;Copy input to R1
		ADD R1, R1, R4		;Translate to decimal	
		ADD R2, R2, #10		;Clear R2


MULT10	ADD R3, R3, R1			;Add input to R3 (Mult Process)
		ADD R2, R2, #-1		;Decrement counter
		BRp MULT10		;Loop until counter is zero

		GETC			;Get second char
		JSR VALIDA
		OUT			;Echo input to screen
	
		ADD R0, R0, R4		;Translate second input to decimal
		ADD R3, R3, R0		;Add first input(x10) to second input
		

		LD R0, SPACE		;Add space
		OUT			;Print space

		LD R7, SAVELOC1		;Load jsr return location
RET					;Return



; SUBROUTINE
; Break_ Int 
; Breaks up a double digit into two separate digits for 
; Printing using the quotient and mod %10
; R1 = COUNTER FOR DIVIDE (QUOTIENT)
; R3 = Input
; R4 = Platform / Remainder
; R5 = Decimal to Symbol translation
; R6 = Check For 10


BREAK_INT 
	ST R7, SAVELOC1		; Store jsr return location
	LD R5, DECODE_SYM	; Convert decimal to symbol
	ADD R4, R3, #0		; Copy input to r4 (platform)

DIV1	ADD R1, R1, #1		; Counter for division (quotient)
	ADD R4, R4, #-10	; Subtract 10 from input
	BRp DIV1		; Subtract 10 till input is 0 or neg
	
	ADD R1, R1 #-1		; Remove extra 1
	ADD R4, R4, #10		; Add 10 to get remainder
	ADD R6, R4, #-10
	BRnp POS

NEG 	ADD R1, R1, #1
	ADD R4, R4, #-10


POS	ST R1, Q		; Store Quotient
	ST R4, R		; Store remainder (mod 10)
	
	LD R0, Q		; Load Quotient for printning
	ADD R0, R0, R5		; Translate decimal to symbol
	OUT			; Print Quotient
	LD R0, R		; Load remainder for print
	ADD R0, R0, R5		; Translate decimal to symbol
	OUT			; Print remainder (mod 10)
	
	LD R7, SAVELOC1		; Restore jsr return location
	RET

	

R .FILL X0
Q .FILL X0

; Subroutine
; Push
; Take in a Number in R0
; and Store It to a Stack
; R6 = Stack Pointer
; R0 = Pushed to Stack


PUSH	ST R7, SAVELOC2		; Store JSR Location
	JSR CLEAR_REG		; Clear Register
	LD R6, POINTER		; Initialize Pointer
	ADD R6, R6, #0
	BRnz STACK_ERROR

	ADD R6, R6, #-1		;Decrement Pointer
	STR R0, R6, #0		;Store Number in R0 to Stack
	ST R6, POINTER		;Save Pointer Location
	LD R7, SAVELOC2		;Restore Location

RET

POINTER	.FILL X4000		;Pointer start location



; Subroutine
; Pop
; Remove a Number From the Stack
; and Store in R0
; R6 = Stack Pointer
; R0 = Popped From Stack
; R1 = -4000

POP	LD R6, POINTER		;Load pointer location
	ST R1, SAVELOC5
	LD R1, BASELINE
	ADD R1, R1, R6
	BRzp STACK_ERROR
	LD R1, SAVELOC5

	LDR R0, R6, #0		;Load value in stack into R0
	ST R7, SAVELOC4		;Store JSR location

	OUT			; Print number for space
	LD R0, SPACE		; Load a space
	OUT			; Print space

	ADD R6, R6, #1		;Increment pointer
	
	ST R6, POINTER		;Store pointer location
	LD R7, SAVELOC4
	
	
RET

STACK_ERROR	LEA R0, ERROR
	 	PUTS
		HALT

BASELINE 	.FILL xC000
ERROR		.STRINGZ "STACK UNDERFLOW OR UNDERFLOW. HALTING PROGRAM"


;Subroutine
;Get_letter
;Takes a Two Digit Grade
;And Returns a Corresponding
;Letter Value to R0

;R3 = Input - Number to Convert
;R2 = Platform for Comparison
;R0 = Number Equivalent to Letter 
;R1 = Letter Equivalent to Number



GET_LETTER
	AND R2, R2, #0			; Clear R2

A_GRADE	LD R0, A_NUM			; Load Number Value 
		LD R1, A_LET		; Load Symbol Value 

		ADD R2, R3, R0		; Compare input to value of grade
		BRzp STR_GRADE		; If pos or zero store grade
B_GRADE	AND R2, R2, #0
		LD R0, B_NUM
		LD R1, B_LET

		ADD R2, R3, R0
		BRzp STR_GRADE

C_GRADE	AND R2, R2, #0
		LD R0, C_NUM
		LD R1, C_LET

		ADD R2, R3, R0
		BRzp STR_GRADE

D_GRADE	AND R2, R2, #0
		LD R0, D_NUM
		LD R1, D_LET

		ADD R2, R3, R0
		BRzp STR_GRADE

F_GRADE	AND R2, R2, #0
		LD R0, F_NUM
		LD R1, F_LET

		ADD R2, R3, R0
		BRNZP STR_GRADE

RET


STR_GRADE 	ST R7, SAVELOC1	  	; Save JSR Location
		AND R0, R0, #0	 	; Clear R0
		ADD R0, R1, #0	 	; Add Letter To R0
		JSR PUSH		; Push Letter To Stack
		LD R7, SAVELOC1		; Restore JSR Location
RET				 	; Return To Main


A_NUM	.FILL #-90
A_LET	.FILL X41

B_NUM	.FILL #-80
B_LET	.FILL X42

C_NUM	.FILL #-70
C_LET	.FILL X43

D_NUM	.FILL #-60
D_LET	.FILL X44

F_NUM	.FILL #-50
F_LET	.FILL X46



CLEAR_REG	AND R1, R1, #0
		AND R2, R2, #0
		AND R3, R3, #0
		AND R4, R4, #0
		AND R5, R5, #0
		AND R6, R6, #0
RET


;Subroutine
;Checks the Input for a Number
;if Not a Number Restarts Program
;R1 = -48  (Start of Numbers)
;R2 = -57  (End of Numbers)
;R0 = Input


VALIDA	ST R1, SAVELOC5		;Store variables
	ST R2, SAVELOC4
	ST R3, SAVELOC3

	LD R1, DATA_MIN		;Compare input to lowest acceptable value
	ADD R2, R0, R1		
	BRN FAIL		;Fail if out of range

	LD R1, DATA_MAX		;Compare input to highest acceptable value
	ADD R3, R0, R1
	BRP FAIL		;Fail if Out of Range

	LD R1, SAVELOC5		;Restore Variables
	LD R2, SAVELOC4
	LD R3, SAVELOC3

	RET


; Branches and variables for Valida


FAIL 	LEA R0, FAIL_STR	;Fail Branch
	PUTS
	LD R0, NEWLINE2
	OUT
	LD R7, RESTART		;Load X3000 Location
	JMP R7			;Restart Location


FAIL_STR	.STRINGZ "INVALID ENTRY, RESTARTING..."
RESTART		.FILL X3000
DATA_MIN	.FILL #-48
DATA_MAX	.FILL #-57
NEWLINE2	.FILL XA


.END