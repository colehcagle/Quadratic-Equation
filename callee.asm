title	Quadratic Equation with Floating-Point Numbers		(Lab11.asm)
;
; Cole Cagle
; CPEN 3710
; April 12, 2022
;
; This is an assembly language program that is called from a C++ program to calculate the 
; quadratic equation. The user inputs the values from the C++ program and this program will
; perform calculations and return the result to the C++ program. In short, I/O through C++ and 
; calculations in assembly language.
;

.686
.model FLAT, C

public quadratic                                                ; quadratic can be called by external code

.data								; beginning of data (values in the equation)
var0 REAL4 0.0
var2 REAL4 2.0
var4 REAL4 4.0
sqrt REAL4 ?

.code                                                           ; beginning of code
quadratic proc                                                  ; beginning of quadratic procedure

push EBP                                                        ; pushes base pointer onto stack
mov EBP, ESP                                                    ; creates a new base pointer
fld REAL4 PTR [EBP+12]						; loads value of B into ST(0)
fmul REAL4 PTR [EBP+12]                                        	; squares the value of B
fld REAL4 PTR [EBP+8]						; loads value of A into ST(0), b^2 is ST(1)
fmul REAL4 PTR [EBP+16]                                        	; multiplies value of A and C
fmul var4							; multiplies 4 by product of ac
fsub 								; subtracts b^2 - 4ac under the square root

fld REAL4 PTR var0						; loads 0.0 into ST(0)
fcomi ST(0), ST(1)                                              ; compares value in ST(0) to ST(1)
fstp var0							; pops 0.0 off of stack
ja JUMP1                                                        ; if below 0, jump to JUMP1

fsqrt                                                           ; takes the square root of ST(0)
fst sqrt							; stores the square root value in sqrt
fld REAL4 PTR [EBP+12]						; loads the value of B into ST(0)
fchs                                                            ; changes the value to negative
fadd								; loads -b+sqrt
fld REAL4 PTR [EBP+8]						; loads value of A into ST(0)
fmul REAL4 PTR var2						; multiplies 2 and A for denominator
fdiv ST(1), ST(0)                                               ; divides the numerator by the denominator
fstp var0
mov EDI, [EBP+20]						; gets the pointer for root1
fstp REAL4 PTR [EDI]						; stores root1 in memory

fld REAL4 PTR [EBP+12]						; loads the value of B into ST(0)
fchs                                                            ; changes the value to negative
fld sqrt							; loads the value under the square root to ST(0)
fsub								; loads -b-sqrt
fld REAL4 PTR [EBP+8]						; loads value of A into ST(0)
fmul REAL4 PTR var2						; multiplies 2 and A for denominator
fdiv ST(1), ST(0)                                               ; divides the numerator by the denominator
fstp var2
mov ESI, [EBP+24]						; gets the pointer for root2
fstp REAL4 PTR [ESI]						; stores root2 in memory
jmp JUMP2                                                       ; jump to JUMP2

JUMP1:                                                          ; beginning of JUMP1
pop EBP								; takes base pointer off stack
mov EAX, 1                                                      ; moves 1 into EAX
neg EAX								; makes EAX = -1
ret								; return to C++ program

JUMP2:                                                          ; beginning of JUMP2
mov EAX, 0							; moves 0 into EAX since roots are not complex

pop EBP                                                         ; takes EBP off the stack

ret                                                             ; return to C++ program

quadratic ENDP                                                  ; stops execution of quadratic proc
END                                                             ; end of program