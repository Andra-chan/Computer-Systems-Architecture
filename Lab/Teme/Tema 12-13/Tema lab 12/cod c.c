void rev(char sir[])
{
    int n = strlen(sir);
    int st = 0, dr = 0;
    while (dr < n){
        while (sir[dr] != ' ' && sir[dr] != '\0') dr++;
        int stop = (dr - st + 1) / 2;
        for (int i = 0; i < stop; i++){
            char aux = sir[st + i];
            sir[st + i] = sir[dr - i - 1];
            sir[dr - i - 1] = aux;
        }
        dr++;
        st = dr;
    }
    char propozitie[50];
    printf("%s", propozitie)
}