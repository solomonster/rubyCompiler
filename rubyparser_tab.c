
/*  A Bison parser, made from rubyparser.y with Bison version GNU Bison version 1.24
  */

#define YYBISON 1  /* Identify Bison output.  */

#define	INT_LITERAL	258
#define	STRING_LITERAL	259
#define	IDENTIFIER	260
#define	INTEGER	261
#define	STRING	262
#define	RETURN	263
#define	DEF	264
#define	WHILE	265
#define	AND	266
#define	NOT	267
#define	ELIF	268
#define	IF	269
#define	OR	270
#define	ELSE	271
#define	TRUEDIV	272
#define	EG	273
#define	EL	274
#define	EQ	275
#define	NEQ	276
#define	ENDL	277
#define	DO	278
#define	END	279
#define	THEN	280
#define	ELSIF	281
#define	tCMP	282
#define	tEQ	283
#define	tEQQ	284
#define	tNEQ	285
#define	tMATCH	286
#define	tNMATCH	287
#define	tGEQ	288
#define	tLEQ	289
#define	UMINUS	290
#define	UPLUS	291

#line 9 "rubyparser.y"
 
/* Пролог содержит код на языке Си, который должен быть помещен в
начале файла с синтаксическим анализатором. Обычно это подключение
заголовочных файлов (например для используемых стандартных библио-
тек), а также объявление внешних (external) переменных для связи с лекси-
ческим анализатором и остальной программой.
*/

 #include "tree_nodes.h"
	#include <stdlib.h>
	#include <stdio.h>
	#include <string.h>
	#include <conio.h>
	#include <malloc.h>
	
	extern int yylex(void);
	
	void yyerror(char const *s);
	
	Expression *createSimpleExpression(EXPR_TYPE type, value val);
	Expression *createExpressionWithList(EXPR_TYPE type, value val, ExpressionList *exprList);
	Expression *createExpression(EXPR_TYPE type, Expression *left, Expression *right);

	ExpressionList *appendExpressionToList(ExpressionList *list, Expression *expr);
	ExpressionList *createExpressionList(Expression *expr);

	WhileStatement *createWhile(Expression *condition, StatementList *whileBlock);
	

	StatementList *appendStatementToList(StatementList *list, Statement *stmt);
	StatementList *createStatementList(Statement *stmt);
	IfStatement *createIf(Expression *condition, StatementList *stmtList, ElseIfStatementList *elseIfStmtList, ElseStatement *elseStmt);
	ElseStatement *createElse(StatementList *stmtList);
	ElseIfStatement *createElseIf(Expression *condition, StatementList *stmtList);
	ElseIfStatementList *createElseIfStatementList(ElseIfStatement *stmt);
	ElseIfStatementList *appendElseIfToList(ElseIfStatementList *list, ElseIfStatement *stmt);
	Statement *createStatement(STMT_TYPE type, stmtValue val);

	VariableList *createVariableList(char* id);
	VariableList *appendToVariableList(VariableList *list, char* id);
	

	
	Program *createProgram(char *identifier, ExpressionList *exprList, StatementList *stmtList);
	
	ProgramList *createProgramList(Program *prog);
	ProgramList *appentProgramToList(ProgramList *list, Program *prog);
		
	ProgramList *root;



#line 62 "rubyparser.y"
typedef union {
	
	int int_const;
    char *string_const;
	char *id_const;
	VAR_TYPE vt;
	
	Expression *expr;
	ExpressionList *exprList;
	Statement *stmt;
	StatementList *stmtList;
	WhileStatement *whileStmt;
	

	
	IfStatement *ifStmt;
	ElseStatement *elseStmt;
	ElseIfStatement *elseIfStmt;
	ElseIfStatementList *elseIfStmtList;
	VariableList *varList;

	Program *prog;
	ProgramList *progList;
} YYSTYPE;

#ifndef YYLTYPE
typedef
  struct yyltype
    {
      int timestamp;
      int first_line;
      int first_column;
      int last_line;
      int last_column;
      char *text;
   }
  yyltype;

#define YYLTYPE yyltype
#endif

#include <stdio.h>

#ifndef __cplusplus
#ifndef __STDC__
#define const
#endif
#endif



#define	YYFINAL		96
#define	YYFLAG		-32768
#define	YYNTBASE	51

#define YYTRANSLATE(x) ((unsigned)(x) <= 291 ? yytranslate[x] : 66)

static const char yytranslate[] = {     0,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,    43,     2,     2,     2,     2,     2,     2,    47,
    46,    40,    38,    50,    39,     2,    41,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,    49,    36,
    27,    34,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
    48,     2,    45,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     1,     2,     3,     4,     5,
     6,     7,     8,     9,    10,    11,    12,    13,    14,    15,
    16,    17,    18,    19,    20,    21,    22,    23,    24,    25,
    26,    28,    29,    30,    31,    32,    33,    35,    37,    42,
    44
};

#if YYDEBUG != 0
static const short yyprhs[] = {     0,
     0,     4,     8,    12,    16,    19,    22,    25,    29,    33,
    37,    41,    45,    49,    53,    58,    60,    62,    66,    70,
    74,    78,    83,    85,    87,    89,    91,    93,    95,    97,
    99,   101,   104,   107,   113,   121,   128,   129,   132,   137,
   139,   142,   146,   149,   151,   153,   157,   159,   163,   170,
   172,   175
};

static const short yyrhs[] = {    51,
    38,    51,     0,    51,    39,    51,     0,    51,    40,    51,
     0,    51,    41,    51,     0,    38,    51,     0,    39,    51,
     0,    12,    51,     0,    51,    36,    51,     0,    51,    34,
    51,     0,    51,    35,    51,     0,    51,    37,    51,     0,
    51,    29,    51,     0,    51,    31,    51,     0,    51,    27,
    51,     0,     5,    47,    62,    46,     0,     3,     0,     4,
     0,    51,    15,    51,     0,    51,    11,    51,     0,    51,
    48,    45,     0,    47,    51,    46,     0,    51,    48,    51,
    45,     0,     5,     0,     6,     0,     7,     0,    54,     0,
    55,     0,    56,     0,    60,     0,    61,     0,    52,     0,
    53,    52,     0,    51,    49,     0,    10,    51,    23,    53,
    24,     0,    14,    51,    25,    53,    59,    57,    24,     0,
    14,    51,    25,    53,    57,    24,     0,     0,    16,    53,
     0,    26,    51,    25,    53,     0,    58,     0,    59,    58,
     0,     8,    51,    49,     0,     8,    49,     0,    49,     0,
    51,     0,    62,    50,    51,     0,     5,     0,     0,    50,
     5,     0,     9,     5,    62,    22,    53,    24,     0,    63,
     0,    64,    63,     0,    64,     0
};

#endif

#if YYDEBUG != 0
static const short yyrline[] = { 0,
   154,   155,   156,   157,   160,   161,   163,   164,   165,   166,
   167,   168,   169,   170,   172,   174,   175,   177,   178,   180,
   181,   182,   184,   189,   190,   193,   194,   195,   196,   197,
   200,   201,   204,   208,   212,   213,   216,   217,   220,   223,
   224,   227,   228,   231,   234,   235,   238,   239,   244,   246,
   247,   250
};

static const char * const yytname[] = {   "$","error","$undefined.","INT_LITERAL",
"STRING_LITERAL","IDENTIFIER","INTEGER","STRING","RETURN","DEF","WHILE","AND",
"NOT","ELIF","IF","OR","ELSE","TRUEDIV","EG","EL","EQ","NEQ","ENDL","DO","END",
"THEN","ELSIF","'='","tCMP","tEQ","tEQQ","tNEQ","tMATCH","tNMATCH","'>'","tGEQ",
"'<'","tLEQ","'+'","'-'","'*'","'/'","UMINUS","'!'","UPLUS","']'","')'","'('",
"'['","';'","','","expression","statement","statement_list","expression_statement",
"while_statement","if_statement","else_statement","elsif_statement","elsif_statement_list",
"return_statement","empty_statement","expression_list","program_block","program_list",
"program","program_list"
};
#endif

static const short yyr1[] = {     0,
    51,    51,    51,    51,    51,    51,    51,    51,    51,    51,
    51,    51,    51,    51,    51,    51,    51,    51,    51,    51,
    51,    51,    51,    -1,    -1,    52,    52,    52,    52,    52,
    53,    53,    54,    55,    56,    56,    57,    57,    58,    59,
    59,    60,    60,    61,    62,    62,    -1,    -1,    63,    64,
    64,    65
};

static const short yyr2[] = {     0,
     3,     3,     3,     3,     2,     2,     2,     3,     3,     3,
     3,     3,     3,     3,     4,     1,     1,     3,     3,     3,
     3,     4,     1,     1,     1,     1,     1,     1,     1,     1,
     1,     2,     2,     5,     7,     6,     0,     2,     4,     1,
     2,     3,     2,     1,     1,     3,     1,     3,     6,     1,
     2,     1
};

static const short yydefact[] = {     0,
     0,    50,    52,     0,    51,    16,    17,    23,     0,     0,
     0,     0,    45,     0,     0,     7,     5,     6,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,    21,    19,    18,    14,
    12,    13,     9,    10,     8,    11,     1,     2,     3,     4,
    20,     0,     0,     0,     0,    44,     0,    31,     0,    26,
    27,    28,    29,    30,    46,    15,    22,    43,     0,     0,
     0,    33,    49,    32,    42,     0,     0,     0,    37,    34,
     0,     0,     0,    40,    37,    38,     0,    36,     0,    41,
     0,    35,    39,     0,     0,     0
};

static const short yydefgoto[] = {    57,
    58,    59,    60,    61,    62,    83,    84,    85,    63,    64,
    14,     2,     3,    94
};

static const short yypact[] = {     3,
     9,-32768,     3,    80,-32768,-32768,-32768,   -32,    80,    80,
    80,    80,   319,   -18,    80,   133,    -9,    -9,   179,    80,
    80,    80,    80,    80,    80,    80,    80,    80,    80,    80,
    80,    80,    77,   100,    80,   -37,-32768,   133,   133,   133,
   164,   164,   191,   191,   191,   191,   102,   102,    -9,    -9,
-32768,   211,    -2,    80,    80,-32768,   117,-32768,    49,-32768,
-32768,-32768,-32768,-32768,   319,-32768,-32768,-32768,   148,   242,
   273,-32768,-32768,-32768,-32768,   100,   100,    62,    30,-32768,
   100,    80,     6,-32768,    32,   100,   304,-32768,    17,-32768,
   100,-32768,   100,    43,    55,-32768
};

static const short yypgoto[] = {    -4,
    47,    54,-32768,-32768,-32768,   -25,   -23,-32768,-32768,-32768,
    56,    61,-32768,-32768
};


#define	YYLAST		367


static const short yytable[] = {    13,
     6,     7,     8,    34,    16,    17,    18,    19,    66,     9,
    13,     1,    35,     4,    15,    38,    39,    40,    41,    42,
    43,    44,    45,    46,    47,    48,    49,    50,    52,    88,
    65,    35,     6,     7,     8,    10,    11,    53,    33,    54,
    92,     9,    95,    55,    12,    81,    68,    81,    69,    70,
    71,     6,     7,     8,    96,    82,    53,    82,    54,    89,
     9,    90,    55,     5,     6,     7,     8,    10,    11,    53,
    36,    54,    73,     9,     0,    55,    12,    87,    56,     6,
     7,     8,     6,     7,     8,    80,    10,    11,     9,     0,
     0,     9,     0,     0,     0,    12,     0,    56,     0,    10,
    11,     0,     6,     7,     8,    74,     0,    53,    12,    54,
    56,     9,     0,    55,    10,    11,     0,    10,    11,     0,
     0,    51,     0,    12,    74,    74,    12,    20,     0,    78,
    79,    21,    74,     0,    86,     0,     0,    10,    11,    74,
     0,    31,    32,    22,    93,    23,    12,    24,    56,    33,
    25,    26,    27,    28,    29,    30,    31,    32,    20,    22,
     0,    23,    21,    24,    33,    72,    25,    26,    27,    28,
    29,    30,    31,    32,    22,     0,    23,     0,    24,     0,
    33,    25,    26,    27,    28,    29,    30,    31,    32,    20,
     0,     0,-32768,    21,-32768,    33,    75,    25,    26,    27,
    28,    29,    30,    31,    32,    22,     0,    23,     0,    24,
     0,    33,    25,    26,    27,    28,    29,    30,    31,    32,
     0,    20,     0,     0,    37,    21,    33,     0,    29,    30,
    31,    32,     0,     0,     0,     0,     0,    22,    33,    23,
     0,    24,     0,     0,    25,    26,    27,    28,    29,    30,
    31,    32,    20,     0,     0,    67,    21,     0,    33,     0,
     0,     0,     0,     0,    76,     0,     0,     0,    22,     0,
    23,     0,    24,     0,     0,    25,    26,    27,    28,    29,
    30,    31,    32,    20,     0,     0,     0,    21,     0,    33,
     0,     0,     0,     0,     0,     0,     0,    77,     0,    22,
     0,    23,     0,    24,     0,     0,    25,    26,    27,    28,
    29,    30,    31,    32,    20,     0,     0,     0,    21,     0,
    33,     0,     0,     0,     0,     0,     0,     0,    91,    20,
    22,     0,    23,    21,    24,     0,     0,    25,    26,    27,
    28,    29,    30,    31,    32,    22,     0,    23,     0,    24,
     0,    33,    25,    26,    27,    28,    29,    30,    31,    32,
     0,     0,     0,     0,     0,     0,    33
};

static const short yycheck[] = {     4,
     3,     4,     5,    22,     9,    10,    11,    12,    46,    12,
    15,     9,    50,     5,    47,    20,    21,    22,    23,    24,
    25,    26,    27,    28,    29,    30,    31,    32,    33,    24,
    35,    50,     3,     4,     5,    38,    39,     8,    48,    10,
    24,    12,     0,    14,    47,    16,    49,    16,    53,    54,
    55,     3,     4,     5,     0,    26,     8,    26,    10,    85,
    12,    85,    14,     3,     3,     4,     5,    38,    39,     8,
    15,    10,    24,    12,    -1,    14,    47,    82,    49,     3,
     4,     5,     3,     4,     5,    24,    38,    39,    12,    -1,
    -1,    12,    -1,    -1,    -1,    47,    -1,    49,    -1,    38,
    39,    -1,     3,     4,     5,    59,    -1,     8,    47,    10,
    49,    12,    -1,    14,    38,    39,    -1,    38,    39,    -1,
    -1,    45,    -1,    47,    78,    79,    47,    11,    -1,    76,
    77,    15,    86,    -1,    81,    -1,    -1,    38,    39,    93,
    -1,    40,    41,    27,    91,    29,    47,    31,    49,    48,
    34,    35,    36,    37,    38,    39,    40,    41,    11,    27,
    -1,    29,    15,    31,    48,    49,    34,    35,    36,    37,
    38,    39,    40,    41,    27,    -1,    29,    -1,    31,    -1,
    48,    34,    35,    36,    37,    38,    39,    40,    41,    11,
    -1,    -1,    29,    15,    31,    48,    49,    34,    35,    36,
    37,    38,    39,    40,    41,    27,    -1,    29,    -1,    31,
    -1,    48,    34,    35,    36,    37,    38,    39,    40,    41,
    -1,    11,    -1,    -1,    46,    15,    48,    -1,    38,    39,
    40,    41,    -1,    -1,    -1,    -1,    -1,    27,    48,    29,
    -1,    31,    -1,    -1,    34,    35,    36,    37,    38,    39,
    40,    41,    11,    -1,    -1,    45,    15,    -1,    48,    -1,
    -1,    -1,    -1,    -1,    23,    -1,    -1,    -1,    27,    -1,
    29,    -1,    31,    -1,    -1,    34,    35,    36,    37,    38,
    39,    40,    41,    11,    -1,    -1,    -1,    15,    -1,    48,
    -1,    -1,    -1,    -1,    -1,    -1,    -1,    25,    -1,    27,
    -1,    29,    -1,    31,    -1,    -1,    34,    35,    36,    37,
    38,    39,    40,    41,    11,    -1,    -1,    -1,    15,    -1,
    48,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    25,    11,
    27,    -1,    29,    15,    31,    -1,    -1,    34,    35,    36,
    37,    38,    39,    40,    41,    27,    -1,    29,    -1,    31,
    -1,    48,    34,    35,    36,    37,    38,    39,    40,    41,
    -1,    -1,    -1,    -1,    -1,    -1,    48
};
/* -*-C-*-  Note some compilers choke on comments on `#line' lines.  */
#line 3 "bison.simple"

/* Skeleton output parser for bison,
   Copyright (C) 1984, 1989, 1990 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

#ifndef alloca
#ifdef __GNUC__
#define alloca __builtin_alloca
#else /* not GNU C.  */
#if (!defined (__STDC__) && defined (sparc)) || defined (__sparc__) || defined (__sparc) || defined (__sgi)
#include <alloca.h>
#else /* not sparc */
#if defined (MSDOS) && !defined (__TURBOC__)
#include <malloc.h>
#else /* not MSDOS, or __TURBOC__ */
#if defined(_AIX)
#include <malloc.h>
 #pragma alloca
#else /* not MSDOS, __TURBOC__, or _AIX */
#ifdef __hpux
#ifdef __cplusplus
extern "C" {
void *alloca (unsigned int);
};
#else /* not __cplusplus */
void *alloca ();
#endif /* not __cplusplus */
#endif /* __hpux */
#endif /* not _AIX */
#endif /* not MSDOS, or __TURBOC__ */
#endif /* not sparc.  */
#endif /* not GNU C.  */
#endif /* alloca not defined.  */

/* This is the parser code that is written into each bison parser
  when the %semantic_parser declaration is not specified in the grammar.
  It was written by Richard Stallman by simplifying the hairy parser
  used when %semantic_parser is specified.  */

/* Note: there must be only one dollar sign in this file.
   It is replaced by the list of actions, each action
   as one case of the switch.  */

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		-2
#define YYEOF		0
#define YYACCEPT	return(0)
#define YYABORT 	return(1)
#define YYERROR		goto yyerrlab1
/* Like YYERROR except do call yyerror.
   This remains here temporarily to ease the
   transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */
#define YYFAIL		goto yyerrlab
#define YYRECOVERING()  (!!yyerrstatus)
#define YYBACKUP(token, value) \
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    { yychar = (token), yylval = (value);			\
      yychar1 = YYTRANSLATE (yychar);				\
      YYPOPSTACK;						\
      goto yybackup;						\
    }								\
  else								\
    { yyerror ("syntax error: cannot back up"); YYERROR; }	\
while (0)

#define YYTERROR	1
#define YYERRCODE	256

#ifndef YYPURE
#define YYLEX		yylex()
#endif

#ifdef YYPURE
#ifdef YYLSP_NEEDED
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, &yylloc, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval, &yylloc)
#endif
#else /* not YYLSP_NEEDED */
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval)
#endif
#endif /* not YYLSP_NEEDED */
#endif

/* If nonreentrant, generate the variables here */

#ifndef YYPURE

int	yychar;			/*  the lookahead symbol		*/
YYSTYPE	yylval;			/*  the semantic value of the		*/
				/*  lookahead symbol			*/

#ifdef YYLSP_NEEDED
YYLTYPE yylloc;			/*  location data for the lookahead	*/
				/*  symbol				*/
#endif

int yynerrs;			/*  number of parse errors so far       */
#endif  /* not YYPURE */

#if YYDEBUG != 0
int yydebug;			/*  nonzero means print parse trace	*/
/* Since this is uninitialized, it does not stop multiple parsers
   from coexisting.  */
#endif

/*  YYINITDEPTH indicates the initial size of the parser's stacks	*/

#ifndef	YYINITDEPTH
#define YYINITDEPTH 200
#endif

/*  YYMAXDEPTH is the maximum size the stacks can grow to
    (effective only if the built-in stack extension method is used).  */

#if YYMAXDEPTH == 0
#undef YYMAXDEPTH
#endif

#ifndef YYMAXDEPTH
#define YYMAXDEPTH 10000
#endif

/* Prevent warning if -Wstrict-prototypes.  */
#ifdef __GNUC__
int yyparse (void);
#endif

#if __GNUC__ > 1		/* GNU C and GNU C++ define this.  */
#define __yy_memcpy(FROM,TO,COUNT)	__builtin_memcpy(TO,FROM,COUNT)
#else				/* not GNU C or C++ */
#ifndef __cplusplus

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (from, to, count)
     char *from;
     char *to;
     int count;
{
  register char *f = from;
  register char *t = to;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#else /* __cplusplus */

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (char *from, char *to, int count)
{
  register char *f = from;
  register char *t = to;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#endif
#endif

#line 192 "bison.simple"

/* The user can define YYPARSE_PARAM as the name of an argument to be passed
   into yyparse.  The argument should have type void *.
   It should actually point to an object.
   Grammar actions can access the variable by casting it
   to the proper pointer type.  */

#ifdef YYPARSE_PARAM
#define YYPARSE_PARAM_DECL void *YYPARSE_PARAM;
#else
#define YYPARSE_PARAM
#define YYPARSE_PARAM_DECL
#endif

int
yyparse(YYPARSE_PARAM)
     YYPARSE_PARAM_DECL
{
  register int yystate;
  register int yyn;
  register short *yyssp;
  register YYSTYPE *yyvsp;
  int yyerrstatus;	/*  number of tokens to shift before error messages enabled */
  int yychar1 = 0;		/*  lookahead token as an internal (translated) token number */

  short	yyssa[YYINITDEPTH];	/*  the state stack			*/
  YYSTYPE yyvsa[YYINITDEPTH];	/*  the semantic value stack		*/

  short *yyss = yyssa;		/*  refer to the stacks thru separate pointers */
  YYSTYPE *yyvs = yyvsa;	/*  to allow yyoverflow to reallocate them elsewhere */

#ifdef YYLSP_NEEDED
  YYLTYPE yylsa[YYINITDEPTH];	/*  the location stack			*/
  YYLTYPE *yyls = yylsa;
  YYLTYPE *yylsp;

#define YYPOPSTACK   (yyvsp--, yyssp--, yylsp--)
#else
#define YYPOPSTACK   (yyvsp--, yyssp--)
#endif

  int yystacksize = YYINITDEPTH;

#ifdef YYPURE
  int yychar;
  YYSTYPE yylval;
  int yynerrs;
#ifdef YYLSP_NEEDED
  YYLTYPE yylloc;
#endif
#endif

  YYSTYPE yyval;		/*  the variable used to return		*/
				/*  semantic values from the action	*/
				/*  routines				*/

  int yylen;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Starting parse\n");
#endif

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss - 1;
  yyvsp = yyvs;
#ifdef YYLSP_NEEDED
  yylsp = yyls;
#endif

/* Push a new state, which is found in  yystate  .  */
/* In all cases, when you get here, the value and location stacks
   have just been pushed. so pushing a state here evens the stacks.  */
yynewstate:

  *++yyssp = yystate;

  if (yyssp >= yyss + yystacksize - 1)
    {
      /* Give user a chance to reallocate the stack */
      /* Use copies of these so that the &'s don't force the real ones into memory. */
      YYSTYPE *yyvs1 = yyvs;
      short *yyss1 = yyss;
#ifdef YYLSP_NEEDED
      YYLTYPE *yyls1 = yyls;
#endif

      /* Get the current used size of the three stacks, in elements.  */
      int size = yyssp - yyss + 1;

#ifdef yyoverflow
      /* Each stack pointer address is followed by the size of
	 the data in use in that stack, in bytes.  */
#ifdef YYLSP_NEEDED
      /* This used to be a conditional around just the two extra args,
	 but that might be undefined if yyoverflow is a macro.  */
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yyls1, size * sizeof (*yylsp),
		 &yystacksize);
#else
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yystacksize);
#endif

      yyss = yyss1; yyvs = yyvs1;
#ifdef YYLSP_NEEDED
      yyls = yyls1;
#endif
#else /* no yyoverflow */
      /* Extend the stack our own way.  */
      if (yystacksize >= YYMAXDEPTH)
	{
	  yyerror("parser stack overflow");
	  return 2;
	}
      yystacksize *= 2;
      if (yystacksize > YYMAXDEPTH)
	yystacksize = YYMAXDEPTH;
      yyss = (short *) alloca (yystacksize * sizeof (*yyssp));
      __yy_memcpy ((char *)yyss1, (char *)yyss, size * sizeof (*yyssp));
      yyvs = (YYSTYPE *) alloca (yystacksize * sizeof (*yyvsp));
      __yy_memcpy ((char *)yyvs1, (char *)yyvs, size * sizeof (*yyvsp));
#ifdef YYLSP_NEEDED
      yyls = (YYLTYPE *) alloca (yystacksize * sizeof (*yylsp));
      __yy_memcpy ((char *)yyls1, (char *)yyls, size * sizeof (*yylsp));
#endif
#endif /* no yyoverflow */

      yyssp = yyss + size - 1;
      yyvsp = yyvs + size - 1;
#ifdef YYLSP_NEEDED
      yylsp = yyls + size - 1;
#endif

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Stack size increased to %d\n", yystacksize);
#endif

      if (yyssp >= yyss + yystacksize - 1)
	YYABORT;
    }

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Entering state %d\n", yystate);
#endif

  goto yybackup;
 yybackup:

/* Do appropriate processing given the current state.  */
/* Read a lookahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to lookahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* yychar is either YYEMPTY or YYEOF
     or a valid token in external form.  */

  if (yychar == YYEMPTY)
    {
#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Reading a token: ");
#endif
      yychar = YYLEX;
    }

  /* Convert token to internal form (in yychar1) for indexing tables with */

  if (yychar <= 0)		/* This means end of input. */
    {
      yychar1 = 0;
      yychar = YYEOF;		/* Don't call YYLEX any more */

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Now at end of input.\n");
#endif
    }
  else
    {
      yychar1 = YYTRANSLATE(yychar);

#if YYDEBUG != 0
      if (yydebug)
	{
	  fprintf (stderr, "Next token is %d (%s", yychar, yytname[yychar1]);
	  /* Give the individual parser a way to print the precise meaning
	     of a token, for further debugging info.  */
#ifdef YYPRINT
	  YYPRINT (stderr, yychar, yylval);
#endif
	  fprintf (stderr, ")\n");
	}
#endif
    }

  yyn += yychar1;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != yychar1)
    goto yydefault;

  yyn = yytable[yyn];

  /* yyn is what to do for this token type in this state.
     Negative => reduce, -yyn is rule number.
     Positive => shift, yyn is new state.
       New state is final state => don't bother to shift,
       just return success.
     0, or most negative number => error.  */

  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrlab;

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Shift the lookahead token.  */

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting token %d (%s), ", yychar, yytname[yychar1]);
#endif

  /* Discard the token being shifted unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  /* count tokens shifted since error; after three, turn off error status.  */
  if (yyerrstatus) yyerrstatus--;

  yystate = yyn;
  goto yynewstate;

/* Do the default action for the current state.  */
yydefault:

  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;

/* Do a reduction.  yyn is the number of a rule to reduce with.  */
yyreduce:
  yylen = yyr2[yyn];
  if (yylen > 0)
    yyval = yyvsp[1-yylen]; /* implement default value of the action */

#if YYDEBUG != 0
  if (yydebug)
    {
      int i;

      fprintf (stderr, "Reducing via rule %d (line %d), ",
	       yyn, yyrline[yyn]);

      /* Print the symbols being reduced, and their result.  */
      for (i = yyprhs[yyn]; yyrhs[i] > 0; i++)
	fprintf (stderr, "%s ", yytname[yyrhs[i]]);
      fprintf (stderr, " -> %s\n", yytname[yyr1[yyn]]);
    }
#endif


  switch (yyn) {

case 1:
#line 154 "rubyparser.y"
{yyval.expr = createExpression(ET_PLUS, yyvsp[-2].expr, yyvsp[0].expr);;
    break;}
case 2:
#line 155 "rubyparser.y"
{yyval.expr = createExpression(ET_MINUS, yyvsp[-2].expr, yyvsp[0].expr);;
    break;}
case 3:
#line 156 "rubyparser.y"
{yyval.expr = createExpression(ET_MULT, yyvsp[-2].expr, yyvsp[0].expr);;
    break;}
case 4:
#line 157 "rubyparser.y"
{yyval.expr = createExpression(ET_DIV, yyvsp[-2].expr, yyvsp[0].expr);;
    break;}
case 5:
#line 160 "rubyparser.y"
{yyval.expr = createExpression(ET_PLUS, NULL, yyvsp[0].expr);;
    break;}
case 6:
#line 161 "rubyparser.y"
{yyval.expr = createExpression(ET_MINUS, NULL, yyvsp[0].expr);;
    break;}
case 7:
#line 163 "rubyparser.y"
{yyval.expr = createExpression(ET_NOT, NULL, yyvsp[0].expr);;
    break;}
case 8:
#line 164 "rubyparser.y"
{yyval.expr = createExpression(ET_LESSER, yyvsp[-2].expr, yyvsp[0].expr);;
    break;}
case 9:
#line 165 "rubyparser.y"
{yyval.expr = createExpression(ET_GREATER, yyvsp[-2].expr, yyvsp[0].expr);;
    break;}
case 10:
#line 166 "rubyparser.y"
{yyval.expr = createExpression(ET_GREATER_EQUAL, yyvsp[-2].expr, yyvsp[0].expr);;
    break;}
case 11:
#line 167 "rubyparser.y"
{yyval.expr = createExpression(ET_LESSER_EQUAL, yyvsp[-2].expr, yyvsp[0].expr);;
    break;}
case 12:
#line 168 "rubyparser.y"
{yyval.expr = createExpression(ET_EQUAL, yyvsp[-2].expr, yyvsp[0].expr);;
    break;}
case 13:
#line 169 "rubyparser.y"
{yyval.expr = createExpression(ET_NOT_EQUAL, yyvsp[-2].expr, yyvsp[0].expr);;
    break;}
case 14:
#line 170 "rubyparser.y"
{yyval.expr = createExpression(ET_EQUAL, yyvsp[-2].expr, yyvsp[0].expr);;
    break;}
case 15:
#line 172 "rubyparser.y"
{yyval.expr = createExpressionWithList(ET_ARRAY_OR_FUNC, (value){.string_val=yyvsp[-3].string_const}, yyvsp[-1].exprList);;
    break;}
case 16:
#line 174 "rubyparser.y"
{yyval.expr = createSimpleExpression(ET_INTEGER, (value){.int_val = yyvsp[0].int_const});;
    break;}
case 17:
#line 175 "rubyparser.y"
{yyval.expr = createSimpleExpression(ET_STRING, (value){.string_val=yyvsp[0].string_const});;
    break;}
case 18:
#line 177 "rubyparser.y"
{yyval.expr = createExpression(ET_LOGIC_OR, yyvsp[-2].expr, yyvsp[0].expr);;
    break;}
case 19:
#line 178 "rubyparser.y"
{yyval.expr = createExpression(ET_LOGIC_AND, yyvsp[-2].expr, yyvsp[0].expr);;
    break;}
case 20:
#line 180 "rubyparser.y"
{yyval.expr = createExpression(ET_ARRAY_ACCESS, yyvsp[-2].expr, NULL);;
    break;}
case 21:
#line 181 "rubyparser.y"
{yyval.expr = yyvsp[-1].expr;;
    break;}
case 22:
#line 182 "rubyparser.y"
{yyval.expr = createExpression(ET_ARRAY_ACCESS, yyvsp[-3].expr, yyvsp[-1].expr);;
    break;}
case 23:
#line 184 "rubyparser.y"
{yyval.expr = createSimpleExpression(ET_ID, (value){.string_val=yyvsp[0].string_const});;
    break;}
case 24:
#line 189 "rubyparser.y"
{yyval.vt = VT_INTEGER;;
    break;}
case 25:
#line 190 "rubyparser.y"
{yyval.vt = VT_STRING;;
    break;}
case 26:
#line 193 "rubyparser.y"
{yyval.stmt = yyvsp[0].stmt;;
    break;}
case 27:
#line 194 "rubyparser.y"
{yyval.stmt = createStatement(ST_WHILE, (stmtValue){.whileStmt=yyvsp[0].whileStmt});;
    break;}
case 28:
#line 195 "rubyparser.y"
{yyval.stmt = createStatement(ST_IF, (stmtValue){.ifStmt=yyvsp[0].ifStmt});;
    break;}
case 29:
#line 196 "rubyparser.y"
{yyval.stmt = yyvsp[0].stmt;;
    break;}
case 30:
#line 197 "rubyparser.y"
{yyval.stmt = yyvsp[0].stmt;;
    break;}
case 31:
#line 200 "rubyparser.y"
{yyval.stmtList = createStatementList(yyvsp[0].stmt);;
    break;}
case 32:
#line 201 "rubyparser.y"
{yyval.stmtList = appendStatementToList(yyvsp[-1].stmtList,yyvsp[0].stmt);;
    break;}
case 33:
#line 204 "rubyparser.y"
{yyval.stmt = createStatement(ST_EXPRESSION, (stmtValue){.exprStmt=yyvsp[-1].expr});;
    break;}
case 34:
#line 208 "rubyparser.y"
{yyval.whileStmt = createWhile(yyvsp[-3].expr, yyvsp[-1].stmtList);;
    break;}
case 35:
#line 212 "rubyparser.y"
{yyval.ifStmt = createIf(yyvsp[-5].expr, yyvsp[-3].stmtList, yyvsp[-2].elseIfStmtList, yyvsp[-1].elseStmt);;
    break;}
case 36:
#line 213 "rubyparser.y"
{yyval.ifStmt = createIf(yyvsp[-4].expr, yyvsp[-2].stmtList, NULL, yyvsp[-1].elseStmt);;
    break;}
case 37:
#line 216 "rubyparser.y"
{yyval.elseStmt = NULL;;
    break;}
case 38:
#line 217 "rubyparser.y"
{yyval.elseStmt = createElse(yyvsp[0].stmtList);;
    break;}
case 39:
#line 220 "rubyparser.y"
{yyval.elseIfStmt = createElseIf(yyvsp[-2].expr, yyvsp[0].stmtList);;
    break;}
case 40:
#line 223 "rubyparser.y"
{yyval.elseIfStmtList = createElseIfStatementList(yyvsp[0].elseIfStmt);;
    break;}
case 41:
#line 224 "rubyparser.y"
{yyval.elseIfStmtList = appendElseIfToList(yyvsp[-1].elseIfStmtList, yyvsp[0].elseIfStmt);;
    break;}
case 42:
#line 227 "rubyparser.y"
{yyval.stmt = createStatement(ST_RETURN, (stmtValue){.exprStmt=yyvsp[-1].expr});;
    break;}
case 43:
#line 228 "rubyparser.y"
{yyval.stmt = createStatement(ST_RETURN, (stmtValue){});;
    break;}
case 44:
#line 231 "rubyparser.y"
{yyval.stmt = createStatement(ST_NULL, (stmtValue){});;
    break;}
case 45:
#line 234 "rubyparser.y"
{yyval.exprList = createExpressionList(yyvsp[0].expr);;
    break;}
case 46:
#line 235 "rubyparser.y"
{yyval.exprList = appendExpressionToList(yyvsp[-2].exprList,yyvsp[0].expr);;
    break;}
case 47:
#line 238 "rubyparser.y"
{yyval.varList = createVariableList(yyvsp[0].string_const);;
    break;}
case 48:
#line 239 "rubyparser.y"
{yyval.varList = appendToVariableList(yyvsp[-2].varList, yyvsp[0].string_const);;
    break;}
case 49:
#line 244 "rubyparser.y"
{yyval.prog = createProgram(yyvsp[-4].string_const,yyvsp[-3].exprList,yyvsp[-1].stmtList);;
    break;}
case 50:
#line 246 "rubyparser.y"
{ yyval.progList = createProgramList(yyvsp[0].prog); ;
    break;}
case 51:
#line 247 "rubyparser.y"
{ yyval.progList = appentProgramToList(yyvsp[-1].progList,yyvsp[0].prog); ;
    break;}
case 52:
#line 250 "rubyparser.y"
{yyval.progList = root = yyvsp[0].progList;;
    break;}
}
   /* the action file gets copied in in place of this dollarsign */
#line 487 "bison.simple"

  yyvsp -= yylen;
  yyssp -= yylen;
#ifdef YYLSP_NEEDED
  yylsp -= yylen;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

  *++yyvsp = yyval;

#ifdef YYLSP_NEEDED
  yylsp++;
  if (yylen == 0)
    {
      yylsp->first_line = yylloc.first_line;
      yylsp->first_column = yylloc.first_column;
      yylsp->last_line = (yylsp-1)->last_line;
      yylsp->last_column = (yylsp-1)->last_column;
      yylsp->text = 0;
    }
  else
    {
      yylsp->last_line = (yylsp+yylen-1)->last_line;
      yylsp->last_column = (yylsp+yylen-1)->last_column;
    }
#endif

  /* Now "shift" the result of the reduction.
     Determine what state that goes to,
     based on the state we popped back to
     and the rule number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTBASE] + *yyssp;
  if (yystate >= 0 && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTBASE];

  goto yynewstate;

yyerrlab:   /* here on detecting error */

  if (! yyerrstatus)
    /* If not already recovering from an error, report this error.  */
    {
      ++yynerrs;

#ifdef YYERROR_VERBOSE
      yyn = yypact[yystate];

      if (yyn > YYFLAG && yyn < YYLAST)
	{
	  int size = 0;
	  char *msg;
	  int x, count;

	  count = 0;
	  /* Start X at -yyn if nec to avoid negative indexes in yycheck.  */
	  for (x = (yyn < 0 ? -yyn : 0);
	       x < (sizeof(yytname) / sizeof(char *)); x++)
	    if (yycheck[x + yyn] == x)
	      size += strlen(yytname[x]) + 15, count++;
	  msg = (char *) malloc(size + 15);
	  if (msg != 0)
	    {
	      strcpy(msg, "parse error");

	      if (count < 5)
		{
		  count = 0;
		  for (x = (yyn < 0 ? -yyn : 0);
		       x < (sizeof(yytname) / sizeof(char *)); x++)
		    if (yycheck[x + yyn] == x)
		      {
			strcat(msg, count == 0 ? ", expecting `" : " or `");
			strcat(msg, yytname[x]);
			strcat(msg, "'");
			count++;
		      }
		}
	      yyerror(msg);
	      free(msg);
	    }
	  else
	    yyerror ("parse error; also virtual memory exceeded");
	}
      else
#endif /* YYERROR_VERBOSE */
	yyerror("parse error");
    }

  goto yyerrlab1;
yyerrlab1:   /* here on error raised explicitly by an action */

  if (yyerrstatus == 3)
    {
      /* if just tried and failed to reuse lookahead token after an error, discard it.  */

      /* return failure if at end of input */
      if (yychar == YYEOF)
	YYABORT;

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Discarding token %d (%s).\n", yychar, yytname[yychar1]);
#endif

      yychar = YYEMPTY;
    }

  /* Else will try to reuse lookahead token
     after shifting the error token.  */

  yyerrstatus = 3;		/* Each real token shifted decrements this */

  goto yyerrhandle;

yyerrdefault:  /* current state does not do anything special for the error token. */

#if 0
  /* This is wrong; only states that explicitly want error tokens
     should shift them.  */
  yyn = yydefact[yystate];  /* If its default is to accept any token, ok.  Otherwise pop it.*/
  if (yyn) goto yydefault;
#endif

yyerrpop:   /* pop the current state because it cannot handle the error token */

  if (yyssp == yyss) YYABORT;
  yyvsp--;
  yystate = *--yyssp;
#ifdef YYLSP_NEEDED
  yylsp--;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "Error: state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

yyerrhandle:

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yyerrdefault;

  yyn += YYTERROR;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != YYTERROR)
    goto yyerrdefault;

  yyn = yytable[yyn];
  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrpop;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrpop;

  if (yyn == YYFINAL)
    YYACCEPT;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting error token, ");
#endif

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  yystate = yyn;
  goto yynewstate;
}
#line 253 "rubyparser.y"


void yyerror(char const *s)
{
	printf("%s",s);
}			

Expression *createSimpleExpression(EXPR_TYPE type, value val)
{
	Expression *result = (Expression *)malloc(sizeof(Expression));
	
	result->type = type;
	result->val = val;
	
	result->exprList = NULL;
	result->right = NULL;
	result->left = NULL;
	result->nextInList = NULL;
	
	return result;
}

Expression *createExpression(EXPR_TYPE type, Expression *left, Expression *right)
{
	Expression *result = (Expression *)malloc(sizeof(Expression));
	
	result->type = type;
	
	result->left = left;
	result->right = right;
	
	result->exprList = NULL;
	result->nextInList = NULL;
	
	return result;
}



Expression *createExpressionWithList(EXPR_TYPE type, value val, ExpressionList *exprList)
{
	Expression *result = (Expression *)malloc(sizeof(Expression));

	result->type = type;
	result->val = val;
	result->exprList = exprList;
	
	result->right = NULL;
	result->left = NULL;
	result->nextInList = NULL;
	
	return result;
}

ExpressionList *appendExpressionToList(ExpressionList *list, Expression *expr)
{
	list->end->nextInList = expr;
	list->end = expr;
	
	return list;
}

ExpressionList *createExpressionList(Expression *expr)
{
	ExpressionList *result = (ExpressionList *)malloc(sizeof(ExpressionList));
	
	result->begin = expr;
	result->end = expr;
	
	return result;
}

WhileStatement *createWhile(Expression *condition, StatementList *whileBlock)
{
	WhileStatement *result = (WhileStatement *)malloc(sizeof(WhileStatement));
	
	result->condition = condition;
	result->whileBlock = whileBlock;

	return result;
}



StatementList *appendStatementToList(StatementList *list, Statement *stmt)
{
	list->end->nextInList = stmt;
	list->end = stmt;
	return list;
}

StatementList *createStatementList(Statement *stmt)
{
	StatementList *result = (StatementList *)malloc(sizeof(StatementList));
	
	result->begin = stmt;
	result->end = stmt;
	return result;
}



IfStatement *createIf(Expression *condition, StatementList *stmtList, ElseIfStatementList *elseIfStmtList, ElseStatement *elseStmt)
{
	IfStatement *result = (IfStatement *)malloc(sizeof(IfStatement));
	
	result->condition = condition;
	result->stmtList = stmtList;
	result->elseIfStmtList = elseIfStmtList;
	result->elseStmt = elseStmt;
	
	return result;
}

ElseStatement *createElse(StatementList *stmtList)
{
	ElseStatement *result = (ElseStatement *)malloc(sizeof(ElseStatement));
	
	result->stmtList = stmtList;
	
	return result;
}

ElseIfStatement *createElseIf(Expression *condition, StatementList *stmtList)
{
	ElseIfStatement *result = (ElseIfStatement *)malloc(sizeof(ElseIfStatement));
	
	result->condition = condition;
	result->stmtList = stmtList;
	result->nextInList = NULL;
	
	return result;
}

ElseIfStatementList *createElseIfStatementList(ElseIfStatement *stmt)
{
	ElseIfStatementList *result = (ElseIfStatementList *)malloc(sizeof(ElseIfStatementList));
	
	result->begin = stmt;
	result->end = stmt;
	
	return result;
}

ElseIfStatementList *appendElseIfToList(ElseIfStatementList *list, ElseIfStatement *stmt)
{
	list->end->nextInList = stmt;
	list->end = stmt;
	return list;
}

Statement *createStatement(STMT_TYPE type, stmtValue val)
{
	Statement *result = (Statement *)malloc(sizeof(Statement));
	
	result->type = type;
	result->stmtVal = val;
	result->nextInList = NULL;
	
	return result;
}

VariableList *createVariableList(char* identifier)
{
	VariableList *result = (VariableList *)malloc(sizeof(VariableList));
	
	result->identifier = identifier;
	result->end = result;
	result->nextInList = NULL;
	
	return result;
}

VariableList *appendToVariableList(VariableList *list, char* identifier)
{
	VariableList *result = (VariableList *)malloc(sizeof(VariableList));
	
	result->identifier = identifier;
	result->nextInList = NULL;
	
	list->end->nextInList = result;
	list->end = result;
	
	return list;
}





Program *createProgram(char *identifier, ExpressionList *exprList, StatementList *stmtList)
{
	Program *result = (Program *)malloc(sizeof(Program));
	
	result->identifier = identifier;
	result->exprList =  exprList;
	result->stmtList = stmtList;

	
	return result;
}

ProgramList *createProgramList(Program *prog)
{
	ProgramList *result = (ProgramList *)malloc(sizeof(ProgramList));
	
	result->begin = prog;
	result->end = prog;
	
	return result;
}

ProgramList *appentProgramToList(ProgramList *list, Program *prog)
{
	list->end->nextInList = prog;
	list->end = prog;
	
	return list;
}