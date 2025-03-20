%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
int syntax_error_flag = 0;
%}

%union {
    int num;
}

%token <num> NUMBER
%token PLUS MINUS TIMES DIVIDE LPAREN RPAREN

%type <num> expr 

%left PLUS MINUS
%left TIMES DIVIDE

%%
input:
    expr '\n'  { 
        if (!syntax_error_flag)
            printf("> %d\n", $1); 
        syntax_error_flag = 0;  // Hata sonrası flag sıfırlanacak
    }
    | '\n'      
    | input expr '\n' { 
        if (!syntax_error_flag)
            printf("> %d\n", $2); 
        syntax_error_flag = 0;  
    }
    ;

expr:
      expr PLUS expr{$$ = $1 + $3;}
    | expr MINUS expr{$$ = $1 - $3;}
    | expr TIMES expr{$$ = $1 * $3;}
    | expr DIVIDE expr{
        if ($3 == 0){
            printf("Error: cannot divide by zero\n");
            syntax_error_flag = 1;
            $$ = 0;
        } 
        else 
            $$ = $1 / $3;
      }
    | LPAREN expr RPAREN{ $$ = $2; }
    | NUMBER{ $$ = $1; }
    ;
%%

int main() {
    printf("ARITHMETIC CALCULATOR\n");
    printf("Enter expr below:\n");
    while(1){
        syntax_error_flag = 0;
        yyparse();
    }
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    syntax_error_flag = 1;
}