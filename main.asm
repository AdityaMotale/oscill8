; SPDX-License-Identifier: MIT
; Copyright: (c) 2025 Aditya Motale
; Version: 0.1
; Requires: Linux x86-64, AVX2
; Author: Aditya Motale
; Description: Oscill8 is a CLI tool to render a sine wave as ASCII using SIMD (AVX2) to understand
;              and visualize fractional precision in x86.

;;
;; Syscalls
;;

%define SYS_WRITE 0x01
%define SYS_EXIT 0x3C

;;
;; OS Channels
;;

%define OS_STDOUT 0x01

;;
;; Exit codes
;;

%define EXIT 0x00
%define EXIT_INVALID_INPUT 0x0A

;;
;; Main
;;

section .text
        global _start

_start:
        ; ----------
        ; Reading `argc` & `argv`
        ; ----------
        ; 
        ; At start, the `argv` and `argc` are stored on the stack. So the [rsp] contains,
        ; 
        ;   [rsp]     = argc
        ;   [rsp+8]   = pointer argv[0] (NOTE: this is the name of program, we ignore it!)
        ;   [rsp+16]  = pointer argv[1] (first user argument)
        ;   ... etc.
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
        
