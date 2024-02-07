; EC39202 | Embedded Systems Laboratory | 11 Jan 2024
; Group-14: Sh Pranjal Singh & Sh Irsh Vijayvargia

; Experiment - 1B
; 
	
			
			ORG 8100H

			MOV DPTR, #9500H;
			MOV A, #3 ; Cubic
			MOVX @DPTR, A; 
			
			INC DPTR;
			MOV A, #2 ; Value of X to evaluate at
			MOVX @DPTR, A; 
			
			; Storing Coefficients

			INC DPTR;
			MOV A, #5;
			MOVX @DPTR, A;

			INC DPTR;
			MOV A, #4;
			MOVX @DPTR, A;

			INC DPTR;
			MOV A, #3;
			MOVX @DPTR, A;

			INC DPTR;
			MOV A, #4;
			MOVX @DPTR, A;
			
			; Polynomial Evaluation
			; Loading Coefficients
			MOV DPTR, #9500H;
			
			MOVX A, @DPTR;
			MOV R0, A;
			
			INC DPTR;
			MOVX A, @DPTR;
			MOV R1, A;
			
			MOV R2, #1;
			
			INC DPTR;
			MOVX A,@DPTR;
			MOV R3, A;
			
			
			; Multiplier Loop
MULT_LOOP: 
			MOV A, R2;
			MOV B, R1;

			MUL AB;
			MOV R2, A;
			
			INC DPTR;
			MOVX A, @DPTR;
			
			MOV B, R2;
			MUL AB;
			
			ADD A, R3;
			MOV R3, A;
			DJNZ R0, MULT_LOOP;


			; Storing Final Values
			MOV A, R3;
			MOV DPTR, #9550H;
			MOVX @DPTR, A;
			
			
			JMP PROGEND
			
			
PROGEND:
	JMP PROGEND
	END