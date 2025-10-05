section .text
        global _start

_start:
        mov rax, 0x3C
        xor rdi, rdi
        syscall
        
