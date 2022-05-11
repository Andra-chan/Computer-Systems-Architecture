bits 32
global start

; nasm -fobj main.asm
; nasm -fobj modul.asm

; alink main.obj modul.obj -oPE -subsys console -entry start

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

extern zecimal

; Se citeste de la tastatura un sir de mai multe numere, in baza 2.
; Sa se afiseze aceste numere in baza 16.
segment data use32
	format_baza16 db '%x', 10, 0
	format_baza2 db '%u', 0
	msg db 'Introduceti un numar in baza 2(contine doar 0 si 1): ', 0
	msg1 db 'Se citeste de la tastatura un sir de mai multe numere, in baza 2. Sa se afiseze aceste numere in baza 16. Pentru iesirea din aplicatie introduceti orice numar zecimal diferit de 0 sau 1.', 10, 0
	msg2 db 'Numerele in baza 16 sunt: ', 0
    zece dd 10
    len equ 100
    d times len dd 0
    nr dd 0
    
segment code use32 public code
start:
    push dword msg1                 ; mesaj problema
    call [printf]      
    add esp, 4                      ; eliberam parametrii de pe stiva
    
    mov edi, 0
    mov esi, 0
    
    repeta:
        push dword msg              ; mesaj initial de afisare
        call [printf]      
        add esp, 4
    
        push dword nr               ; variabila nr stocheaza numarul introdus de utilizator
        push dword format_baza2     ; este de tip unsigned
        call [scanf]
        add esp, 4*2
        
        mov ecx, [nr]               ; in ecx punem valoarea lui nr([nr] - valoare, nr - offset)
        mov ebx, 0
        mov eax, 0
        mov esi, 0
    
        call zecimal                ; functia ce converteste numarul nr din baza 2 in baza 10
        
        mov esi, edi
        mov [d+4*esi], ebx          ; in [d+4*esi] avem numarul in baza 16
        inc edi
        
        jmp repeta
        
    ending:
        push dword msg2             ; mesaj final 
        call [printf]      
        add esp, 4                  ; eliberam parametrii de pe stiva
    
        mov esi, 0
        cmp esi, edi
        je final                    ; sare la final daca esi=edi
        mov ecx, 0
        
    afisare:
        push dword [d+4*esi]        ; numarul in baza 16
        push dword format_baza16    ; de tip hexa
        call [printf]
        add esp, 4*2                ; eliberam parametrii de pe stiva

        inc esi
        cmp esi, edi
        jne afisare
        
    final:
        push    dword 0      
        call    [exit] 