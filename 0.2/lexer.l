%{
    #include "parser.tab.h"
%}


%%
[0-9]+ {yylval.number = atoi(yytext); return NUMBER;}
"+" {return PLUS;}
"-" {return MINUS;}
"*" {return MULTIPLY;}
"/" {return DEVIDE;}
";" {return EOL;}
[ \t \n] { }
. {printf("error! %s",yytext);}

%%

int yywrap(){
    exit(0);
}