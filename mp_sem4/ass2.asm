%macro rw 3
mov rax, %1
mov rdi, 01
mov rsi, %2
mov rdx, %3
syscall
%endmacro

section .data
count dw 0
msg1 db "Enter string : "
len1 equ $-msg1
msg2 db "Length of string : "
len2 equ $-msg2

section .bss
string resb 10

global _start
section .text

_start:

rw 01,msg1,len1
rw 00,string,10
mov rcx,rax
mov byte[string + rcx], 0    ;

mov rbx,string

count_len:
cmp byte[rbx],0
jz print_len
inc rbx
inc byte[count]
jmp count_len

print_len:
rw 01,msg2,len2
add byte [count], '0'  ;
rw 01,count,1

mov rax, 60
mov rdi, 00
syscall