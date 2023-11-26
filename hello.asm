section .data
    helloMessage db 'Hello, World!',0xa  ; The string to print, 0xa is newline
    len equ $ - helloMessage             ; Length of the string

section .text
    global _start                        ; Linker needs this to find the entry point!

_start:
    ; Write 'Hello, World!' to stdout
    mov eax, 4                           ; The syscall number for sys_write
    mov ebx, 1                           ; File descriptor 1 is stdout
    mov ecx, helloMessage                ; Pointer to our string
    mov edx, len                         ; Length of our string
    int 0x80                             ; Call kernel

    ; Exit the program
    mov eax, 1                           ; The syscall number for sys_exit
    xor ebx, ebx                         ; Return 0 status
    int 0x80                             ; Call kernel
