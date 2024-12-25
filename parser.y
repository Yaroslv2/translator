%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    extern FILE* yyin;
    extern FILE* yyout;
    FILE* tokensFile;
    FILE* errors;

    extern int yylex();
    extern void yyerror(const char* s);
%}

%debug

%code requires {
    typedef enum { NUMERICAL, FNUMERICAL, BOOLEAN, VOID, STRINGIFY} DataTypeEnum;
}

%code {
    int tabs_count = 0;

    void printTabs();
}

%union {
    DataTypeEnum dataType;
    int number;
    double fnumber;
    char strval[4000];
}

%token <dataType> TYPE
%token IF ELSE FOR WHILE DO RETURN
%token <strval> IDENTIFIER STRING
%token <number> NUMBER
%token <fnumber> FNUMBER
%token INCREMENT DECREMENT SIGN_PLUS SIGN_MINUS SIGN_MULTIPLY SIGN_DIV SIGN_DIV_REMAINDER
%token SIGN_MORE SIGN_LESS SIGN_ASSIGNMENT SIGN_LESS_EQUAL SIGN_MORE_EQUAL SIGN_PLUS_ASSIGNMENT
%token SIGN_EQUAL SIGN_NOT_EQUAL SIGN_MINUS_ASSIGNMENT SIGN_MULTIPLY_ASSIGNMENT SIGN_DIV_ASSIGNMENT
%token SIGN_DIV_REMAINDER_ASSIGNMENT LCBRACE RCBRACE LPARENTHESIS RPARENTHESIS DOUBLEPOINT SEMICOLON
%token CIN COUT CIN_BRACES COUT_BRACES ENDL
%token COMMA
%token OR AND NOT B_TRUE B_FALSE

%type <strval> expression func_args expression_sign func_call if_statement cout_statement

%start program

%%
program: 
    statements 
    { fprintf(yyout,"if __name__ == \"__main__\":\n\tmain()\n");}
    ;

statements:
    statements statement
        { fprintf(yyout, "\n"); }
    | statement
        { fprintf(yyout, "\n"); }
    ;

statement:
    advertisement
    | return_expression
    | if_statement
        { printTabs(); fprintf(yyout, "%s", $1); tabs_count++; }
    | for_statement
    | while_statement
    | cout_statement
        { printTabs(); fprintf(yyout, "%s", $1); }
    | expression
        { printTabs(); fprintf(yyout, "%s", $1); }
    | expression SEMICOLON
        { printTabs(); fprintf(yyout, "%s", $1); }
    ;

cout_statement:
    COUT COUT_BRACES expression SEMICOLON
        { sprintf($$, "print(%s)", $3); }
    ;

if_statement:
    IF LPARENTHESIS expression RPARENTHESIS
        { sprintf($$, "if %s:", $3); }
    | IF LPARENTHESIS expression RPARENTHESIS LCBRACE
        { sprintf($$, "if %s:", $3); }
    | ELSE LCBRACE
        { sprintf($$, "else:"); }
    | ELSE if_statement
        { sprintf($$, "el%s", $2); }
    
    ;

for_statement:
    FOR LPARENTHESIS advertisement expression SEMICOLON expression RPARENTHESIS
        { fprintf(yyout, "\n"); printTabs(); fprintf(yyout, "while %s:\n", $4);
          tabs_count++; printTabs(); fprintf(yyout, "%s", $6); tabs_count--; }
    | FOR LPARENTHESIS advertisement expression SEMICOLON expression RPARENTHESIS RCBRACE
        { fprintf(yyout, "\n"); printTabs(); fprintf(yyout, "while %s:\n", $4);
          tabs_count++; printTabs(); fprintf(yyout, "%s", $6); }
    ;

while_statement:
    WHILE LPARENTHESIS expression RPARENTHESIS
        { printTabs(); fprintf(yyout, "while %s:", $3); }
    ;

advertisement:
    TYPE IDENTIFIER SIGN_ASSIGNMENT expression SEMICOLON
        { printTabs(); fprintf(yyout, "%s = %s", $2, $4); }
    | TYPE IDENTIFIER SEMICOLON
        { fprintf(yyout, ""); }
    
    | func_advertisement
    ;

func_advertisement:
    TYPE IDENTIFIER LPARENTHESIS RPARENTHESIS SEMICOLON
        { fprintf(yyout, ""); }
    | TYPE IDENTIFIER LPARENTHESIS RPARENTHESIS LCBRACE
        { printTabs(); fprintf(yyout, "def %s():", $2); tabs_count++; }
    | TYPE IDENTIFIER LPARENTHESIS RPARENTHESIS
        { printTabs(); fprintf(yyout, "def %s():", $2); }
    | TYPE IDENTIFIER LPARENTHESIS func_args RPARENTHESIS LCBRACE
        { printTabs(); fprintf(yyout, "def %s(%s):", $2, $4); tabs_count++; }
    | TYPE IDENTIFIER LPARENTHESIS func_args RPARENTHESIS
        { printTabs(); fprintf(yyout, "def %s(%s):", $2, $4); }
    ;

func_args:
    expression
        { sprintf($$, "%s", $1); }
    | func_args COMMA func_args
        { sprintf($$, "%s, %s", $1, $3); }
    ;

return_expression:
    RETURN SEMICOLON
        { printTabs(); fprintf(yyout, "return"); }
    | RETURN expression SEMICOLON
        { printTabs(); fprintf(yyout, "return %s", $2); }
    ;

expression_sign:
    SIGN_PLUS
        { sprintf($$, "+"); }
    | SIGN_MINUS
        { sprintf($$, "-"); }
    | SIGN_MORE
        { sprintf($$, ">"); }
    | SIGN_ASSIGNMENT
        { sprintf($$, "="); }
    | SIGN_LESS
        { sprintf($$, "<"); }
    | SIGN_PLUS_ASSIGNMENT
        { sprintf($$, "+="); }
    | SIGN_DIV
        { sprintf($$, "/"); }
    | SIGN_MULTIPLY
        { sprintf($$, "*"); }
    | SIGN_DIV_REMAINDER 
        { sprintf($$, "//"); }
    | SIGN_MINUS_ASSIGNMENT
        { sprintf($$, "-="); }
    | SIGN_EQUAL
        { sprintf($$, "=="); }
    | AND
        { sprintf($$, "and"); }
    | OR
        { sprintf($$, "or"); }
    ;

expression:
    func_call
        { sprintf($$, "%s", $1); }
    | NOT expression
        { sprintf($$, "not %s", $2); }
    | expression expression_sign expression
        { sprintf($$, "%s %s %s", $1, $2, $3); printf("%s %s %s\n", $1, $2, $3); }
    | LPARENTHESIS expression RPARENTHESIS
        { sprintf($$, "(%s)", $2); }
    | IDENTIFIER
        { sprintf($$, "%s", $1); printf("EXPRESSION IDENTIFIER: %s\n", $1);}
    | STRING
        { sprintf($$, "%s", $1); }
    | NUMBER
        { sprintf($$, "%d", $1); }
    | FNUMBER
        { sprintf($$, "%f", $1); }
    | LCBRACE
        { tabs_count++; printf("LCBRACE %d\n", tabs_count); sprintf($$, ""); }
    | RCBRACE
        { tabs_count--; printf("RCBRACE %d\n", tabs_count); sprintf($$, ""); }
    | TYPE IDENTIFIER
        { sprintf($$, "%s", $2); }
    | B_TRUE
        { sprintf($$, "True"); }
    | B_FALSE
        { sprintf($$, "False"); }
    ;

func_call:
    IDENTIFIER LPARENTHESIS func_args RPARENTHESIS
        { sprintf($$, "%s(%s)", $1, $3); }
    | IDENTIFIER LPARENTHESIS RPARENTHESIS
        { sprintf($$, "%s()", $1); }
    ;
%%

void printTabs() {
    for (int i = 0; i < tabs_count; i++) {
        fprintf(yyout, "    ");
    }
}

void yyerror(const char *s) {
    fprintf(errors, "Error: %s\n", s);
}

int main(int argc, char** argv) 
{
    yydebug = 1;
    printf("Starting programm...\n");
    errors = fopen("./output/errors.txt", "w");
    if (errors == NULL) {
        printf("Cannot create errors.txt file\n");
        return 0;
    }

    tokensFile = fopen("./output/tokens.txt", "w");

    yyin = fopen("input.cpp", "r");
    if (!yyin) {
        fprintf(errors, "Cannot open file %s\n", argv[0]);
        fclose(errors);
        return 0;
    }
    yyout = fopen("output.py", "w");
    if (yyout == NULL) {
        fclose(yyin);
        fprintf(errors, "Cannot create output file\n");
        fclose(errors);
        return 0;
    }

    yyparse();
    
    fclose(yyin);
    fclose(yyout);
    fclose(errors);
    printf("Result was writed in file \"output.py\"\n");
    return 0;
}