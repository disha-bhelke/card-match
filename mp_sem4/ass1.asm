%macro rw 3
mov rax, %1
mov rdi, 01
mov rsi, %2
mov rdx, %3
syscall
%endmacro

section .data
msg1 db "Enter 5 elements of array : ",10,13
len1 equ $-msg1
msg2 db "Array elements : ",10,13
len2 equ $-msg2
count db 5
newline db 10,13

section .bss
arr resb 100

global _start
section .text

_start:

rw 01,msg1,len1
mov rbx,arr

input_loop:
rw 00,rbx,17
add rbx,17
dec byte[count]
jnz input_loop

mov rbx,arr
rw 01,msg2,len2
mov byte[count],5

output_loop:
rw 01,rbx,17
add rbx,17
dec byte[count]
jnz output_loop

mov rax, 60
mov rdi, 00
syscall
