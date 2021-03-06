extern printf
extern atoi

SECTION .data
forS: db '%s',10,0
forD: db '%d',10,0
one: db '1'
SECTION .bss
n RESB 64
SECTION .text

print1:
push rcx
push rdx
mov rdi,forS
mov rsi,one
mov rax,0
call printf
pop rdx
pop rcx
jmp next

global main
main:
mov rcx,rdi
mov r8,8
mov rdx, qword[rsi+r8]
														; mov to n
push rcx
push rdx
push rsi
push r8
mov rdi,rdx
call atoi
mov [n],rax
pop r8
pop rsi
pop rdx
pop rcx

mov rcx,1
mov rdx,1

mov rbx,1
repeat:
cmp rbx,[n]
jg end
cmp rbx,1
jz print1
cmp rbx,2
jz print1
mov rax, rcx
add rax,rdx
mov rcx,rdx
mov rdx,rax
mov rdi, forD
mov rsi, rax
mov rax,0
push rcx
push rdx
call printf
pop rdx
pop rcx
next:
inc rbx
jmp repeat

end:

mov eax,1
mov rbx,0
int 80h
