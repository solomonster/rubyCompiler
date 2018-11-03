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


BASE_10 			[1-9][0-9]*|0
BASE_16 			0[xX][0-9a-fA-F]+
BASE_8 				0[0-7]+
BASE_2 				0b[01]+

BOOLEAN			true|false
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
<DOUBLE_QUOTED_STRING>[^\"]+		{ strcat(literal, yytext);}
<DOUBLE_QUOTED_STRING>\\a           {strcat(literal,"\a");} 
<DOUBLE_QUOTED_STRING>\\b           {strcat(literal,"\b");} 
<DOUBLE_QUOTED_STRING>\\t           {strcat(literal,"\t");} 
<DOUBLE_QUOTED_STRING>\\n           {strcat(literal,"\n");} 
<DOUBLE_QUOTED_STRING>\\e           {strcat(literal,"\e");} 
<DOUBLE_QUOTED_STRING>\\f           {strcat(literal,"\f");} 
<DOUBLE_QUOTED_STRING>\\[0-7]{3}      { append_special_char_by_octcode(literal, yytext);}
<DOUBLE_QUOTED_STRING>\\r           {strcat(literal,"\r");} 
<DOUBLE_QUOTED_STRING>\\s           {strcat(literal,"\s");} 
<DOUBLE_QUOTED_STRING>\\v           {strcat(literal,"\v");} 
<DOUBLE_QUOTED_STRING>\\x[0-9a-fA-F]{2}   { append_special_char_by_hexcode(literal, yytext);}     
<DOUBLE_QUOTED_STRING>\"			{ printf("Found double quoted literal \"%s\". From line %d to line %d\n", literal, startLine, yylineno); BEGIN(INITIAL);}


\'                         {BEGIN(SINGLE_QUOTED_STRING); literal[0] ='\0'; startLine=yylineno;}
<SINGLE_QUOTED_STRING>[^\\']  {strcat(literal,yytext);}
<SINGLE_QUOTED_STRING>\\'    {strcat(literal,"\'");}
<SINGLE_QUOTED_STRING>\\\\  {strcat(literal,"\\");}
<SINGLE_QUOTED_STRING>\'  {printf("Found double quoted literal \"%s\". From line %d to line %d\n", literal, startLine, yylineno); BEGIN(INITIAL);}


"#"                          {BEGIN(SINGLE_LINE_COMMENT);}
<SINGLE_LINE_COMMENT>[^\n]   /*empty*/ 
<SINGLE_LINE_COMMENT>[\n]     {BEGIN(INITIAL); printf("Found a single line comment in line %d\n",yylineno);}

^=begin(.|\n)*\n=end	{ printf("Found a multipleline comment\n");}


"if"   		{printf("Found Keyword :\"%s\" in line %d\n", "IF",yylineno);}
"else"		 {printf("Found Keyword :\"%s\" in line %d\n", "ELSE",yylineno);}
"elseif" 	{printf("Found Keyword :\"%s\" in line %d\n", "ELSEIF",yylineno);}
"do"    	 {printf("Found Keyword :\"%s\" in line %d\n", "DO",yylineno);}
"while"  	{printf("Found Keyword :\"%s\" in line %d\n", "WHILE",yylineno);}
"for" 		{printf("Found Keyword :\"%s\" in line %d\n", "FOR",yylineno);}
"return" 	{printf("Found Keyword :\"%s\" in line %d\n", "RETURN",yylineno);}
"puts"  	{printf("Found Keyword :\"%s\" in line %d\n", "PUTS",yylineno);}
"class"  	{printf("Found Keyword :\"%s\" in line %d\n", "CLASS",yylineno);}
"gets"      {printf("Found Keyword :\"%s\" in line %d\n", "GETS",yylineno);}
"in"       {printf("Found Keyword :\"%s\" in line %d\n", "IN",yylineno);}
"then"    {printf("Found Keyword :\"%s\" in line %d\n", "THEN",yylineno);}
"end"    {printf("Found Keyword :\"%s\" in line %d\n", "END",yylineno);}
"begin"   {printf("Found Keyword :\"%s\" in line %d\n", "BEGIN",yylineno);}
"def"       {printf("Found Keyword :\"%s\" in line %d\n", "DEF",yylineno);}
"break"      {printf("Found Keyword :\"%s\" in line %d\n", "BREAK",yylineno);}

\+ 		{printf("Found arithmetic operator :\"%s\" in line %d\n", yytext,yylineno);}
\- 		{printf("Found arithmetic operator :\"%s\" in line %d\n", yytext,yylineno);}
\* 		{printf("Found arithmetic operator :\"%s\" in line %d\n", yytext,yylineno);}
\/ 		{printf("Found arithmetic operator :\"%s\" in line %d\n", yytext,yylineno);}


= 		{printf("Found assignment operator :\"%s\" in line %d\n", yytext,yylineno);}
\+= 	{printf("Found assignment operator :\"%s\" in line %d\n", yytext,yylineno);}
-= 		{printf("Found assignment operator :\"%s\" in line %d\n", yytext,yylineno);}
\*= 	{printf("Found assignment operator :\"%s\" in line %d\n", yytext,yylineno);}
\/= 	{printf("Found assignment operator :\"%s\" in line %d\n", yytext,yylineno);}


== 		{printf("Found relational operator : \"%s\" in line %d\n", yytext,yylineno);}
> 		{printf("Found relational operator : \"%s\" in line %d\n", "GREAT_THAN",yylineno);}
\< 		{printf("Found relational operator : \"%s\" in line %d\n", "LESS_THAN",yylineno);}
\<= 	{printf("Found relational operator : \"%s\" in line %d\n", "LESS_THAN_OR_EQUAL_TO",yylineno);}
>= 		{printf("Found relational operator : \"%s\" in line %d\n","GREATER_THAN_OR_EQUAL_TO",yylineno);}
!= 		{printf("Found relational operator : \"%s\" in line %d\n", "NOT_EQUAL_TO",yylineno);}

  


\&\&  {printf("Found Logical AND operator : \"%s\" in line %d\n", "AND",yylineno);}
\|\|  {printf("Found Logical OR operator : \"%s\" in line %d\n", "OR",yylineno);}
\!    {printf("Found Logical NOT operator: \"%s\" in line %d\n", "NOT",yylineno);}





"(" 					{ printf("Found open round bracket symbol \"%s\" in line %d\n", yytext,yylineno); }
")" 					{ printf("Found closed round bracket symbol \"%s\" in line %d\n", yytext,yylineno); }
"{" 					{ printf("Found open brace symbol \"%s\" in line %d\n", yytext,yylineno); }
"}" 					{ printf("Found closed brace symbol \"%s\" in line %d\n", yytext,yylineno); }
"[" 					{ printf("Found open square bracket symbol \"%s\" in line %d\n", yytext,yylineno); }
"]" 					{ printf("Found closed square bracket symbol \"%s\" in line %d\n", yytext,yylineno); }
":" 					{ printf("Found symbol \"%s\" in line %d\n", yytext,yylineno); }
"." 					{ printf("Found symbol \"%s\" in line %d\n", yytext,yylineno); }
"," 					{ printf("Found symbol \"%s\" in line %d\n", yytext,yylineno); }
"?" 					{ printf("Found symbol \"%s\" in line %d\n", yytext,yylineno); }
"$" 					{ printf("Found symbol \"%s\" in line %d\n", yytext,yylineno); }
"@"                     { printf("Found symbol \"%s\" in line %d\n", yytext,yylineno);}

{BOOLEAN}  {printf("Found boolean : \"%s\" in line %d\n", yytext,yylineno);}
{IDENTIFIER} {printf("Found an identifier: \"%s\" in line %d\n", yytext,yylineno);}
{BASE_10}					{ printf("Found int value \"%d\" in line %d\n", yy_parse_int(yytext),yylineno);}
{BASE_16}					{ printf("Found int value \"%d\" in line %d\n", yy_parse_int(yytext, 'x'),yylineno);}
{BASE_8}						{ printf("Found int value \"%d\" in line %d\n", yy_parse_int(yytext, 'c'),yylineno);}
{BASE_2}						{ printf("Found int value \"%d\" in line %d\n", yy_parse_int(yytext, 'b'),yylineno);}
{NUM}		{printf("Found an integer : \"%d\" in line %d\n",atoi(yytext),yylineno);}
{FLOAT}  {printf("Found a floating point constant: \"%f\" in line %d\n", atof(yytext),yylineno);}
{EXPONENT}  {printf("Found a floating point : \"%f\" in line %d\n", atof(yytext),yylineno);}

\n  {}
\t  {}

%%