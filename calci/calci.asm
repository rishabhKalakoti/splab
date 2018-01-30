%include        'functions.asm'

SECTION .data
msgIn db 'Enter the two numbers one by one', 0Ah, 0h
msgCh	db 'add - 1',0Ah,'sub -2',0Ah,'mul 3',0Ah,'div - 4', 0Ah, 0h
msgAg db 'To exit enter 0, to perform again enter any other number', 0Ah, 0h
magArg	db	'Wrong number of arguments. Format: file num1 num2',0Ah,0h
msgInv	db	'Invalid Choice', 0Ah, 0h
lf		db	0Ah,0h
BYTE_BUFFER: times 10 db 0 ;

msgQ	db	'Quotient ',0h
msgRm	db	' Remainder ',0h
SECTION .bss
num1	RESB	2
num2	RESB	2
nCh		RESB	1
res		RESB	2

SECTION .text

global _start
iprint:
    push    eax             ; preserve eax on the stack to be restored after function runs
    push    ecx             ; preserve ecx on the stack to be restored after function runs
    push    edx             ; preserve edx on the stack to be restored after function runs
    push    esi             ; preserve esi on the stack to be restored after function runs
    mov     ecx, 0          ; counter of how many bytes we need to print in the end
 
divideLoop:
    inc     ecx             ; count each byte to print - number of characters
    mov     edx, 0          ; empty edx
    mov     esi, 10         ; mov 10 into esi
    idiv    esi             ; divide eax by esi
    add     edx, 48         ; convert edx to it's ascii representation - edx holds the remainder after a divide instruction
    push    edx             ; push edx (string representation of an intger) onto the stack
    cmp     eax, 0          ; can the integer be divided anymore?
    jnz     divideLoop      ; jump if not zero to the label divideLoop
 
printLoop:
    dec     ecx             
    mov     eax, esp       
    call    print      
    pop     eax          
    cmp     ecx, 0         
    jnz     printLoop       
 
    pop     esi            
    pop     edx             
    pop     ecx             
    pop     eax             
    ret
exit:
	mov eax, lf
	call	print
	mov	ebx, 0
	mov	eax, 1
	int	80h
	ret
len:
    push    ebx
    mov     ebx, eax 
nextchar:
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar
 
finished:
    sub     eax, ebx
    pop     ebx
    ret
scan:
	mov 	ecx,eax
	mov     edx, 255
    mov     ebx, 0
    mov     eax, 3
    int     80h
	ret
print:
	push    edx
    push    ecx
    push    ebx
    push    eax
    call    len
    mov     edx, eax
    pop     eax
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h
    pop     ebx
    pop     ecx
    pop     edx
    ret
add:
	mov al, [num1]
	sub al, '0'
	mov bl, [num2]
	sub bl, '0'
	add al, bl 		; al and bl
;	add al, '0' 		; add '0' to to convert the sum from decimal to ASCII 
	mov [res], al 	; storing the sum in memory location
	mov eax,[res]
;	call	print
;	mov		eax, 30
;	mov		ebx, 23
;	add		eax,ebx
	call 	iprint	
	jmp		exit
sub:
	mov al, [num1]
	sub al, '0'
	mov bl, [num2]
	sub bl, '0'
	sub al, bl 		; al and bl
	;add al, '0' 		; add '0' to to convert the sum from decimal to ASCII 
	mov [res], al 	; storing the sum in memory location
	mov eax,[res]
	call	iprint
	jmp		exit
mul:
	mov al, [num1]
	mov bl, [num2]
	; Convert from ascii to decimal
	sub al, '0'
	sub bl, '0'
	; Multiply. AX = AL x BL
	mul bl

	; Conversion from decimal to ascii
	;add al, '0'

	; We move the result
	mov [res], al
	mov eax,[res]
	call	iprint
	jmp		exit
div:
	  mov al, [num1]
		sub al, '0'   ; Convert from ascii to decimall
		mov bl, [num2]
		sub bl, '0'
		mov ah, 0  ;remainder
;		mov eax, 0  ;quotient
		; Division. Ax = AX / BX
		div bl

    ; Conversion from decimal to ascii
		;add al, '0'
		; We move the result
		mov [res], al
	mov eax,[res]
	call	iprint
	jmp		exit
_start:
start:
	mov 	eax, msgIn
	call 	print
									; scan the numbers	--------------	done
	mov 	eax, num1
	call 	scan
	mov 	eax, num2
	call 	scan
	
choice:								; scan the choice
	mov 	eax, msgCh
	call 	print					
	mov 	eax, nCh
	call 	scan

	mov 	eax, nCh
	cmp 	byte[eax],49
	jz 		add
	cmp 	byte[eax],50
	jz 		sub
	cmp 	byte[eax],51
	jz 		mul
	cmp 	byte[eax],52
	jz 		div
	mov		eax,msgInv
	call 	print
	jmp 	choice

	call exit
