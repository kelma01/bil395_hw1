%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
void yyerror(const char *s);
extern FILE *yyin;
extern void yy_scan_string(const char *s);
extern void yy_delete_buffer(void *);

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

    const char* test_cases[] = {
        "3 + 5\n",          // 8
        "10 - 2\n",         // 8
        "4 * 7\n",          // 28
        "8 / 2\n",          // 4
        "8 / 0\n",          // cannot divided by zero
        "(3 + 5) * 2\n",    // 16
        "10 - (2 + 3)\n",   // 5
        "3 + 5 * 2\n",      // 13
        "((2 + 3) * 4) / 2\n", // 10
        "42\n",             // 42
        "3 + \n",           // syntax error
        "abc\n",            // unknown character
    };

    int num_tests = sizeof(test_cases) / sizeof(test_cases[0]);

    for (int i = 0; i < num_tests; i++) {
        printf("Test %d: %s", i + 1, test_cases[i]);
        syntax_error_flag = 0;

        yyin = fmemopen((void*)test_cases[i], strlen(test_cases[i]), "r");
        yyparse();
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    syntax_error_flag = 1;
}
