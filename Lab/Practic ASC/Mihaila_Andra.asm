bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fread, fclose, printf,scanf               
import exit msvcrt.dll   
import fopen msvcrt.dll 
import fread msvcrt.dll 
import fclose msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll 

; Sa se scrie un program in limbaj de asamblare care:
; citeste de la tastatura numele unui fisier text;
; citeste un text (de maximum 100 caractere) din acest fisier;
; stocheaza textul citit intr-o variabila care va fi definita in segmentul de date;
; determina si afiseaza cuvintele care se află pe pozitii multiplu de 3 in textul citit.
segment data use32 class=data
    nume_fisier db 0
    format db '%s',0
    msg db 'Introduceti numele fisierului: ',0
    mod_acces db 'r',0
    
    msg_fisier db 'Fisierul a fost deschis si citit!',10,0
    format1 db 'Textul din fisier este: %s',10,0
    len equ 100                  ; numarul maxim de elemente citite din fisier.                            
    text times (len+1) db 0      ; sirul in care se va citi si stocha textul din fisier 
    
    rezultat times (len+1) db 0
    msg_rezultat db 'Rezultatul final este: %s',0
    
    descriptor_fis dd -1

; our code starts here
segment code use32 class=code
    start:
        push dword msg              ; mesaj initial de afisare
        call [printf]
        add esp, 4                  ; eliberam parametrii de pe stiva
        
        push dword nume_fisier      ; variabila nume fisier stocheaza numele
        push dword format
        call [scanf]0
        add esp, 4*2
        
        push dword mod_acces     
        push dword nume_fisier      ; deschidem fisierul cu numele dat
        call [fopen]
        add esp, 4*2

        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
            
        ; verificam daca functia fopen a deschis cu succes fisierul (daca EAX != 0)
        cmp eax, 0
        je final
        
        push dword [descriptor_fis]
        push dword len                  ; ne asiguram ca nu depaseste lungimea maxima de 100 de caractere
        push dword 1
        push dword text        
        call [fread]                    ; cititm textul din fisier, variabila text retine continutul fisierului
        add esp, 4*4
        
        push dword msg_fisier           ; mesaj pentru confirmare
        call[printf]
        add esp, 4
        
        push dword text                 ; verific daca ce s-a salvat in variabila text este bun
        push dword format1
        call [printf]
        add esp, 4*2
              
        mov ecx, len                    
        jecxz final                     ; verific daca mai am caractere in text
        
        mov esi, text                   ; textul initial
        mov edi, rezultat               ; textul final
        
    repeta:
        lodsb
        cmp al,' '
        je cuvant  
        ;je multiplu
    
     cuvant:
        mov bx, 0
        add bx, 1
        cmp bx, 3
        je multiplu
        add bx, 1        

    multiplu:
        mov bx,0
        stosb
    loop repeta

    next:
        push dword rezultat             ; variabila rezultat stocheaza textul final
        push dword msg_rezultat
        call [printf]
        add esp, 4
             
        push dword [descriptor_fis]     ; inchid fisierul
        call [fclose]
        add esp, 4
    
    final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
