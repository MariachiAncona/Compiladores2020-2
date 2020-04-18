
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
ID              [#]({LETRA}|{DIGITO})+
RELACIONALES    (<|>|>=|<=|==|!=)
ASIGNACION      (\=)
LOGICOS         (\||^|~)


%%

<INITIAL>([1-9]{DIGITO}*)|"0"                        {printf( "Linea %d:Un entero: %s (%d)\n", yylineno, yytext, atoi( yytext ) );}

<INITIAL>{DIGITO}*"."{DIGITO}+       				 {printf( "Linea %d:Un real: %s (%g)\n",yylineno,  yytext, atof( yytext ) );}

<INITIAL>@if|@else|@while                            {printf( "Linea %d:Una palabra reservada: %s\n",yylineno,  yytext );}

<INITIAL>{ID}                                        {printf( "Linea %d:Un identificador: %s\n",yylineno,  yytext );}

<INITIAL>"+"|"-"|"*"|"/"|"%"	 		             {printf( "Linea %d:Un operador aritmetico: %s\n",yylineno,  yytext );}

<INITIAL>{RELACIONALES}								 {printf( "Linea %d:Un operador relacional: %s\n",yylineno,  yytext );}

<INITIAL>{LOGICOS}									 {printf( "Linea %d:Un operador logico: %s\n",yylineno,  yytext );}

<INITIAL>{ASIGNACION}								 {printf( "Linea %d:Un operador de asignacion: %s\n",yylineno,  yytext );}

<INITIAL>"{"|"}"|"("|")"|";"|","					 {printf( "Linea %d:Un operador de puntuacion: %s\n",yylineno,  yytext );}

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