#pragma once

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* remove_underscores(char* str);


int yy_parse_int(char* string_num, char char_base=0)
{
	int base;
	switch(char_base)
	{
		case 'b':
		case 'B':
			base = 2;
			break;
		case 'c':
		case 'C':
			base = 8;
			break;
		case 'x':
		case 'X':
			base = 16;
			break;
		default:
			base = 10;
	}

	if(base != 10)
	{
		int index_letter = (string_num[0] == '-')? 2 : 1;
		string_num[index_letter] = '0';
	}
	
	remove_underscores(string_num);

	int x = strtol(string_num,NULL, base);
	return x;
} 

double yy_parse_real(char* string_num)
{
	return atof (string_num);
}



char append_special_char_by_hexcode(char* buf, char* code_seq)
{
	//  \x[0-9a-fA-F]{2}	
	int c = strtol( code_seq+2 ,NULL, 16);
	char ch = c;

	int len = strlen(buf);
	buf[len] = ch;
	buf[len+1] = 0;

	return ch;
}
char append_special_char_by_octcode(char* buf, char* code_seq)
{
	// \[0-7]{3}
	int c = strtol( code_seq+1 ,NULL, 8);//
	char ch = c;

	int len = strlen(buf);
	buf[len] = ch;
	buf[len+1] = 0;

	return ch;
}

char* remove_underscores(char* str)
{
	char* p;
	while(p = strchr(str, '_'))
	{
		// shift remainig part left
		for(char* i = p+1; i < str+strlen(str); i++)
		{
			*(i-1) = *i;
		}
		// truncate last char
		str[strlen(str)-1] = 0;
		// or: *i = 0
	}
	
	return str;
}