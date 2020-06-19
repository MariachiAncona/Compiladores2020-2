%{
#include <stdio.h>
#include <string.h>
#include "parser1.h"
%}

id [a-zA-Z_][a-zA-Z_0-9]*
esp [ \n\t\r]+

%%
int {return INT;}
float {return FLOAT;}
{id} {
        if(yyleng>32){
            printf("Error léxico, el identificador %s excede la longitud permitida\n", yytext);
            return -1;
        }
    }
"," {return COMA;}
";" {return PYC;}
{esp} {}

. {printf("Error léxico %s\n", yytext);}

%%

int yywrap(){
    return 1;
}