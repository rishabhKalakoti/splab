SECTION .data
lf db 0Ah,0h
num equ 6
SECTION .bss

SECTION .text
global _start
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

iprint:
push    eax
push    ecx
push    edx
push    esi
mov     ecx, 0

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

fact:
cmp eax,0
jz base_con
mov ecx,eax
push ecx
dec eax
call fact
pop ecx
mul ecx
ret
base_con:
mov eax,1
ret

_start:
mov eax,num
call fact
call iprint
mov eax,lf
call print
mov eax,1
mov ebx,0
int 80h
