%macro rw 3
mov rax, %1
mov rdi, 01
mov rsi, %2
mov rdx, %3
syscall
%endmacro

section .data
pos_count db 0
neg_count db 0
myArray db  0FBh, 0Ah, 14h, 1Eh, 28h, 32h, 3Ch  
counter db 7
msg1 db "Positive numbers: "
len1 equ $-msg1
msg2 db "Negative numbers: "
len2 equ $-msg2

section .bss
pos_ascii resb 1
neg_ascii resb 1

global _start
section .text

_start:

mov rbx, myArray

count_loop:
mov al, [rbx]
test al, 80h                ; Test if the sign bit is set (negative number)
jz pos                       ; Jump to 'pos' if the number is positive (sign bit not set)

inc byte [neg_count]         ; Increment negative count
jmp next_element

pos:
inc byte [pos_count]         ; Increment positive count

next_element:
inc rbx
dec byte [counter]
jnz count_loop               ; Continue loop until counter is zero

rw 01, msg1, len1
mov al, [pos_count]
add al, '0'                  ; Convert number to ASCII
mov [pos_ascii], al
rw 01, pos_ascii, 1

rw 01, msg2, len2
mov al, [neg_count]
add al, '0'                  ; Convert number to ASCII
mov [neg_ascii], al
rw 01, neg_ascii, 1

mov rax, 60                  ; Exit syscall
mov rdi, 00                  ; Status 0
syscall
