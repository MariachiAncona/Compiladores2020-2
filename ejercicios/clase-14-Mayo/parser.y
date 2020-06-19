%{
#include <stdio.h>
extern int yylex();
void yyerror(char *s);
int tipo;
//Tipo = 0 -> entero
//Tipo = 1 -> flotante
%}

%union{
    int tipo;
    char id[32];
}

%token COMA PYC
%token<id> ID
%token INT FLOAT

%type<tipo> type /* T */
%start decl /* D */

%%
/*
* D -> D T L; | €
* T -> int | float
* L -> L , id | id
*/

//$$   $1    $2       $3        $4   $5
decl : decl type {tipo = $2 ;} list PYC |; 

type : INT {$$ = 0;} | FLOAT {$$ = 1;};

list : list COMA ID {printf("El tipo de %s es %d\n", $3, tipo);}
        | ID {printf("El tipo de %s es %d\n", $1, tipo);};

%%
void yyerror(char *s){
    printf("%s\n",s);
}
