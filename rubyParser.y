/**********************************************************************

  Authors:   Ибрагим.И.А   и  Махоткин.И

  Группа:ПрИн-466
  Язык : Ruby

**********************************************************************/
%{ 
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


%}

%union {
	
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
}

%type <expr> expression
%type <stmt> empty_statement return_statement expression_statement
%type <exprList> expression_list
%type <varList> variable_list


%type <elseIfStmt> elsif_statement
%type <elseStmt> else_statement
%type <ifStmt> if_statement
%type <elseIfStmtList> elsif_statement_list
%type <whileStmt> while_statement
%type <stmtList> statement_list
%type <stmt> statement
%type <vt> variable_type

%type <prog> program_block
%type <progList> program_list
%type <progList> program


%token <int_const> INT_LITERAL
%token <string_const> STRING_LITERAL 
%token <string_const> IDENTIFIER

%token INTEGER 
%token STRING 
%token RETURN
%token DEF
%token WHILE
%token AND
%token NOT
%token ELIF
%token IF
%token OR
%token ELSE
%token TRUEDIV
%token EG
%token EL
%token EQ
%token NEQ
%token ENDL
%token DO
%token END
%token THEN
%token ELSIF



//Operator precedence should be from lowest to highest

%nonassoc IF  WHILE
%left AND OR
%right NOT
%right '='
%nonassoc  tCMP tEQ tEQQ tNEQ tMATCH tNMATCH
%left  '>' tGEQ '<' tLEQ
%left '+' '-'
%left '*' '/'
%right  UMINUS
%right '!' UPLUS 
%nonassoc ']' ')'


%start program

%%

expression : expression '+' expression	{$$ = createExpression(ET_PLUS, $1, $3);}
			|	expression '-' expression	{$$ = createExpression(ET_MINUS, $1, $3);}
			|	expression '*' expression	{$$ = createExpression(ET_MULT, $1, $3);}
			|	expression '/' expression	{$$ = createExpression(ET_DIV, $1, $3);}
			
			
			|	'+' expression %prec UPLUS	{$$ = createExpression(ET_PLUS, NULL, $2);}
			|	'-' expression %prec UMINUS	{$$ = createExpression(ET_MINUS, NULL, $2);}
			
			|	NOT expression						{$$ = createExpression(ET_NOT, NULL, $2);}
			|	expression '<' expression			{$$ = createExpression(ET_LESSER, $1, $3);}
			|	expression '>' expression			{$$ = createExpression(ET_GREATER, $1, $3);}
			|	expression tGEQ expression	{$$ = createExpression(ET_GREATER_EQUAL, $1, $3);}
			|	expression tLEQ expression	{$$ = createExpression(ET_LESSER_EQUAL, $1, $3);}
			|	expression tEQ expression	{$$ = createExpression(ET_EQUAL, $1, $3);}
			|	expression tNEQ expression	{$$ = createExpression(ET_NOT_EQUAL, $1, $3);}
			|	expression '=' expression			{$$ = createExpression(ET_EQUAL, $1, $3);}
			
			|	IDENTIFIER '(' expression_list ')'	{$$ = createExpressionWithList(ET_ARRAY_OR_FUNC, (value){.string_val=$1}, $3);}
			
			|	INT_LITERAL 	{$$ = createSimpleExpression(ET_INTEGER, (value){.int_val = $1});}
			|	STRING_LITERAL 	{$$ = createSimpleExpression(ET_STRING, (value){.string_val=$1});}
			
			|	expression OR expression	{$$ = createExpression(ET_LOGIC_OR, $1, $3);}
			|	expression AND expression	{$$ = createExpression(ET_LOGIC_AND, $1, $3);}
			
			|	expression '[' ']'  	{$$ = createExpression(ET_ARRAY_ACCESS, $1, NULL);}
			|	'(' expression ')'	{$$ = $2;}
			|	expression '[' expression ']'  	{$$ = createExpression(ET_ARRAY_ACCESS, $1, $3);}
			
			|	IDENTIFIER				{$$ = createSimpleExpression(ET_ID, (value){.string_val=$1});}
			
			;	
			
			
variable_type : INTEGER	{$$ = VT_INTEGER;}
				| STRING	{$$ = VT_STRING;}
				;
			
statement : expression_statement	{$$ = $1;}
		  | while_statement			{$$ = createStatement(ST_WHILE, (stmtValue){.whileStmt=$1});}
		  | if_statement			{$$ = createStatement(ST_IF, (stmtValue){.ifStmt=$1});}
		  | return_statement		{$$ = $1;}
		  | empty_statement			{$$ = $1;}
		  ;			
		  
statement_list : statement					{$$ = createStatementList($1);}
				| statement_list statement	{$$ = appendStatementToList($1,$2);}
				;
				
expression_statement : expression ';'	{$$ = createStatement(ST_EXPRESSION, (stmtValue){.exprStmt=$1});}
					;

					
while_statement : WHILE expression DO statement_list END 	{$$ = createWhile($2, $4);}
				;

			
if_statement : IF expression THEN statement_list elsif_statement_list else_statement END 	{$$ = createIf($2, $4, $5, $6);}
			 | IF expression THEN statement_list else_statement END	{$$ = createIf($2, $4, NULL, $5);}
				;
		
else_statement : 	/* empty */ 		{$$ = NULL;}
				| ELSE statement_list	{$$ = createElse($2);}
				;
				
elsif_statement : ELSIF expression THEN statement_list	{$$ = createElseIf($2, $4);}
				;
				
elsif_statement_list : elsif_statement					{$$ = createElseIfStatementList($1);}
				| elsif_statement_list elsif_statement	{$$ = appendElseIfToList($1, $2);}
				;
				
return_statement : RETURN expression ';'	{$$ = createStatement(ST_RETURN, (stmtValue){.exprStmt=$2});}
				| RETURN ';'				{$$ = createStatement(ST_RETURN, (stmtValue){});}
				;
		
empty_statement : /*empty*/  ';'	{$$ = createStatement(ST_NULL, (stmtValue){});}
				;
				
expression_list : expression		{$$ = createExpressionList($1);}
				| expression_list ',' expression {$$ = appendExpressionToList($1,$3);}
				;

variable_list : IDENTIFIER {$$ = createVariableList($1);}
			| variable_list ',' IDENTIFIER {$$ = appendToVariableList($1, $3);}
			;
			
		
				
program_block : DEF IDENTIFIER expression_list ENDL statement_list END   {$$ = createProgram($2,$3,$5);}				
	
program_list : program_block				{ $$ = createProgramList($1); }
			 | program_list program_block	{ $$ = appentProgramToList($1,$2); }
			 ;
			 
program : program_list	{$$ = root = $1;}
		;	
				
%%

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