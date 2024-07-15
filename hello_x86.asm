.386                 
.model flat, stdcall 

extern GetStdHandle@4 :PROC
extern ExitProcess@4 :PROC
extern WriteConsoleA@20 :PROC

.data
msg BYTE "Hello World!",0    
bytesWritten DWORD ?         

.code
main PROC
    push -11                
    call GetStdHandle@4     

    mov  ecx, eax           
    lea  edx, msg           
    mov  eax, LENGTHOF msg - 1 
    lea  ebx, bytesWritten  
    push 0                  

    call WriteConsoleA@20   

    push 0                  
    call ExitProcess@4

main ENDP
END main
