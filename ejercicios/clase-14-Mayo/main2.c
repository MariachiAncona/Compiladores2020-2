#include <stdio.h>
#include "parser1.h"

extern FILE *yyin;
extern int yylex();

int main(int argc, char** argv){
    FILE *f;
    if(argc < 2){
        printf("Faltan argumentos\n");
        return -1;
    }
    f = fopen(argv[1],"r");
    if(!f){
        printf("El archivo %s no se puede abrir\n",argv[1]);
        return -1;
    }
    yyin = f;
    token = yylex();
    decl();
    if (token == 0) printf("La cadena es aceptada\n");    
    fclose(yyin);
}