%{
    #include <stdio.h>
    #include <ctype.h>
    
   	int yylex (void);
  	int yyerror (char const *);

	extern FILE *yyin;

    int sym[26];
    int t0=0;
  	int t1=0;
	  int t2=0;
	  int t3=0;
	  int t4=0;
	  int cnt=0;
%}


%token NUMBER 
%token ID
%token INT FLOAT CHAR LONG VOID
%token EOL
%token FOR
%token ELSE RETURN IF
%left '<' '>'
%left '+' '-'
%left '*' '/'

%%


function: 
   type ID '(' listOfArgs ')' body {printf("\naccepted type function");}
  | VOID ID '(' listOfArgs ')' body {printf("\naccepted void function");}
  ;

type: INT | LONG | FLOAT | CHAR ;

body: '{' statements '}';

listOfArgs: { }
  | arg { }
  | listOfArgs ',' arg { }
  ;

arg: type ID ;

statement : varDecleration EOL | forLoop | returnn | ifStatement  ;


statements: statement statements | { };


forLoop:FOR '(' EOL EOL ')' body |
		FOR '(' EOL logicalExpression EOL ')' body |
		FOR '(' varDecleration EOL logicalExpression EOL expression')' body
;

varDecleration: 
  type ID setValue {printf("\nvarDecleration accepted value = %d ",$2);}

  ;

setValue:{ } | '=' expression;

returnn:
      RETURN  expression EOL {printf("value of expression in return %d\n",$2);}
       ;


logicalExpression:
 	 NUMBER '<' NUMBER	{ $$ = $1 < $3; }

	| NUMBER '>' NUMBER	{ $$ = $1 > $3; }
 ;

 ifStatement:  IF '(' logicalExpression ')' body {
								if($3)
								{
									printf("\n IF result = true: %d\n",$3);
								}
								else
								{
							     	printf("IF result = false \n");
								}
							}
          	| IF '(' logicalExpression ')' body ELSE body  {
								if($3)
								{
									printf("\n IF result = true: %d\n",$3);
								}
								else
								{
							     	printf("IF result = false \n");
								}
								}
	;

expression: NUMBER				{ $$ = $1; 	}

	| ID				{ $$ = sym[$1]; printf("\n source var value : %d \n",$1);}

	| expression '+' expression	{ $$ = $1 + $3; }

	| expression '-' expression	{ $$ = $1 - $3; }

	| expression '*' expression	{ $$ = $1 * $3; }

	| expression '/' expression	{ 	
	                    if($3) 
				  		{
				     		$$ = $1 / $3;
				  		}
				  		else
				  		{
							$$ = 0;
							printf("\ndivision by zero\t");
				  		} 	
				    }

	| '(' expression ')'		{ $$ = $2;	}
	; 

%%




/**/
void main(int argc, char **argv)
{
  yyin = fopen(argv[1],"r");
  yyparse();
  //return 0;
}

int yyerror(const char *s)
{
  fprintf(stderr, "  error !:  %s  \n", s);
  return 0;
}