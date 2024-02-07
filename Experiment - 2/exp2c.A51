; EC39202 | Embedded Systems Laboratory | 07 Feb 2024
; Group-14: Sh Pranjal Singh & Sh Irsh Vijayvargia

; Experiment - 2C
; 	
				
			ORG 8100H
			; Initially Off
			MOV P1, #0000H
			MOV A,#0FFH
			MOV P3,A
			JNB P3.3,BLINKIT ; Checking LDR Status
			
MAIN_FN:
			MOV DPTR,#9000H ; Counter for the CTR
			
CTR:
			MOV A, DPL
			ANL A, #0FH 
			MOV DPL, A
			MOV A, DPL
			MOV R1, A 

			MOVX A,@DPTR
			MOV B,#16
			MUL AB

			ADD A, R1
			JNB P3.3, BLINKIT

			MOV P1, A
			LCALL WAIT

			INC DPTR
			SJMP CTR
			
BLINKIT:
			MOV P1,#1FH ; All High
			ACALL WAIT
			MOV P1,#0H ; All Low
			ACALL WAIT
			JNB P3.3, BLINKIT ; Checking LDR Status
			
			LJMP MAIN_FN

; 1 second Wait subroutine
WAIT:
		MOV R5,#44
		H3:
			MOV R4,#248
			H2:
				MOV R3,#51 ; 255
				H1:        
					DJNZ R3,H1
			DJNZ R4,H2
		DJNZ R5,H3
		RET
	END