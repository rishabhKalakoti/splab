extern printf
extern atoi

SECTION .data
forS: db '%s',10,0
forD: db '%d',10,0
SECTION .bss
i RESB 64
n RESB 64
S RESB 64
SECTION .text

global main
main:
mov rcx,rdi
mov r8,8
mov rdx, qword[rsi+r8]
														; mov to i
push rcx
push rdx
push rsi
push r8
mov rdi,rdx
call atoi
mov [i],rax
pop r8
pop rsi
pop rdx
pop rcx

add r8,8

push rcx
push rdx
push rsi
push r8
mov rdx, qword[rsi+r8]
mov rdi,rdx
call atoi
mov [n], rax
pop r8
pop rsi
pop rdx
pop rcx

mov rax,1
mov [S],rax

repeat:
mov eax,[n]
cmp eax,[i]
jl end
mov ebx,[n]
mul ebx
mov ebx,[S]
mul ebx
mov [S],eax
mov eax,[n]
dec eax
mov [n],eax
jmp repeat

end:

push rcx
push rdx
push rsi
push r8
mov rdi,forD
mov rsi, [S]
mov rax,0
call printf
pop r8
pop rsi
pop rdx
pop rcx

mov eax,1
mov rbx,0
int 80h
