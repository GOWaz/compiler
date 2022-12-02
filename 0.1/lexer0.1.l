%{
    /*definitions section*/
    #include<stdio.h>
    #include<ctype.h>
    int line=1;
%}

kewords "const"|"void"|"if"|"else"|"switch"|"case"|"break"|"continue"|"while"|"for"|"System"|"out"|"print"|"println"|"class"|"public"|"static"|"new"

dataType "int"|"float"|"double"|"boolean"|"byte"|"char"|"String"

latters [a-zA-Z]

digits [0-9]

numbers {digits}+

id {latters}({latters}|{digits})*

arrays ({dataType}("[""]")+{id}{assignmentOperators}{kewords}{dataType}("["{numbers}|{id}"]")+)

/*operators "+"|"-"|"*"|"/"|"+="|"-="|"*="|"/="|"="|"=="|"!="|">"|"<"|">="|"<="|"&&"|"||"*/

arithmeticOperators "+"|"-"|"*"|"%"|"/"|"="|"++"|"--"
assignmentOperators "+="|"-="|"*="|"%="|"/="|"|="|"&="
comparisonOperators "=="|"!="|">"|"<"|">="|"<="
logicalOperators "&&"|"||"|"!"

operators {arithmeticOperators}|{assignmentOperators}|{comparisonOperators}|{logicalOperators}

separators "["|"]"|"{"|"}"|"("|")"|";"|","|"."

ws [ \t\r\u]+

multiLineComment ("/*"({id}|{ws}|{numbers}|"\n")"*/")

lineComment ("//"({id}|{ws}|{numbers}|"\n"))

comment {multiLineComment}|{lineComment}

/*{arithmeticOperators} {printf("arithmetic Operators %s in line %d \n",yytext,line);}*/
/*{assignmentOperators} {printf("assignment Operators %s in line %d \n",yytext,line);}*/
/*{comparisonOperators} {printf("comparison Operators %s in line %d \n",yytext,line);}*/
/*{logicalOperators} {printf("logical Operators %s in line %d \n",yytext,line);}*/

/*Rules Section*/
%%
{kewords} {printf("keword %s in line %d \n",yytext,line);}
{dataType} {printf("data type %s in line %d \n",yytext,line);}
{arrays} {printf("array %s in line %d ",yytext,line);}
{ws} {printf("white space in line %d \n",line);}
{id} {printf("idint %s in line %d \n",yytext,line);}
{numbers} {printf("numbers %d in line %d \n",yytext,line);}
{operators} {printf("operator %s in line %d",yytext,line);}
{separators} {printf("separator %s in line %d \n",yytext,line);}
{comment} {printf("comment %s in line %d \n",yytext,line);}
. {printf("Error?? in line %d \n",line);}
\n {printf("new line \n");line++;}
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