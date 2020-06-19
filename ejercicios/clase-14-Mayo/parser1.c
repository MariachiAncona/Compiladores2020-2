/*
* D -> D T {}; | €          D -> D'
                            D'-> T{}L;D' | €
* T -> int {}| float{}
* L -> L , id | id
*
*
*D -> T {L.tipo = T.tipo} L ; D | €
*T -> int{T.tipo = 0} | float {T.tipo = 1}
*L -> {id.tipo = L.tipo} id {} L'
*L'-> ,idL' | €
*/

#include <stdio.h>
#include <stdlib.h>
#include "parser1.h"

extern int yylex();


void error(){
    printf("Error sintáctico\n");
    exit(-1);
}

void decl(){
    if (token == INT || token == FLOAT){    
        int tipo = type();
        list(tipo);
        if (token == PYC) token=yylex();
        else error();
        decl();    
    }
}

int type(){
    if (token == INT){
        token==yylex();
        return 0;
    }else if(token == FLOAT){
        token=yylex();
        return 1;
    }else
        error();
}

void list(int tipo){
    if (token == ID){
        token = yylex();
        printf("El tipo es %d", tipo);
        list_prima(tipo);
    } else error();
}

void list_prima(int tipo){
    if (token == COMA){
        token = yylex();
        if (token == ID){
            token = yylex();
            printf("El tipo es %d", tipo);
            list_prima(tipo);
        } else error();
    }
}