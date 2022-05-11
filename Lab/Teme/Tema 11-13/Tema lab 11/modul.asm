bits 32                         
global zecimal

segment data public data use32
    zece dd 10
    sir dd 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536

segment code public code use32
zecimal:

    calcul:                     ;  conversia din baza 2 in baza 10 
        mov eax, ecx
        mov edx, 0
        div dword [zece]
        mov ecx, eax
        cmp edx, 0
        je sfarsit
        add ebx, [sir+4*esi]    ; sirul contine toate puterile lui 2
        cmp eax, 0
        ja sfarsit
        mov ecx, 0
        
    sfarsit:
        inc ecx
        inc esi
        
    loop calcul
    
    ret                         ; ne intoarcem in acelasi loc de unde am apelat aceasta functie, in main.asm
    
