%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"

int yywrap() { return 1; }
extern int syntax_error_flag;

%}

%%
[0-9]+      { yylval.num = atoi(yytext); return NUMBER; }
"("         { return LPAREN; }
")"         { return RPAREN; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return TIMES; }
"/"         { return DIVIDE; }
\n          { return '\n'; }
[ \t]       {}
.           { printf("Error: unknown character\n", yytext); syntax_error_flag = 1;}
%%