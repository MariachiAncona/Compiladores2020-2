%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

ent[0-9]+

%option noyywrap

%%

"+"  {return MAS;}
"*"  {return MUL;}
"("  {return LPAR;}
")"  {return RPAR;}
"\n" {return NL;}
{ent} {
        yylval.val = atoi(yytext);
        return NUMERO;
      }
[ \t] {}
.   {printf("Error léxico %s\n",yytext);}

%%