%{
    #include <stdio.h>
    #include <ctype.h>
    extern int yylex();
    extern FILE *yyin;
    int yyerror(const char *s);
%}
%union{
    int number;
    char *string;
}

%token<number> NUMBER 
%token ID
%token INT FLOAT CHAR LONG VOID
%token EOL


%%
function: type ID '(' ')' EOL {printf("\naccepted without args");}
  | type ID '(' listOfArgs ')' EOL {printf("\naccepted with args");}
  | VOID ID '(' ')' EOL {printf("\naccepted void func without args");}
  | VOID ID '(' listOfArgs ')' EOL {printf("\naccepted void func with args");}
  ;

listOfArgs: { }
  | arg { }
  | listOfArgs ',' arg { }
  ;

arg: type ID ;

type: INT | LONG | FLOAT | CHAR ;

%%
/**/
int main(int argc, char **argv)
{
  yyparse();
  return 0;
}

int yyerror(const char *s)
{
  fprintf(stderr, "error!: %s \n", s);
  return 0;
}