D			[0-9]
L			[a-zA-Z_]

%{
    #include "parser.tab.h"
    int yywrap();
    void count(void);
%}

%%
"int"			{ count(); return(INT); }
"float"			{ count(); return(FLOAT); }
"char"			{ count(); return(CHAR); }
"long"			{ count(); return(LONG); }
"void"			{ count(); return(VOID); }

{D}+ {count(); yylval.number = atoi(yytext); return (NUMBER);}

{L}({L}|{D})* {count(); return (ID);}

","			{ count(); return (','); }
"("         { count(); return ('('); }
")"         { count(); return (')'); }
"="			{ count(); return ('='); }

";" {return (EOL);}

[ \t \n] { }

. {printf("error at %s \n",yytext);}

%%

int yywrap()
{
    exit(0);
}

int column = 0;

void count(void)
{
	int i;

	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			column = 0;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;

	ECHO;
}
