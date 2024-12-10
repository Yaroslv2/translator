%{
#include "stdio.h"
#include "stdlib.h"

typedef struct {
    char data[100];
} YYSTYPE;

YYSTYPE yylval;
%}

%%
"void"                  {
                            printf("%s\n", "void"); 
                            //return TYPE;
                        }
"int"                   {
                            printf("%s\n", "INT"); 
                            //return TYPE;
                        }
"float"                 {
                            printf("%s\n", "float"); 
                            //return TYPE;
                        }
"double"                {
                            printf("%s\n", "double"); 
                            //return TYPE;
                        }
"bool"                  {   
                            printf("%s\n", "bool"); 
                            //return TYPE;
                        }
"char"                  {
                            printf("%s\n", "char"); 
                            //return TYPE;
                        }

"if"                    {
                            printf("%s\n", "if");
                            //return IF;
                        }
"else"                  {
                            printf("%s\n", "else");
                            //return ELSE;
                        }
"for"                   {
                            printf("%s\n", "for");
                            //return FOR;
                        }
"while"                 {
                            printf("%s\n", "while");
                            //return WHILE;
                        }
"do"                    {
                            printf("%s\n", "do");
                            //return DO;
                        }
"return"                {
                            printf("%s\n", "return");
                            //return RETURN;
                        }

[a-zA-Z_][a-zA-Z0-9]*   {
                            strcpy(yylval.data, yytext);
                            printf("%s\n", yytext);
                            //return IDENTIFIER;
                        }

[0-9]*                  {
                            strcpy(yylval.data, yytext); 
                            printf("%s\n", yytext); 
                            //return NUM;
                        }

"++"                    {
                            printf("%s\n", "increment");
                            //return INCREMENT;
                        }
"--"                    {
                            printf("%s\n", "decrement");
                            //return DECREMENT;
                        }
"+"                     {
                            printf("%s\n", "sign: +");
                            //return SIGN;
                        }
"-"                     {
                            printf("%s\n", "sign: -");
                            //return SIGN;
                        }
"*"                     {
                            printf("%s\n", "sign: *");
                            //return SIGN;
                        }
"%" {
                            printf("%s\n", "sign: \%");
                            //return SIGN;
                        }
"/"                     {
                            printf("%s\n", "sign: /");
                            //return SIGN;
                        }
">"                     {
                            printf("%s\n", "sign: >");
                            //return SIGN_MORE;
                        }
"<"                     {
                            printf("%s\n", "sign: <");
                            //return SIGN_LESS;
                        }
"="                     {
                            printf("%s\n", "sign: =");
                            //return SIGN_EQUAL;
                        }
"<="                    {
                            printf("%s\n", "sign: <=");
                            //return SIGN_LESS_EQUAL;
                        }
">="                    {
                            printf("%s\n", "sign: >=");
                            //return SIGN_MORE_EQUAL;
                        }
"+="                    {
                            printf("%s\n", "sign: +=");
                            //return sign_assignment_plus;
                        }
"=="                    {
                            printf("%s\n", "sign: ==");
                            //return sign_assignment_plus;
                        }
"!="                    {
                            printf("%s\n", "sign: !=");
                            //return SIGN_NOT_EQUAL;
                        }
"-="                    {
                            printf("%s\n", "sign: -=");
                            //return sign_assignment_minus;
                        }
"*="                    {
                            printf("%s\n", "sign: *=");
                            //return sign_assignment_minus;
                        }
"/="                    {
                            printf("%s\n", "sign: /=");
                            //return sign_assignment_minus;
                        }
"%="                    {
                            printf("%s\n", "sign: \%=");
                            //return sign_assignment_minus;
                        }
"{"                     {
                            printf("%s\n", "sign: {");
                            //return LSCBRACES;
                        }
"}"                     {
                            printf("%s\n", "sign: }");
                            //return sign_curly_brace_close;
                        }
"("                     {
                            printf("%s\n", "sign: (");
                            // return sign_curly_brace_close;
                        }
")"                     {
                            printf("%s\n", "sign: )");
                            // return sign_curly_brace_close;
                        }
":"                     {
                            printf("%s\n", ":");
                            // return DOUBLEPOINT;
                        }
";"                     {
                            printf("%s\n", ";");
                            // return SEMICOLON; 
                        }
","                     {
                            printf("%s\n", ",");
                            //return COMMA;
                        }

[ \n\t\r]               {} // ignore " " "\n" "\t" "\r"

.                       {
                            printf("unknown character %s\n", yytext);
                            exit(1);
                        }
%%


int yywrap(void){
return 1;
}

int main() {
    FILE* file;
    char filename[50];
    printf("path to file: ");
    scanf("%s", filename);
    file = fopen(filename, "r");
    if (file == NULL) {
        printf("Cannot open file(\n");
        return 0;
    }
    yyin = file;
    yylex();
    return 0;
}

// unused rule
// [a-zA-Z]                {
//                             strcpy(yylval.data, yytext);  
//                             printf("%s\n", yytext); 
//                             //return LETTER;
//                         }