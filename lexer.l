%{
    /*definitions section*/
    #include<stdio.h>
    #include<ctype.h>
    //int line=0;
%}

kewords "int"|"float"|"double"|"boolean"|"char"|"String"|"const"|"void"|"if"|"else"|"while"|"for"|"System"|"out"|"print"|"printLn"|"class"|"public"|"static"

latters [a-zA-Z]

digits [0-9]

numbers {digits}+

id {latters}({latters}|{digits})*

/*operators "+"|"-"|"*"|"/"|"+="|"-="|"*="|"/="|"="|"=="|"!="|">"|"<"|">="|"<="|"&&"|"||"*/

arithmeticOperators "+"|"-"|"*"|"%"|"/"|"="|"++"|"--"
assignmentOperators "+="|"-="|"*="|"%="|"/="|"|="|"&="
comparisonOperators "=="|"!="|">"|"<"|">="|"<="
logicalOperators "&&"|"||"|"!"

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
{arithmeticOperators} {printf("arithmetic Operators %s \n",yytext);}
{assignmentOperators} {printf("assignment Operators %s \n",yytext);}
{comparisonOperators} {printf("comparison Operators %s \n",yytext);}
{logicalOperators} {printf("logical Operators %s \n",yytext);}
{separators} {printf("separator %s \n",yytext);}
{comment} {printf("multi line comment %s \n",yytext);}
{lineComment} {printf("line comment %s \n",yytext);}
. {printf("??");}
\n {printf("new line \n");}
%%

int yywrap(){
    exit(0);
}

void main(int argc, char **argv)
{
    if (argc > 1){
        for(int i=0;i<argc;i++)
            printf("value of argv[%d] = %s\n\n",i,argv[i]);
            yyin=fopen(argv[1],"r");
    }  
    else
        yyin=stdin;
    yylex();
}

/*int main(){
    printf("Start here:  ");
    yylex();
}*/