bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fclose msvcrt.dll
import fprintf msvcrt.dll

; Se dau un nume de fisier si un text (definite in segmentul de date).
; Textul contine litere mici, litere mari, cifre si caractere speciale.
; Sa se inlocuiasca toate CIFRELE din textul dat cu caracterul 'C'.
; Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut prin inlocuire in fisier.
segment data use32 class=data
    nume_fisier db "fisier.txt", 0
    mod_acces db "w", 0
    
    text db 'Ana culege 5 mere si 3 pere.', 0
    len equ $-text
    rezultat times len db 0
    mai_mic db ':', 0
    alte_caractere db'/', 0
    
    descriptor_fis dd -1         ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier

; our code starts here
segment code use32 class=code
    start:
        mov ecx, len
        jecxz final
        
        mov esi, text
        mov edi, rezultat
        
        cld
        
    repeta:
        lodsb                       ; incarca primul caracter
        ;cmp al, '0'  
        cmp al, [mai_mic]           ; comparam cu ':'. Daca codul hexa este mai mic, este posibil sa fie cifra
        jl modifica                 ; salt 
            
        stosb                       ; stocheaza daca nu este ce ne trebuie
        jmp sar_peste
                
    modifica:
        cmp al, [alte_caractere]    ; verificam daca este cifra sau alt caracter. Daca codul hexa este mai mic ca '/', inseamna ca nu este cifra 
        jle stocheaza                ; salt
        mov al, 'C'                 ; modifica cifra cu 'C'
        stosb                       ; stocheaza noul caracter
        jmp sar_peste               ; salt
        
    stocheaza:                      ; daca potentiala cifra nu este corecta, se stocheaza caracterul nemodificat
        stosb
        
    sar_peste:    
        loop repeta 
  
        ; apelam fopen pentru a crea fisierul
        ; functia va returna in EAX descriptorul fisierului sau 0 in caz de eroare
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2                ; eliberam parametrii de pe stiva

        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0
        je final
        
        ; scriem textul in fisierul deschis folosind functia fprintf
        push dword rezultat
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 4*2
        
        ; apelam functia fclose pentru a inchide fisierul
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
    final:   
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
