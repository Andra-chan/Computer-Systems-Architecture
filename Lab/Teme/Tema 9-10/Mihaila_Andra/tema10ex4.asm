bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf                              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll                           ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                         ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; Se dau doua numere naturale a si b (a, b: word, definite in segmentul de date). Sa se calculeze produsul lor si sa se afiseze in urmatorul format: "<a> * <b> = <result>"
; Exemplu: "2 * 4 = 8"
; Valorile vor fi afisate in format decimal (baza 10) cu semn.
segment data use32 class=data

        a dw 2
        b dw 4
        
        format db " %d * %d  = %d", 0 
        
segment code use32 class=code
    start:
        mov eax, 0
        mov ax, [a]         ; AX = a
        imul word[b]        ; DX:AX = AX * b = a * b 
        push dx
        push ax
        pop edx             ; EDX = a * b

        
        mov eax, 0
        mov ax, [a]         ; convertim a la dword
        cwde
        push dword eax
        mov ecx, eax        ; ECX = a dd 
        
        mov eax, 0
        mov ax, [b]         ; convertim a la dword
        cwde
        push dword eax      ; EAX = b dd
     
        pushad

        push dword edx      ; pune pe stiva edx(a*b)
        push dword eax      ; pune pe stiva eax(b)
        push dword ecx      ; pune pe stiva ecx(a)
        push dword format   ; pune pe stiva format
        call [printf]       ; format o sa fie de forma a*b=valoarea din edx
        add esp, 4*4        ; 4 parametrii cu cate 4 octeti
        
        popad

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
