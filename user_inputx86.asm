; Input Program in 32-bit Assembly (MASM)
; Author: Raulisr00t
.386
.model flat, stdcall
.stack 4096

extern GetStdHandle@4 :PROC
extern ReadConsoleA@20 :PROC
extern WriteConsoleA@20 :PROC
extern ExitProcess@4 :PROC

.data
inputBuffer BYTE 256 DUP(0)   
bytesRead DWORD ?                
prompt BYTE "Enter something: ", 0
output BYTE "You entered: ", 0
newline BYTE 13, 10, 0           

.code
main PROC
    ; Get handle to standard input (STD_INPUT_HANDLE)
    push -10
    call GetStdHandle@4
    mov ebx, eax                

    push -11
    call GetStdHandle@4
    mov ecx, eax                

    ; Write the prompt to the console
    lea edx, prompt
    push 0                       
    push OFFSET bytesRead
    push LENGTHOF prompt - 1
    push edx
    push ecx                     
    call WriteConsoleA@20

    lea edx, inputBuffer
    push 0                       
    push OFFSET bytesRead
    push 255                     
    push edx
    push ebx                    
    call ReadConsoleA@20

    lea edx, output
    push 0                       
    push OFFSET bytesRead
    push LENGTHOF output - 1
    push edx
    push ecx                   
    call WriteConsoleA@20

    ; Write the input back to the console
    lea edx, inputBuffer
    push 0                       
    push OFFSET bytesRead
    push bytesRead
    push edx
    push ecx                     
    call WriteConsoleA@20

    ; Write a newline to the console
    lea edx, newline
    push 0                       
    push OFFSET bytesRead
    push LENGTHOF newline - 1
    push edx
    push ecx                     
    call WriteConsoleA@20

    ; Exit the process
    push 0                       
    call ExitProcess@4

main ENDP
END main
