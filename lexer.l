%{
    #include "parser.tab.h"
    #include <string.h>

    extern FILE* tokensFile;
    extern FILE* errors;
%}

%%

^#include.*$            {} // ignore
^#define.*$             {} // ignore
^using.*$               {} // ignore

"void"                  {
                            yylval.dataType = VOID;
                            fprintf(tokensFile, "TYPE: %s\n", "void"); 
                            return TYPE;
                        }
"int"                   {
                            yylval.dataType = NUMERICAL;
                            fprintf(tokensFile, "TYPE: %s\n", "INT"); 
                            return TYPE;
                        }
"float"                 {
                            yylval.dataType = FNUMERICAL;
                            fprintf(tokensFile, "%s\n", "float"); 
                            return TYPE;
                        }
"double"                {
                            yylval.dataType = FNUMERICAL;
                            fprintf(tokensFile, "%s\n", "double"); 
                            return TYPE;
                        }
"bool"                  {   
                            yylval.dataType = BOOLEAN;
                            fprintf(tokensFile, "%s\n", "bool"); 
                            return TYPE;
                        }
"char"                  {
                            yylval.dataType = STRING;
                            fprintf(tokensFile, "%s\n", "char"); 
                            return TYPE;
                        }

"char*"                 {
                            yylval.dataType = STRING;
                            fprintf(tokensFile, "%s\n", "char*"); 
                            return TYPE;
                        }

"if"                    {
                            fprintf(tokensFile, "%s\n", "if");
                            return IF;
                        }
"else"                  {
                            fprintf(tokensFile, "%s\n", "else");
                            return ELSE;
                        }
"for"                   {
                            fprintf(tokensFile, "%s\n", "for");
                            return FOR;
                        }
"while"                 {
                            fprintf(tokensFile, "%s\n", "while");
                            return WHILE;
                        }
"do"                    {
                            fprintf(tokensFile, "%s\n", "do");
                            return DO;
                        }
"return"                {
                            fprintf(tokensFile, "RETURN\n");
                            return RETURN;
                        }

"cin"                   {
                            fprintf(tokensFile, "CIN");
                            return CIN;
                        }
"cout"                  {
                            fprintf(tokensFile, "COUT");
                            return COUT;
                        }
"<<"                    {
                            fprintf(tokensFile, "COUT_BRACES");
                            return COUT_BRACES;
                        }
">>"                    {
                            fprintf(tokensFile, "CIN_BRACES");
                            return CIN_BRACES;
                        }
"endl"                  {
                            fprintf(tokensFile, "ENDL");
                            return ENDL;
                        }

"true"                  {
                            fprintf(tokensFile, "B_TRUE");
                            return B_TRUE;
                        }

"false"                 {
                            fprintf(tokensFile, "B_FALSE");
                            return B_FALSE;
                        }

[a-zA-Z_][a-zA-Z0-9]*   {
                            strcpy(yylval.strval, yytext);
                            fprintf(tokensFile, "IDENTIFIER: %s\n", yytext);
                            return IDENTIFIER;
                        }

[0-9]*                  {
                            yylval.number = atoi(yytext);
                            fprintf(tokensFile, "NUMBER: %s\n", yytext);
                            return NUMBER;
                        }

[0-9]*\.[0-9]*          {
                            yylval.fnumber = atof(yytext);
                            fprintf(tokensFile, "%s\n", yytext);
                            return FNUMBER;
                        }

"++"                    {
                            fprintf(tokensFile, "%s\n", "INCREMENT");
                            return INCREMENT;
                        }
"--"                    {
                            fprintf(tokensFile, "%s\n", "DECREMENT");
                            return DECREMENT;
                        }
"+"                     {
                            fprintf(tokensFile, "%s\n", "sign: +");
                            return SIGN_PLUS;
                        }
"-"                     {
                            fprintf(tokensFile, "%s\n", "sign: -");
                            return SIGN_MINUS;
                        }
"*"                     {
                            fprintf(tokensFile, "%s\n", "sign: *");
                            return SIGN_MULTIPLY;
                        }
"%" {
                            fprintf(tokensFile, "%s\n", "sign: \%");
                            return SIGN_DIV_REMAINDER;
                        }
"/"                     {
                            fprintf(tokensFile, "%s\n", "sign: /");
                            return SIGN_DIV;
                        }
">"                     {
                            fprintf(tokensFile, "%s\n", "sign: >");
                            return SIGN_MORE;
                        }
"<"                     {
                            fprintf(tokensFile, "%s\n", "sign: <");
                            return SIGN_LESS;
                        }
"="                     {
                            fprintf(tokensFile, "%s\n", "sign: =");
                            return SIGN_ASSIGNMENT;
                        }
"<="                    {
                            fprintf(tokensFile, "%s\n", "sign: <=");
                            return SIGN_LESS_EQUAL;
                        }
">="                    {
                            fprintf(tokensFile, "%s\n", "sign: >=");
                            return SIGN_MORE_EQUAL;
                        }
"+="                    {
                            fprintf(tokensFile, "%s\n", "sign: +=");
                            return SIGN_PLUS_ASSIGNMENT;
                        }
"=="                    {
                            fprintf(tokensFile, "%s\n", "sign: ==");
                            return SIGN_EQUAL;
                        }
"!="                    {
                            fprintf(tokensFile, "%s\n", "sign: !=");
                            return SIGN_NOT_EQUAL;
                        }
"-="                    {
                            fprintf(tokensFile, "%s\n", "sign: -=");
                            return SIGN_MINUS_ASSIGNMENT;
                        }
"*="                    {
                            fprintf(tokensFile, "%s\n", "sign: *=");
                            return SIGN_MULTIPLY_ASSIGNMENT;
                        }
"/="                    {
                            fprintf(tokensFile, "%s\n", "sign: /=");
                            return SIGN_DIV_ASSIGNMENT;
                        }
"||"                    {
                            fprintf(tokensFile, "%s\n", "OR");
                            return OR;
                        }
"&&"                    {
                            fprintf(tokensFile, "%s\n", "AND");
                            return AND;
                        }
"!"                     {
                            fprintf(tokensFile, "%s\n", "NOT");
                            return NOT;
                        }
"%="                    {
                            fprintf(tokensFile, "%s\n", "sign: \%=");
                            return SIGN_DIV_REMAINDER_ASSIGNMENT;
                        }
"{"                     {
                            fprintf(tokensFile, "LCBRACE\n");
                            return LCBRACE;
                        }
"}"                     {
                            fprintf(tokensFile, "%s\n", "sign: }");
                            return RCBRACE;
                        }
"("                     {
                            fprintf(tokensFile, "LPARENTHESIS\n");
                            return LPARENTHESIS;
                        }
")"                     {
                            fprintf(tokensFile, "RPARENTHESIS\n");
                            return RPARENTHESIS;
                        }
":"                     {
                            fprintf(tokensFile, "%s\n", ":");
                            return DOUBLEPOINT;
                        }
";"                     {
                            fprintf(tokensFile, "SEMICOLON\n");
                            return SEMICOLON; 
                        }
","                     {
                            fprintf(tokensFile, "COMMA\n");
                            return COMMA;
                        }

\".*\"                  {
                            fprintf(tokensFile, "STRING"); 
                            strcpy(yylval.strval, yytext);
                            return STRING; 
                        }
\'.*\'                  {
                            fprintf(tokensFile, "STRING"); 
                            strcpy(yylval.strval, yytext); 
                            return STRING; 
                        }

[ \n\t\r]               {} // ignore " " "\n" "\t" "\r"
.                       {
                            fprintf(errors, "unknown character \"%s\"\n", yytext);
                            exit(1);
                        }
%%


int yywrap(void){
    return 1;
}

// unused rule
// [a-zA-Z]                {
//                             strcpy(yylval.data, yytext);  
//                             fprintf(tokensFile, "%s\n", yytext); 
//                             //return LETTER;
//                         }