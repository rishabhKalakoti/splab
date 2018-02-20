extern printf
extern atoi

SECTION .data
forS: db '%s',10,0
forD: db '%d',10,0
SECTION .bss
n RESB 64
i RESB 64
SECTION .text

print1:
mov rdi,forD
mov [i],eax
mov rsi,[i]
call printf
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

mov rax,1
repeat:
cmp rax,[n]
jg end
cmp rax,1
jz print1
cmp rax,2
jz print1
mov rbx, rcx
add rbx,rdx
mov rcx,rdx
mov rdx,rbx
mov rsi, rbx
mov rdi, forD
call printf

next:
inc eax
jmp repeat

end:

mov eax,1
mov rbx,0
int 80h
