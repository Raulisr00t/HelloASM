# Hello World Program in Assembly (MASM)

Author: Raulisr00t

## Description
This is a simple "Hello World" program written in x64 assembly language using MASM (Microsoft Macro Assembler). It demonstrates how to output text to the console using Windows API functions.

## Requirements
- Microsoft Macro Assembler (MASM)
- Windows operating system

## Instructions

### Assembly and Linking

1. **Install MASM**: Ensure MASM is installed. It is typically included with Visual Studio under the Desktop development with C++ workload.

2. **Create the Assembly Source File**: Save the following code into a file named `hello.asm`:

   ```assembly
   ; Hello World Program in Assembly (MASM)
   ; Author: Raulisr00t

   extern GetStdHandle:PROC
   extern ExitProcess:PROC
   extern WriteConsoleA:PROC

   .data
   msg BYTE "Hello World!",0
   bytesWritten DWORD ?

   .code
   main PROC
       sub rsp, 5 * 8              ; reserve shadow space

       mov rcx, -11                ; nStdHandle (STD_OUTPUT_HANDLE)
       call GetStdHandle

       mov  rcx, rax               ; hConsoleOutput
       lea  rdx, msg               ; *lpBuffer
       mov  r8, LENGTHOF msg - 1   ; nNumberOfCharsToWrite
       lea  r9, bytesWritten       ; lpNumberOfCharsWritten
       mov  QWORD PTR [rsp + 4 * SIZEOF QWORD], 0  ; lpReserved
       call WriteConsoleA

       mov rcx, 0                  ; uExitCode
       call ExitProcess
   main ENDP
   END
   ````

3. Set Up the Build Environment: Open the Developer Command Prompt for Visual Studio.

4. Assemble the Source File: Navigate to the directory containing helloworld.asm and assemble it using ml64:
    ```powershell
   ml64 /c /Fohello.obj hello.asm
    ```
5. Link the Object File: Link the object file to create an executable:
   ```powershell
     link /SUBSYSTEM:CONSOLE /ENTRY:main hello.obj kernel32.lib
    ```
### Running the Program
6. Run the Executable: After linking, run the resulting executable:
  ``` powershell
      hello.exe
   ```
