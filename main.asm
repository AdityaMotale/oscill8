;
; Syscalls
;

%define SYS_WRITE 0x01
%define SYS_EXIT 0x3C

;
; OS Channels
;

%define OS_STDOUT 0x01

;
; Exit codes
;

%define EXIT 0x00
%define EXIT_INVALID_INPUT 0x0A

;
; Main
;

section .text
        global _start

_start:
        ; read argc
        mov rbx, [rsp]

        cmp rbx, 0x02
        jne .error

        ; read argv[1]
        mov rsi, [rsp + 0x10]

        mov rax, SYS_WRITE
        mov rdi, OS_STDOUT
        mov rdx, 0x02
        syscall
        
        mov rdi, EXIT
        jmp .exit
.error:
        mov rdi, EXIT_INVALID_INPUT
.exit:
        mov rax, SYS_EXIT
        syscall
        
