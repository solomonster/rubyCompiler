%{
	#include <math.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <conio.h>
	#include <locale.h> 
	
	#include "lexHelper.h"
	
	
%}


%option noyywrap
%option never-interactive
%option yylineno

%x SINGLE_LINE_COMMENT
%x MULTI_LINE_COMMENT
%x DOUBLE_QUOTED_STRING
%x SINGLE_QUOTED_STRING


TRUE                true
FALSE               false
BASE_10 			[1-9][0-9]*|0
BASE_16 			0[xX][0-9a-fA-F]+
BASE_8 				0[0-7]+
BASE_2 				0b[01]+

IDENTIFIER  [_a-zA-Z][_a-zA-Z0-9]*
NUM          	[0-9]+
FLOAT          	([0-9]*[\.]{NUM})|({NUM}[\.][0-9]*)
EXPONENT	 	(({NUM}|{FLOAT})[eE][+-]?{NUM})	                     


%%
%{
	int startLine=0;
	char literal[1000];
%}



\"									{ BEGIN(DOUBLE_QUOTED_STRING); literal[0] = '\0'; startLine=yylineno; }
<DOUBLE_QUOTED_STRING>[^\"\\]+		{ strcat(literal, yytext);}
<DOUBLE_QUOTED_STRING>\\a           {strcat(literal,"\a");} 
<DOUBLE_QUOTED_STRING>\\b           {strcat(literal,"\b");} 
<DOUBLE_QUOTED_STRING>\\t           {strcat(literal,"\t");} 
<DOUBLE_QUOTED_STRING>\\n           {strcat(literal,"\n");} 
<DOUBLE_QUOTED_STRING>\\\"           {strcat(literal,"\"");}
<DOUBLE_QUOTED_STRING>\\e           {strcat(literal,"\e");} 
<DOUBLE_QUOTED_STRING>\\f           {strcat(literal,"\f");} 
<DOUBLE_QUOTED_STRING>\\[0-7]{3}      { append_special_char_by_octcode(literal, yytext);}
<DOUBLE_QUOTED_STRING>\\r           {strcat(literal,"\r");} 
<DOUBLE_QUOTED_STRING>\\s           {strcat(literal,"\s");} 
<DOUBLE_QUOTED_STRING>\\v           {strcat(literal,"\v");} 
<DOUBLE_QUOTED_STRING>\\x[0-9a-fA-F]{2}   { append_special_char_by_hexcode(literal, yytext);}     
<DOUBLE_QUOTED_STRING>\"	{ 
                                  yylval.String = (char *)malloc(strlen(literal) + 1);
                                  strcpy(yylval.String, literal);
                                  BEGIN(INITIAL);
                                  return STRING;
                              }




\'                          {BEGIN(SINGLE_QUOTED_STRING); literal[0] ='\0'; startLine=yylineno;}
<SINGLE_QUOTED_STRING>[^\\']  {strcat(literal,yytext);}
<SINGLE_QUOTED_STRING>\\'    {strcat(literal,"\'");}
<SINGLE_QUOTED_STRING>\\\\  {strcat(literal,"\\");}
<SINGLE_QUOTED_STRING>\'     { 
                                  yylval.String = (char *)malloc(strlen(literal) + 1);
                                  strcpy(yylval.String, literal);
                                  BEGIN(INITIAL);
                                  return STRING;
                              }



"#"                          {BEGIN(SINGLE_LINE_COMMENT);}
<SINGLE_LINE_COMMENT>[^\n]   /*empty*/ 
<SINGLE_LINE_COMMENT>[\n]     {BEGIN(INITIAL);}

^=begin(.|\n)*\n=end	{ printf("Found a multipleline comment\n");}


"if"   		{return IF;}
"else"		{{return ELSE;}
"elseif"    {return ELSEIF;}
"do"    	{return DO;}
"while"  	{return WHILE;}
"for" 		{return FOR;}
"return" 	{return RETURN;}
"then"      {return THEN;}
"end"       {return END;}
"begin"     {return BEGIN;}
"def"       {return DEF;}
"break"     {return BREAK;}
"when"      {return WHEN;}
"case"      {return CASE;}

"+" 		{ return PLUS;}
"-" 		{ return MINUS;}
"*" 		{ return MULTI;}
"/" 		{ return DIVIDE;}


= 		{return ASSIGN;}


== 		{return tEQ;}
> 		{return tG;}
\< 		{return LESS_THAN;}
\<= 	{return tLE;}
>= 		{return tGE;}
!= 		{return tNE;}

  


\&\&  {return tANDOP;}
\|\|  {return tOROP;}
\!    {return tNOT;}





"(" 					{ return tLPAREN ;}
")" 					{ return tRPAREN; }
"{" 					{ return tLBRACE; }
"}" 					{ return tRBACE; }
"[" 					{ return tLBRACKET; }
"]" 					{ return tRBRACKET; }
"." 					{ return tDOT; }
"," 					{ return tCOMMA; }
"?" 					{ return tQUESTION;}
":"                      {return tCOLON;}
".."                    {return tDOT2;}
"..."                   {return tDOT3;}

{TRUE} { yylval.Bool = true; return BOOL_VAL;}
{FALSE} { yylval.Bool = true; return BOOL_VAL;}
 
{IDENTIFIER} {      yylval.Id = (char *)malloc(sizeof(yytext)+1);
                    strcpy(yylval.Id,yytext);
                    return IDENTIFIER;
}


{BASE_10}					{ yylval.Int = yy_parse_int(yytext); return INT_VAL;}
{BASE_16}					{ yylval.Int = yy_parse_int(yytext, 'x'); return INT_VAL;}
{BASE_8}						{ yylval.Int = yy_parse_int(yytext, 'c'); return INT_VAL;}
{BASE_2}						{ yylval.Int = yy_parse_int(yytext, 'b'); return INT_VAL;}


\n  {return ENDL;}
\t  {}

%%