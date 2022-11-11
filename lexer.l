%{
    /*definitions section*/
%}

kewords "int"|"float"|"double"|"boolean"|"char"|"String"|"const"|"if"|"else"

latters [a-zA-Z]

digits [0-9]

numbers {digits}+

id {latters}({latters}|{digits})*

operators "+"|"-"|"*"|"/"|"+="|"-="|"*="|"/="|"="|"=="|"!="|">"|"<"|">="|"<="|"&&"|"||"

separators "["|"]"|"{"|"}"|"("|")"|";"|","|"."

ws [ \t\r\u]+

comment ("/*"({id}|{ws}|{numbers}|"\n")"*/")

lineComment ("//"({id}|{ws}|{numbers}|"\n"))


/*Rules Section*/
%%
{kewords} {printf("keword %s \n",yytext);}
{ws} {printf("white space \n");}
{id} {printf("idint %s \n",yytext);}
{numbers} {printf("numbers %d \n",yylex);}
{operators} {printf("operator %s \n",yytext);}
{separators} {printf("separator %s \n",yytext);}
{comment} {printf("multi line comment %s \n",yytext);}
{lineComment} {printf("line comment %s \n",yytext);}
\n {printf("new line \n");}
%%

int yywrap(){
    exit(0);
}

int main(){
    printf("Start here:  ");
    yylex();
}