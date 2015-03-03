%{
#include <stdio.h>
#include <math.h>
#define PI 3.14159265
void yyerror(char *);
int yylex(void);
int store[265];
          
       int fact(int n)
        {  
           int i;
           int sum=1;
           for(i=1;i<=n;i++)
           {
             sum = sum*i;
           
           }
         return sum;
           
        }

%}


%token MIN PLUS MUL POW  VAL DIV FACT VAR PRINT ENDS SIN TAN COS LN IF ELSE EQU GREATER LESSER 
%left ASSIGN
%left PLUS MIN
%left MUL DIV
%right FACT
%left POW
%nonassoc IF 
%nonassoc ELSE

%%
start: /* empty */
|start statement 				
						
;
statement: 	exp ENDS                        
|			PRINT VAR ENDS 					               {printf("%d\n", store[$2]);}
|     IFst                                										
;
exp: 		VAL											
| 		exp MUL exp 							            { $$ = $1 * $3; }
|			cholok MUL exp                		    { $$ = store[$1] * $3;}
|			cholok MUL cholok                	    { $$ = store[$1] * store[$3];}
|			exp MUL cholok                		    { $$ = $1 * store[$3];}
|     exp POW exp                           { $$ = pow($1,$3); }
|     cholok POW exp                        { $$ = pow(store[$1],$3);}
|     cholok POW cholok                     { $$ = pow(store[$1],store[$3]);}
|     exp POW cholok                        { $$ = pow($1,store[$3]);}
| 		exp PLUS exp 							            { $$ = $1 + $3; }
|			cholok PLUS exp                			  { $$ = store[$1] + $3;}
|			cholok PLUS cholok                		{ $$ = store[$1] + store[$3];}
|			exp PLUS cholok                			  { $$ = $1 + store[$3];}
| 		exp MIN exp 							            { $$ = $1 - $3; }
|			cholok MIN exp                			  { $$ = store[$1] - $3;}
|			cholok MIN cholok                		  { $$ = store[$1] - store[$3];}
|			exp MIN cholok                			  { $$ = $1 - store[$3];}
| 		exp DIV exp 							            { $$ = $1 / $3; }
|			cholok DIV exp                			  { $$ = store[$1] / $3;}
|			cholok DIV cholok               		  { $$ = store[$1] / store[$3];}
|			exp DIV cholok                			  { $$ = $1 / store[$3];}
|			cholok ASSIGN exp						          { store[$1] = $3;}								
|			cholok ASSIGN cholok                 	{ store[$1] = store[$3];} 
|     FACT '(' exp ')'                      {  $$ = fact($3); }  
|     FACT '(' cholok ')'                   {  $$ = fact(store[$3]);}
|     SIN '(' exp ')'                       {  $$ = sin($3*PI/180); }  
|     SIN '(' cholok ')'                    {  $$ = sin(store[$3]*PI/180);}
|     COS '(' exp ')'                       {  $$ = cos($3*PI/180); }  
|     COS '(' cholok ')'                    {  $$ = cos(store[$3]*PI/180);}
|     TAN '(' exp ')'                       {  $$ = tan($3*PI/180); }  
|     TAN '(' cholok ')'                    {  $$ = tan(store[$3]*PI/180);}
|     LN '(' exp ')'                        {  $$ = log($3); }  
|     LN '(' cholok ')'                     {  $$ = log(store[$3]);}
|     cholok EQU cholok                     {  $$ = (store[$1] == store[$3]); }
|     cholok GREATER cholok                 {  $$ = (store[$1] > store[$3]); }
|     cholok LESSER  cholok                 {  $$ = (store[$1] < store[$3]); }
;

cholok:		VAR
;
IFst:   IF  exp   statement                        
|       IF  exp   statement  ELSE  statement      
;
%%
void yyerror(char *s) {
fprintf(stderr, "%s\n", s);
}