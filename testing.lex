%{
#include <stdio.h>

#include <stdlib.h>
void calcIndentation(int* indentStack, int* indexTop, int len);
%}
%option noyywrap
%option never-interactive
%option yylineno
%x ONECOMMENT
%x STRING
%x DOUBLELONGSTRING
%x LONGSTRING
%x HEXDECIMAL
%x HEXDECIMALC
%x HEXDECIMALCC
%x HEXDECIMALCCC
%x STRINGS
%%

%{
	int indexTop = 0;
	int indentStack[1000];
	indentStack[0] = 0;
	char buffer[1000];
	char hex[3];
	int parenthesesOpenCount = 0;
	int squarebracketsOpenCount = 0;
	int curlybracesOpenCount = 0;
	int isLogicalString = 0;
%}

^\s*\n			printf("EMPTYSTRING\n");

#	{buffer[0] = 0; BEGIN(ONECOMMENT);}
<ONECOMMENT>[^\\\n]+ strcat(buffer, yytext);
<ONECOMMENT>[\\\n]	{printf("COMMENT : %s\n", buffer); BEGIN(INITIAL);}

\"\"\"													{BEGIN(DOUBLELONGSTRING);}
<DOUBLELONGSTRING>\\n											strcat(buffer,"\n");
<DOUBLELONGSTRING,STRING,LONGSTRING>\\\"						strcat(buffer,"\"");
<DOUBLELONGSTRING,LONGSTRING,STRING,STRINGS>\\\\				strcat(buffer,"\\");
<DOUBLELONGSTRING,LONGSTRING,STRING,STRINGS>\\\'				strcat(buffer,"\'");
<DOUBLELONGSTRING,STRING,LONGSTRING>\'							strcat(buffer,"\'");
<DOUBLELONGSTRING,STRINGS,LONGSTRING>\"							strcat(buffer,"\"");
<DOUBLELONGSTRING,LONGSTRING,STRING,STRINGS>\\newline
<DOUBLELONGSTRING,LONGSTRING,STRING,STRINGS>\\a					strcat(buffer,"\a");
<DOUBLELONGSTRING,LONGSTRING,STRING,STRINGS>\\b					strcat(buffer,"\b");
<DOUBLELONGSTRING,LONGSTRING,STRING,STRINGS>\\f					strcat(buffer,"\f");
<DOUBLELONGSTRING,LONGSTRING,STRING,STRINGS>\\r					strcat(buffer,"\r");
<DOUBLELONGSTRING,LONGSTRING,STRING,STRINGS>\\t					strcat(buffer,"\t");
<DOUBLELONGSTRING,LONGSTRING,STRING,STRINGS>\\v					strcat(buffer,"\v");
<DOUBLELONGSTRING,LONGSTRING,STRING,STRINGS>\\x([0-9a-fA-F]){2}	{
																	hex[0] = strtol(yytext + 2,0,16);
																	hex[1] = 0;
																	strcat(buffer,hex);
																}
<DOUBLELONGSTRING,LONGSTRING,STRING,STRINGS>[^\"\\\n\'\a\b\f\r\t\v\x]+		strcat(buffer,yytext);
<DOUBLELONGSTRING>\"\"\" 		{printf("LONGSTRING literal: %s\n",buffer); BEGIN(INITIAL);}

\'{3}									{BEGIN(LONGSTRING);}
<LONGSTRING>\\n							strcat(buffer,"\n");
<LONGSTRING,STRINGS>\\\'				strcat(buffer,"\'");
<LONGSTRING>\'\'\' 						{printf("LONGSTRING literal: %s\n",buffer); BEGIN(INITIAL);}

^[ ]+		{
				if( !(isLogicalString || parenthesesOpenCount || squarebracketsOpenCount || curlybracesOpenCount))
					calcIndentation(indentStack, &indexTop, strlen(yytext));
			}
^[\t]+		{
				if( !(isLogicalString || parenthesesOpenCount || squarebracketsOpenCount || curlybracesOpenCount))
					calcIndentation(indentStack, &indexTop, strlen(yytext)*4);
			}
			
^[ \t]{2,}	{
				if( !(isLogicalString || parenthesesOpenCount || squarebracketsOpenCount || curlybracesOpenCount))
					printf("Error mixing tab and spacers\n");
			}

\"						{BEGIN(STRING);buffer[0] = 0;}
<STRING,STRINGS>\n		{printf("Error in string %d - String literal not closed",yylineno);BEGIN(INITIAL);}
<STRING>\" 				{printf("String literal %s\n",buffer); BEGIN(INITIAL);}

\'					{BEGIN(STRINGS);buffer[0] = 0;}
<STRINGS>\' 		{printf("String literal %s\n",buffer); BEGIN(INITIAL);}

False    	printf("Keyword : %s\n", yytext);
if     	 	printf("Keyword : %s\n", yytext);
import     	printf("Keyword : %s\n", yytext);
from     	printf("Keyword : %s\n", yytext);
in     		printf("Keyword : %s\n", yytext);
is     		printf("Keyword : %s\n", yytext);
as     		printf("Keyword : %s\n", yytext);
lambda     	printf("Keyword : %s\n", yytext);
not     	printf("Keyword : %s\n", yytext);
or     		printf("Keyword : %s\n", yytext);
pass     	printf("Keyword : %s\n", yytext);
raise     	printf("Keyword : %s\n", yytext);
return     	printf("Keyword : %s\n", yytext);
try     	printf("Keyword : %s\n", yytext);
while     	printf("Keyword : %s\n", yytext);
with     	printf("Keyword : %s\n", yytext);
None     	printf("Keyword : %s\n", yytext);
True     	printf("Keyword : %s\n", yytext);
and     	printf("Keyword : %s\n", yytext);
assert     	printf("Keyword : %s\n", yytext);
break     	printf("Keyword : %s\n", yytext);
class     	printf("Keyword : %s\n", yytext);
continue    printf("Keyword : %s\n", yytext);
def     	printf("Keyword : %s\n", yytext);
elif     	printf("Keyword : %s\n", yytext);
else     	printf("Keyword : %s\n", yytext);
except     	printf("Keyword : %s\n", yytext);
finally     printf("Keyword : %s\n", yytext);
\+    		printf("Oper : %s\n", yytext);
-     		printf("Oper : %s\n", yytext);
\*     		printf("Oper : %s\n", yytext);
\*\*     	printf("Oper : %s\n", yytext);
\/     		printf("Oper : %s\n", yytext);
\/\/     	printf("Oper : %s\n", yytext);
\%    		printf("Oper : %s\n", yytext);
@     		printf("Oper : %s\n", yytext);
\<\<     	printf("Oper : %s\n", yytext);
>>     		printf("Oper : %s\n", yytext);
&   		printf("Oper : %s\n", yytext);
\|     		printf("Oper : %s\n", yytext);
\^    		printf("Oper : %s\n", yytext);
~     		printf("Oper : %s\n", yytext);
>     		printf("Oper : %s\n", yytext);
\<     		printf("Oper : %s\n", yytext);
\<=     	printf("Oper : %s\n", yytext);
\>=     	printf("Oper : %s\n", yytext);
==    		printf("Oper : %s\n", yytext);
!=     		printf("Oper : %s\n", yytext);
\(     		{printf("Oper : %s\n", yytext); parenthesesOpenCount++;}
\)     		{printf("Oper : %s\n", yytext); parenthesesOpenCount--;}
\[     		{printf("Oper : %s\n", yytext); squarebracketsOpenCount++;}
\]     		{printf("Oper : %s\n", yytext); squarebracketsOpenCount--;}
\{    		{printf("Oper : %s\n", yytext); curlybracesOpenCount++;}
\}     		{printf("Oper : %s\n", yytext); curlybracesOpenCount--;}
,     		printf("Oper : %s\n", yytext);
:     		printf("Oper : %s\n", yytext);
\.     		printf("Oper : %s\n", yytext);
\;     		printf("Oper : %s\n", yytext);
\=    		printf("Oper : %s\n", yytext);
->     		printf("Oper : %s\n", yytext);
\+=     	printf("Oper : %s\n", yytext);
-=     		printf("Oper : %s\n", yytext);
\*=     	printf("Oper : %s\n", yytext);
\/=     	printf("Oper : %s\n", yytext);
\/\/=    	printf("Oper : %s\n", yytext);
%=     		printf("Oper : %s\n", yytext);
@=     		printf("Oper : %s\n", yytext);
\&=     	printf("Oper : %s\n", yytext);
\|=     	printf("Oper : %s\n", yytext);
\^=     	printf("Oper : %s\n", yytext);
>>=     	printf("Oper : %s\n", yytext);
\<\<=   	printf("Oper : %s\n", yytext);
\*\*=     	printf("Oper : %s\n", yytext);

[0-9]*([0-9]\.|\.[0-9])[0-9]* printf("Float : %f\n", atof(yytext));
[0-9]+ 		printf("Number : %d\n", atoi(yytext));
[A-Za-z_][A-Za-z0-9_]*	printf("Identifier : %s\n", yytext);

\\\s*\n		{printf("BACKSLASH CONCATINATE FISICAL STRINGS TO LOGICAL STRING\n"); isLogicalString = 1;}
\n 			{
				if( parenthesesOpenCount == 0 && squarebracketsOpenCount == 0 && curlybracesOpenCount == 0)
				{
					printf("NEWLINE\n");
					isLogicalString = 0;
				}
			}
%%

void calcIndentation(int* indentStack, int* indexTop, int len)
{
	if( len > indentStack[*indexTop] )
	{
		(*indexTop)++;
		indentStack[*indexTop] = len;
		printf("INDENT : %d\n", len);
	}
	else if( len < indentStack[*indexTop])
	{
		int dedentCount = *indexTop;
		while(len < indentStack[dedentCount])
			dedentCount--;
			
		if (len != indentStack[dedentCount])
			printf("Error: inconsistent dedent %d\n", len);
		else
		{
			while(*indexTop > dedentCount)
			{
				printf("DEDENT : %d\n", indentStack[*indexTop]);
				(*indexTop)--;
			}
		}
	}		
}

