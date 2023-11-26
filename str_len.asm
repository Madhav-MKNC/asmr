section .bss
    user_input resb 256            ; Reserve 256 bytes for user input

section .data
    prompt db 'Enter a string: ', 0
    promptLen equ $ - prompt
    output db 'The length of the string is: ', 0
    outputLen equ $ - output

section .text
    global _start

_start:
    ; Print the prompt
    mov eax, 4                   ; syscall number for sys_write
    mov ebx, 1                   ; file descriptor 1 is stdout
    mov ecx, prompt              ; pointer to the prompt string
    mov edx, promptLen           ; length of the prompt
    int 0x80                     ; make the system call

    ; Read user input
    mov eax, 3                   ; syscall number for sys_read
    mov ebx, 0                   ; file descriptor 0 is stdin
    mov ecx, user_input          ; buffer to store input
    mov edx, 256                 ; number of bytes to read
    int 0x80                     ; make the system call
    sub eax, 1                   ; adjust for newline character

    ; Save the length of the input
    push eax                     ; save the length on the stack

    ; Print the output message
    mov eax, 4                   ; syscall number for sys_write
    mov ebx, 1                   ; file descriptor 1 is stdout
    mov ecx, output              ; pointer to the output string
    mov edx, outputLen           ; length of the output
    int 0x80                     ; make the system call

    ; Print the length
    pop ecx                      ; get the length off the stack
    mov eax, 4                   ; syscall number for sys_write
    mov ebx, 1                   ; file descriptor 1 is stdout
    mov edx, 10                  ; maximum number of digits to print
    call print_num               ; call the print_num function

    ; Exit the program
    mov eax, 1                   ; syscall number for sys_exit
    xor ebx, ebx                 ; return 0 status
    int 0x80                     ; make the system call

; Function to print a number
print_num:
    add ecx, '0'                 ; convert the number to ASCII
    mov [user_input], cl         ; store the character
    mov ecx, user_input          ; point to the buffer
    mov edx, 1                   ; length is 1
    int 0x80                     ; make the system call
    ret
