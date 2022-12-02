%{
    #include <stdio.h>
    #include <ctype.h>
%}
%union{
    int number;
    char charcter;
}

%token<number> NUMBER 
%type<number> exp
%token PLUS MINUS MULTIPLY DEVIDE
%token EOL 

%%
input : 
      exp EOL {printf("%d \n",$1);}
    | EOL;
exp:  NUMBER {$$ = $1;}
    | exp PLUS exp {$$ = $1 + $3;}
    ;
%%
/**/
int main(int argc, char **argv)
{
  yyparse();
  return 0;
}

int yyerror(const char *s)
{
  fprintf(stderr, "error!: %s\n", s);
  return 0;
}