%{
   
   #include "project.tab.h"
   #include <stdlib.h>
   void yyerror(char *);

%}

%x IN_COMMENT

%%

[#][#].*  {}

<INITIAL>{
     "#*"              BEGIN(IN_COMMENT);
     }
     <IN_COMMENT>{
     "*#"      BEGIN(INITIAL);
     [^*\n]+   
     "*"       
     \n        
     }

[0-9]+        { yylval = atoi(yytext); return VAL;}
"("|")"         {return *yytext; }
somansoman    { return EQU; }
boro           { return GREATER; }
choto         { return LESSER; }
biyog         { return MIN;   }
jog           { return PLUS;  } 
gun           { return MUL;   }
vag           { return DIV;   }
pow           { return POW;   }
soman         { return ASSIGN;}
fact          { return FACT;  }
_show_        { return PRINT; }
sin           { return SIN;   }
cos           { return COS;   }
tan           { return TAN;   }
ln            { return LN;    }
_if_          { return IF;    }
_else_        { return ELSE;  }
[>]           { return ENDS;  }
[a-zA-Z]      { yylval = *yytext;  return VAR;}
[ \t]         { }
[\n]          { } 
. yyerror("Unknown!! ");

%%
int yywrap(){
  printf("Called yywrap\n");
  return 1;
}
main(){

  yyin=fopen("a.c","r");
  yyparse();
  
  return 0;
}