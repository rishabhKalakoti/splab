SECTION .data
msgIn db 'Enter the two numbers one by one', 0Ah, 0h
msgCh	db 'add - 1',0Ah,'sub -2',0Ah,'mul 3',0Ah,'div - 4', 0Ah, 0h
msgAg db 'To exit enter 0, to perform again enter any other number', 0Ah, 0h
msgInv	db	'Invalid Choice', 0Ah, 0h
lf		db	0Ah,0h
msgRm	db	' Remainder ',0h
SECTION .bss
num1	RESB	1
num2	RESB	1
nCh		RESB	1
res		RESB	1

SECTION .text

global _start
atoi:
    push    ebx             
    push    ecx             
    push    edx           
    push    esi            
    mov     esi, eax      
    mov     eax, 0     
    mov     ecx, 0        
 
.multiplyLoop:
    xor     ebx, ebx        ; resets both lower and uppper bytes of ebx to be 0
    mov     bl, [esi+ecx]   ; move a single byte into ebx register's lower half
    cmp     bl, 48          ; compare ebx register's lower half value against ascii value 48 (char value 0)
    jl      .finished       ; jump if less than to label finished
    cmp     bl, 57          ; compare ebx register's lower half value against ascii value 57 (char value 9)
    jg      .finished       ; jump if greater than to label finished
    cmp     bl, 10          ; compare ebx register's lower half value against ascii value 10 (linefeed character)
    je      .finished       ; jump if equal to label finished
    cmp     bl, 0           ; compare ebx register's lower half value against decimal value 0 (end of string)
    jz      .finished       ; jump if zero to label finished
 
    sub     bl, 48          ; convert ebx register's lower half to decimal representation of ascii value
    add     eax, ebx        ; add ebx to our interger value in eax
    mov     ebx, 10         ; move decimal value 10 into ebx
    mul     ebx             ; multiply eax by ebx to get place value
    inc     ecx             ; increment ecx (our counter register)
    jmp     .multiplyLoop   ; continue multiply loop
 
.finished:
    mov     ebx, 10         ; move decimal value 10 into ebx
    div     ebx             ; divide eax by value in ebx (in this case 10)
    pop     esi             ; restore esi from the value we pushed onto the stack at the start
    pop     edx             ; restore edx from the value we pushed onto the stack at the start
    pop     ecx             ; restore ecx from the value we pushed onto the stack at the start
    pop     ebx             ; restore ebx from the value we pushed onto the stack at the start
    ret
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
;	mov		eax,[num1]
;	call 	atoi
;	mov		edx,eax	
;	mov		eax,[num2]
;	call	atoi
;	add		eax,edx
;	call	iprint
;	jmp		repeat
	mov		eax, 30
	mov		ebx, 23
	add		eax,ebx
	call 	iprint	
	jmp		repeat
sub:
	mov		eax, 30
	mov		ebx, 23
	sub		eax,ebx
	call 	iprint	
	jmp		repeat
mul:
	mov		eax, 30
	mov		ebx, 23
	mul		ebx
	call 	iprint	
	jmp		repeat
div:
	mov		eax, 15
	mov		ebx, 3
	div		ebx
	call 	iprint
	mov		eax, msgRm
	call 	print
	mov		eax, edx
	call 	iprint
	jmp		repeat
_start:
start:
;	mov 	eax, msgIn
;	call 	print
;									; scan the numbers	--------------	done
;	mov 	eax, num1
;	call 	scan
;	mov 	eax, num2
;	call 	scan
	
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

repeat:	
	mov eax, lf
	call print								; scan for repeat	---------------	done
	mov eax, msgAg
	call print
	mov eax, nCh
	call scan
	mov eax, nCh
	cmp byte[eax],48
	jz	exit
	jmp	start
	call exit
