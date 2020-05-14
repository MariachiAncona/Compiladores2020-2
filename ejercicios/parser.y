%{
/*Sección de declaraciones*/
#include <stdio.h>
extern int yylex();
void yyerror(char *s);
%}

%union{
    int val;
}
/* terminales={+,*,(,),id,\n}*/
%token NL
%token<val> NUMERO


/* %left, %right, %nonassoc*/
%left MAS
%left MUL
%nonassoc LPAR RPAR

/* No terminales = {L, E, T, F}
    L=line
    E=exp
    T=term
    F=factor
*/

%type<val> line exp term factor
%start line

%%
/*Sección del esquema de traducción, usa EBNF simplificada
 $$     $1 $2 $3 */
line : exp NL {$$=$1;
        printf("El valor de la operación es %d\n",$$);
        };

exp : exp MAS term {$$ = $1 + $3;}
    |term {$$=$1;};

term : term MUL factor {$$ = $1 * $3;}
    |factor {$$ = $1;}; 

factor : LPAR exp RPAR {$$ = $2;}
    |NUMERO {$$ = $1;};

%%
/*Sección de código de usuario*/


void yyerror (char *s){
    printf("%s\n",s);
}
