; EC39202 | Embedded Systems Laboratory | 11 Jan 2024
; Group-14: Sh Pranjal Singh & Sh Irsh Vijayvargia

; Experiment - 1A
; 
			
		    ORG 8100H
            MOV R0, #100
            MOV DPTR, #9000H


GENERATOR:   ; Inputting values in descending order (Random Number Generator can be replaced here)
            MOV A,R0
            MOVX @DPTR, A
            INC DPTR
            DJNZ R0, GENERATOR

            
            ; Beginning Sorting
            MOV R2, #100 ; Number of elements in Array -> ARR_CTR
            
ARR_CTR:
                MOV R3, #99 ; Number of elements in Array - 1 -> BUBBLE_SORT
BUBBLE_SORT:
                    ; Storing value at index "i" in R4
                    DEC R3
                    MOV DPTR,#9000H
                    MOV A, R3
                    ADD A,DPL
                    MOV DPL,A
                    MOVX A, @DPTR
                    MOV R4,A

                    ; Storing value at index "i+1" in R5
                    INC R3
                    MOV DPTR,#9000H
                    MOV A, R3
                    ADD A,DPL
                    MOV DPL,A
                    MOVX A, @DPTR
                    MOV R5,A

                    ; Comparing
                    MOV A, R5
                    MOV B, R4
                    CLR C
                    SUBB A,B
                    JC SWAP_FLAG ; Swapping if flagged

                    DJNZ R3, BUBBLE_SORT
                DJNZ R2,ARR_CTR



            SJMP BIN_SEARCH_INIT


SWAP_FLAG:
            ;Swap and store them
            MOV B,R5
            MOV A, R4
            MOV R5,A
            MOV R4,B
            MOV DPTR,#9000H
            DEC R3
            MOV A,R3
            ADD A,DPL
            MOV DPL,A
            MOV A,R4
            MOVX @DPTR,A
            INC R3
            INC DPTR
            MOV A,R5
            MOVX @DPTR,A
            DJNZ R3, BUBBLE_SORT

            DJNZ R2,ARR_CTR


			; Initialising Binary Search
BIN_SEARCH_INIT:
            MOV DPTR, #9500H
            MOVX A, @DPTR
            MOV R7, A ;R7 stores the key
            MOV DPTR, #9000H
            MOV R1, #0 ; lower index
            MOV R2, #99; higher index
BIN_SEARCH:
            MOV A,R2
            CLR C
            SUBB A, R1
            JC NOT_FOUND
            MOV A,R1
            ADD A, R2
            MOV B,#2
            DIV AB
			; Middle->R6
			; Left->R1
			; Right->R2
            MOV R6,A 
            ; Check if middle is equal to the key value
            MOV A,R6
            MOV DPTR,#9000H
            ADD A,DPL
            MOV DPL,A
            MOVX A, @DPTR ; A contains middle element
            MOV B,R7; B -> Key
            CLR C

            CJNE A,B, UPDATE
            ; Exit if key is found
            MOV DPTR,#9550H
            MOV A,R6
            MOVX @DPTR,A
            SJMP PROGEND

UPDATE:
            JC RIGHT_FLAG ; Key in right subarray
            ; Key in left subarray 
            MOV A,R6
            MOV R2,A
            DEC R2
            SJMP BIN_SEARCH

RIGHT_FLAG:
            MOV A,R6
            MOV R1,A
            INC R1
            SJMP BIN_SEARCH
			
NOT_FOUND: ;Store -1 and exit
            MOV A,#-1
            MOV DPTR, #9550H
            MOVX @DPTR,A
            SJMP PROGEND

PROGEND:
            SJMP PROGEND
            END