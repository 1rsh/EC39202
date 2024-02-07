; EC39202 | Embedded Systems Laboratory | 01 Feb 2024
; Group-14: Sh Pranjal Singh & Sh Irsh Vijayvargia

; Experiment - 2B
; 

	ORG 8100H;
	MOV P1,#0000H

	BLNK_ROUTINE:
		
		MOV P1,#0001H
		ACALL WAIT
		MOV P1,#0000H
		
		MOV P1,#0002H
		ACALL WAIT
		MOV P1,#0000H
		
		MOV P1,#0004H
		ACALL WAIT
		MOV P1,#0000H
		
		MOV P1,#0008H
		ACALL WAIT
		
		SJMP BLNK_ROUTINE


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