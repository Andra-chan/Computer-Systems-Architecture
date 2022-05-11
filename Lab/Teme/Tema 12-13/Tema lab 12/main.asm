bits 32 ; assembling for the 32 bits architecture

global start
global _rev       

; declare external functions needed by our program  
extern printf, scanf, exit
import scanf msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll


; Se citeste o propozitie de la tastatura.
; Sa se inverseze fiecare cuvant si sa se afiseze pe ecran.
segment data use32 class=data
	format db '%s', 0
	msg db 'Introduceti o propozitie(despartita prin spatii): ', 0
	msg1 db 'Se citeste o propozitie de la tastatura. Sa se inverseze fiecare cuvant si sa se afiseze pe ecran.', 10, 0
	msg2 db 'Propozitia "inversata" este: ', 0
    propozitie dd 0

; our code starts here
segment code use32 class=code
    start:
        push dword msg1                 ; mesaj problema
        call [printf]      
        add esp, 4                      ; eliberam parametrii de pe stiva
        
        push dword msg                  ; mesaj initial de afisare
        call [printf]      
        add esp, 4
    
        push dword propozitie           ; variabila propozitie stocheaza propozitia introdusa de utilizator
        push dword format               ; este de tip string
        call [scanf]
        add esp, 4*2
        
    _rev:
        mov eax, propozitie
        ret    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
