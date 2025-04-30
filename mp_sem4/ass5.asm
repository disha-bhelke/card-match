%macro IO 4
    mov rax, %1
    mov rdi, %2
    mov rsi, %3
    mov rdx, %4 
    syscall        
%endmacro

section .data
msg1: db "Enter choice (1. +, 2. -, 3. *, 4. /, 5. Exit): ", 0xA
len1 equ $-msg1
msg2: db "The 2 numbers are: ", 0xA
len2 equ $-msg2
n1: dq 0xF
n2: dq 0x5
rem_msg: db "Remainder is: ", 0xA
len_rem equ $-rem_msg
quo_msg: db "Quotient is: ", 0xA
len_quo equ $-quo_msg

section .bss
choice resb 2
ans resb 16

section .text
global _start
_start:
IO 1, 1, msg1, len1
IO 0, 0, choice, 2
cmp byte[choice], 34H
JE divlbl
cmp byte[choice], 33H
JE mullbl
cmp byte[choice], 32H
JE sublbl
cmp byte[choice], 31H
JE addlbl
JMP exit

addlbl:
mov rax, [n1]
mov rbx, [n2]
add rax, rbx
call DtoA
JMP exit

sublbl:
mov rax, [n1]
mov rbx, [n2]
sub rax, rbx
call DtoA
JMP exit

mullbl:
mov rax, [n1]
mov rbx, [n2]
mul rbx
call DtoA
JMP exit

divlbl:
mov rax, [n1]
mov rbx, [n2]
xor rdx, rdx
div rbx
IO 1, 1, quo_msg, len_quo
call DtoA
IO 1, 1, rem_msg, len_rem
call DtoA
JMP exit

exit:
mov rax, 60
mov rdi, 0
syscall

DtoA:
mov rsi, ans
mov rcx, 0
mov rbx, 10
test rax, rax
jnz convert_loop
mov byte [rsi], '0'
inc rsi
jmp done_conversion

convert_loop:
xor rdx, rdx
div rbx
add dl, '0'
push rdx
inc rcx
test rax, rax
jnz convert_loop

reverse_loop:
pop rdx
mov [rsi], dl
inc rsi
loop reverse_loop

done_conversion:
mov byte [rsi], 0
mov rdx, rsi
sub rdx, ans
IO 1, 1, ans, rdx
ret
