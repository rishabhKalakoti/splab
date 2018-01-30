SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1

segment .data

msg1 	db 		"Enter the first digit", 0xA,0xD
len1 	equ 	$- msg1
msg2 	db 		"Please enter a second digit", 0xA,0xD
len2 	equ 	$- msg2
msg3 	db 		"Enter a choice 1 ADD 2 = SUB 3 = DIV 4 =MUL ", 0xA,0xD
len3 	equ 	$- msg3
msg5   	db      10,'Invalid Option',10,0
len5    equ     $ - msg5
msg6  	db		"Operation: ",0
len6	equ     $ - msg6
msg4 	db 		"The result is: ",10
len4 	equ 	$- msg4
nline   db  	10,0
lnline 	equ     $ - nline

 segment .bss
 choice resb 2 
 num1 resb 2
 num2 resb 2
 res resb 2

 section .text
 
 global _start
 
_start: ;tell linker entry point
        mov eax, SYS_WRITE ;"Enter the first digit", 0xA,0xD
        mov ebx, STDOUT
        mov ecx, msg1
        mov edx, len1
        int 0x80
		
		mov eax, SYS_READ ; read the 1st Digit entered by the user
		mov ebx, STDIN
		mov ecx, num1
		mov edx, 2
		int 0x80
		
        mov eax, SYS_WRITE ;"Please enter the second digit", 0xA,0xD
        mov ebx, STDOUT
        mov ecx, msg2
        mov edx, len2
        int 0x80
		
		mov eax, SYS_READ ; read 2nd user input
		mov ebx, STDIN
		mov ecx, num2
		mov edx, 2
		int 0x80
 
		mov eax, SYS_WRITE ; "Enter a choice 1 ADD 2 = SUB 3 = DIV 4 =MUL ",
        mov ebx, STDOUT
        mov ecx, msg3
        mov edx, len3
        int 0x80
		
					; Print on screen the message 8: operation
		mov eax, SYS_WRITE
		mov ebx, STDOUT
		mov ecx, msg6
		mov edx, len6
		int 80h
		
		  ; We get the option selected: any one from 1,2,3,4
		mov ebx,STDIN
		mov ecx,choice
		mov edx,2
		mov eax, SYS_READ
		int 80h
		 
		mov ah, [choice] ; move the users choice into ah register
		sub ah,'0'
		
		cmp ah, 1 		; compare user choice with the available options
		je _ADD			;if choice == 1 jump to add label
		
		cmp ah, 2
		je _SUB
		
		cmp ah, 4
		je _MUL
		
		cmp ah, 3
		je _DIV
			
         mov eax, SYS_WRITE ; if the wrong choice is entered
         mov ebx, STDOUT
         mov ecx, msg5
         mov edx, len5
         int 0x80
		jmp exit

_printMsg4:
		mov eax, SYS_WRITE
		mov ebx, STDOUT
		mov ecx, msg4
		mov edx, len4
		int 80h
		jmp _printSum
	
		; print the sum
_printSum:
		mov eax, SYS_WRITE
		mov ebx, STDOUT
		mov ecx, res  ; print the value of sum on the screen
		mov edx, 2 
		int 0x80
		jmp exit   ; jump to exit the program

		; moving the first number to eax register and second number to ebx
; and subtracting ascii '0' to convert it into a decimal number
_ADD:
		mov al, [num1]
		sub al, '0'
		mov bl, [num2]
		sub bl, '0'
		add al, bl 		; al and bl
		add al, '0' 		; add '0' to to convert the sum from decimal to ASCII 
		mov [res], al 	; storing the sum in memory location
		int 80h
		jmp _printMsg4
_SUB:
		mov al, [num1]
		sub al, '0'
		mov bl, [num2]
		sub bl, '0'
		sub al, bl 		; al and bl
		add al, '0' 		; add '0' to to convert the sum from decimal to ASCII 
		mov [res], al 	; storing the sum in memory location
		int 80h
		jmp _printMsg4
_DIV:
  ; We store the numbers in registers ax and bx
		mov al, [num1]
		sub al, '0'   ; Convert from ascii to decimall
		mov bl, [num2]
		sub bl, '0'
		mov ah, 0  ;remainder
;		mov eax, 0  ;quotient
		; Division. Ax = AX / BX
		div bl

    ; Conversion from decimal to ascii
		add al, '0'
		; We move the result
		mov [res], al
;		int 80h
		jmp _printMsg4
 _MUL:
	  ; We store the numbers in registers al and bl
		mov al, [num1]
		mov bl, [num2]
		; Convert from ascii to decimal
		sub al, '0'
		sub bl, '0'
    ; Multiply. AX = AL x BL
		mul bl

    ; Conversion from decimal to ascii
		add al, '0'

    ; We move the result
		mov [res], al
;		int 80h
		jmp _printMsg4
exit:
	mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, nline
    mov edx, lnline
    int 80h

	mov eax, SYS_EXIT
	mov ebx,0
	int 80h

