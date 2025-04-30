%macro rw 3
mov rax, %1
mov rdi, 01
mov rsi, %2
mov rdx, %3
syscall
%endmacro

section .data

counter db 2

newLine db 10, 13

section .bss

ans resb 1
output resb 2

section .text
global _start
_start:

pop rbx
pop rbx
pop rbx
mov bl, byte[rbx]
sub bl, 30h

call fact
mov byte[ans], al
call hexToAscii


jmp exit

fact:
    cmp bl, 1
    jne do_call
    mov al, 1

ret

do_call:
    push rbx
    dec bl
    call fact
    pop rbx
    mul bl
ret

hexToAscii:
    mov rbx, output
    mov byte[counter], 2
again:
    rol al, 4
    mov dl, al
    and dl, 0Fh
    cmp dl, 09h
    jle numCase
    add dl, 07h
numCase: 
    add dl, 30h
    mov byte[rbx], dl
    inc rbx
    dec byte[counter]
    jnz again
    rw 01, output, 2
    rw 01, newLine, 2

exit:
mov rax, 60
mov rdi, 00
syscall
