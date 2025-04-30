%macro rw 3
mov rax, %1
mov rdi, 01
mov rsi, %2
mov rdx, %3
syscall
%endmacro

section .data
msg2 db "Largest number : "
len2 equ $-msg2
count db 5
arr db 05h, 3Ch, 19h, 7Ah, 2Bh  ; 5, 60, 25, 122, 43

section .bss
max resb 1
output resb 2

global _start
section .text

_start:
mov rbx, arr
mov al, [rbx]
mov [max], al
inc rbx
mov byte [count], 4

largest_num:
mov al, [rbx]
cmp al, byte [max]
jle skipReplace
mov byte [max], al
skipReplace:
add rbx, 1
dec byte [count]
jnz largest_num

mov al, byte [max]
mov rbx, output
mov byte [count], 2

hex_to_ascii:
rol al, 4
mov dl, al
and dl, 0Fh
cmp dl, 09h
jle numCase
add dl, 7h

numCase:
add dl, 30h
mov [rbx], dl
inc rbx
dec byte [count]
jnz hex_to_ascii

rw 01, msg2, len2
rw 01, output, 2

mov rax, 60
mov rdi, 0
syscall
