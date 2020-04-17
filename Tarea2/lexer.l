
%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    void error(char *s);
%}

%s COMENTARIO

%option yylineno
%option noyywrap

LETRA           [a-zA-Z]
DIGITO          [0-9]
ENTERO          ([1-9]{DIGITO}+)|[0]
DECIMAL         ({ENTERO}*\.{DIGITO})
ID              [#]({LETRA}|{DIGITO})+
ARIT            (+|-|*|/|%)
RELACIONALES    (<|>|>=|>=|==|!=)
PUNTUACION      ({|}|(|)|;|,)
ASIGNACION      (\=)
LOGICOS         (\||^|~)
%%

<INITIAL>{DIGITO}+                                   {printf( "Un entero: %s (%d)\n", yytext, atoi( yytext ) );}

<INITIAL>{DIGITO}+"."{DIGITO}*                       {printf( "Un real: %s (%g)\n", yytext, atof( yytext ) );}

<INITIAL>@if|@else|@while                            {printf( "Una palabra reservada: %s\n", yytext );}

<INITIAL>{ID}                                        {printf( "Un identificador: %s\n", yytext );}

<INITIAL>"+"|"-"|"*"|"/"                             {printf( "Un operador: %s\n", yytext );}

<INITIAL>"{"[^}\n]*"}"                               {/* se come una linea de comentarios */}

<INITIAL>[ \t\n]+                                    {/* se come los espacios en blanco */}

<INITIAL>.                                           { error(yytext); }

<INITIAL>"/*"                                        {BEGIN(COMENTARIO);}

<COMENTARIO>[^*/]                                    {/*Se puede usar cualquier caracter*/}
<COMENTARIO>[*/]                                     {/*Ignora un asterisco o una diagonal*/}
<COMENTARIO>"*/"                                     {BEGIN(INITIAL);/*Retorna cuando encuentra asterisco y diagonal juntos*/}

%%
void error(char *s){
	printf("Error léxico: %s, línea: %d \n", s, yylineno);
}

int main(int argc, char **argv){
	FILE *f;
	if(argc<2){
		printf("Falta el archivo\n");
		exit(-1);
	}
	f = fopen(argv[1],"r");
	if(!f){
		printf("No se pudo abrir el archivo\n");
		exit(-1);
	}
	yyin = f;
	int tok = yylex();
	while(tok != 0){
		printf("<%d\n", tok);
		tok = yylex();
	}
	fclose(yyin);
	return 0;
}