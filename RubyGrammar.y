
%{
  #include "tree_struct.h"
	#include <stdio.h>
	#include <malloc.h>
	void yyerror(char const *s);
	void printTree(void);
	void printStmt(int parentID, struct Statement* stmt);
	void printExpr(int parentID, struct Expression* expr, int* maxId);
  extern int yylex(void);

	struct Expression* createExpression(enum ExpressionType type, struct Expression* left, struct Expression* middle, struct Expression* right, struct List* exprs, int intVal, char* strVal, struct Expression* id);
	struct Expression* createBaseTypeExpression(enum ExpressionType type, int intVal, char* strVal);
  struct Expression* createBinaryExpression(enum ExpressionType type, struct Expression* left, struct Expression* right);

  struct List* createList(enum ExpressionListType type, struct Expression* expr, struct Statement* stmt);
	struct List* appendToList(struct List* list, struct Expression* expr, struct Statement* stmt);


  struct Statement* createStatement(enum StatementType type, struct Expression* expr, struct List* firstSuite, struct List* secondSuite, struct List* thirdSuite, struct List* stmtList, struct Expression* identifier);
	struct Statement* createFuncDefStatement(struct Expression* identifier, struct List* params, struct Expression* returnType, struct List* suite);
	struct Statement* createConditionStatement(struct Expression* condition, struct List* ifSuite, struct List* elifs, struct List* elseSuite);
	struct Statement* createWhileStatement(struct Expression* condition, struct List* mainSuite, struct List* elseSuite);
	struct Statement* createReturnStatement(struct Expression* expr);
	struct List* head;

%}

%union {
	int int_value;
	char* string_value;
	
	struct Expression* expr;
	struct Statement* stmt;
	struct List* list;
}


%start head

%token <int_value> INT_LITERAL
%token <string_value> STRING_LITERAL
%token <string_value> IDENTIFIER

%type <stmt> statement
%type <stmt> function_definition

%type <expr> expr
%type <expr> command
%type <expr> if_tail


%type <list> stmts
%type <list> parameters
%type <list> args
%type <list> call_args_list
%type <list>  program


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
%token END



//Operator precedence should be from lowest to highest

%nonassoc IF  WHILE
%left AND OR
%right NOT
%right '='
%nonassoc  tCMP tEQ tEQQ tNEQ tMATCH tNMATCH
%left  '>' tGEQ '<' tLEQ
%left '+' '-'
%left '*' '/'
%right  tUMINUS
%right '!' tUPLUS 
%nonassoc ']' ')'



%%

program         : stmts								  { $$ = head = $1; printf("START"); }

stmts           :stmt                                 { $$ = createList(LT_STATEMENT_LIST, NULL, $1); }
                |stmts terms stmt                     { $$ = appendToList($1, NULL, $2); }

terms           : term
                | terms term

term            : ';'
                | ENDL 

stmt            : /*empty*/                             {$$=NULL;}
                | PUT expr                              { $$ = createPutStatement($2); }
                | RETURN                                { $$ = createReturnStatement(NULL); }
                | RETURN expr                           { $$ = createReturnStatement($2); }
                | function_definition                   {$$=$1;}
                | expr                                  {$$=$1;}



expr            : INT_LITERAL                           { $$ = createBaseTypeExpression(ET_INT, $1, NULL); }
                 
                | STRING_LITERAL                        { $$ = createBaseTypeExpression(ET_STRING, 0, $1); }
                 
                | IDENTIFIER                            { $$ = createBaseTypeExpression(ET_ID, 	0, $1); }

                | '[' ']'                              { $$=createArrayExpression(NULL);}
                
                |'['args']'                           {$$=createArrayExpression($2);}

                | IF expr then stmts if_tail END       {$$=createOnlyIfCondition($2,$4);}

                | WHILE expr do stmts END             {$$= createWhileStatement($2,$4);}

                | expr AND expr                       { $$ = createBinaryExpression(ET_AND, $1, $3); }                             
                  
                | expr OR expr                        { $$ = createBinaryExpression(ET_OR, $1, $3); }
                 
                | NOT expr                            { $$ = createUnaryExpression(ET_NOT,$2); }
                 
                | expr '=' expr                       { $$ = createBinaryExpression(ET_ASSIGN, $1, $3); }
                  
                | expr '>' expr                       { $$ = createBinaryExpression(ET_GREATER, $1, $3); }
                  
                | expr tGEQ expr                       { $$ = createBinaryExpression(ET_GREATER_EQUAL, $1, $3); }

                | expr '<' expr                        { $$ = createBinaryExpression(ET_LESSER, $1, $3); }

                | expr tLEQ expr                        { $$ = createBinaryExpression(ET_LESSER_EQUAL, $1, $3); }

                | expr tEQ expr                        { $$ = createBinaryExpression(ET_EQUAL, $1, $3); }

                | expr tNEQ expr                       { $$ = createBinaryExpression(ET_NOT_EQUAL, $1, $3); 

                | expr '+' expr                        { $$ = createBinaryExpression(ET_PLUS, $1, $3); }
                 
                | expr '-' expr                        { $$ = createBinaryExpression(ET_MINUS, $1, $3); }
                
                | expr '*' expr                        { $$ = createBinaryExpression(ET_MULT, $1, $3); }

                | expr '/' expr                        { $$ = createBinaryExpression(ET_DIV, $1, $3); }
                  
                | tUMINUS expr                         {  $$ = createUnaryExpr(ET_UMINUS, $2);}
                  
                | tUPLUS expr                          { $$ = createUnaryExpr(ET_UPLUS, $2);}
                         

                | command                              { $$=$1;}

                | '(' expr ')'                     { $$=$2; }

                | expr '[' ']'                         { $$=createExpression(ET_ARRAY_ACCESS,$1,NULL);}

                | expr '[' expr ']'                   { $$=createExpression(ET,_ARRAY_ACCESS,$1,$3);}
                
                
if_tail         :/*empty*/
                |ELSE stmts
                |ELSEIF expr then stmts END if_tail

                         
do              : ENDL 
                | DO 
                | ENDL DO

then            : ENDL 
                | THEN 
                | ENDL THEN 


command        : IDENTIFIER     call_args_list          { $$ = createExpression(ET_FUNC_CALL, $1, NULL, NULL, $2, 0, NULL, NULL); }
                | IDENTIFIER '(' call_args_list ')'     { $$ = createExpression(ET_FUNC_CALL, $1, NULL, NULL, $3, 0, NULL, NULL); }

call_args_list  : /*empty*/                           {$$=NULL;}
                | args                                {$$=$1;}

args            : expr                                { $$ = createList(LT_EXPR_ARRAY_INITIAL_ARGUMENTS, $1, NULL); }
                | args ',' expr                        { $$ = appendToList($1, $3, NULL); }




function_definition  :  DEF IDENTIFIER  argdecl ENDL stmts END {createFuncDefStatement(struct Expression* identifier, struct List* params, struct Expression* returnType, struct List* suite)}
                      

argdecl         :/**empty**/                          {$$=NULL;}
                |'(' parameters ')' ENDL              {$$=$2;}
				|'(' parameters ')'                   {$$=$2;}
                | parameters ENDL                     {$$=$1;}


parameters        : IDENTIFIER                           { $$ = createList(LT_EXPR_FUNCTION_PARAMS, $1, NULL); }
               | parameters ',' IDENTIFIER               { $$ = appendToList($1, $3, NULL); }


%%

 void yyerror(char const *s)
{
	printf("%s",s);
}

struct Expression* createBaseTypeExpression(enum ExpressionType type, int intVal, char* strVal)
{
	return createExpression(type, NULL, NULL, NULL, NULL, intVal,strVal, NULL);
}

struct Expression* createBinaryExpression(enum ExpressionType type,struct Expression *left, struct Expression *right)
{
	return createExpression(type, left, NULL, right, NULL, 0, NULL, NULL);
}

struct Expression* createExpression(enum ExpressionType type, struct Expression* left, struct Expression* middle, struct Expression* right, struct List* exprs, int intVal, char* strVal, struct Expression* id)
{
	printf("Expression %d \n", type);
	struct Expression* result = (struct Expression*)malloc(sizeof(struct Expression));
	result->type = type;
	result->left = left;
	result->middle = middle;
	result->right = right;
	result->exprs = exprs;
	result->intVal = intVal;
	result->strVal = strVal;
	result->identifier = id;
	return result;
}

struct List* createList(enum ExpressionListType type, struct Expression* expr, struct Statement* stmt)
{ 
	printf("List %d \n", type);
	struct List* result = (struct List*)malloc(sizeof(struct List));
	result->type = type;
	result->expr_value = expr;
	result->stmt_value = stmt;
	result->next = NULL;
	
	return result;
}

struct List* appendToList(struct List* list, struct Expression* expr, struct Statement* stmt)
{
	struct List* cur = list;
	while(cur->next != NULL)
		cur = cur->next;
	cur->next = createList(LT_ELEMENT, expr, stmt);
	
	return list;
}

struct Statement* createStatement(enum StatementType type, struct Expression* expr, struct List* firstSuite, struct List* secondSuite, struct List* thirdSuite, struct List* stmtList, struct Expression* identifier)
{
	printf("Statement %d \n", type);
	struct Statement* result = (struct Statement*)malloc(sizeof(struct Statement));
	result->type = type;
	result->expr = expr;
	result->firstSuite = firstSuite;
	result->secondSuite = secondSuite;
	result->thirdSuite = thirdSuite;
	result->stmtList = stmtList;
	result->identifier = identifier;
	
	return result;
}

struct Statement* createFuncDefStatement(struct Expression* identifier, struct List* params, struct Expression* returnType, struct List* suite)
{
	return createStatement(ST_FUNCTION_DEF, returnType, suite, NULL, NULL, params, identifier);
}


struct Statement* createConditionStatement(struct Expression* condition, struct List* ifSuite, struct List* elifs, struct List* elseSuite)
{
	return createStatement(ST_CONDITION, condition, ifSuite, elseSuite, NULL, elifs, NULL);
}

struct Statement* createWhileStatement(struct Expression* condition, struct List* mainSuite, struct List* elseSuite)
{
	return createStatement(ST_WHILE, condition, mainSuite, elseSuite, NULL, NULL, NULL);
}


struct Statement* createReturnStatement(struct Expression* expr)
{
	return createStatement(ST_RETURN, expr, NULL, NULL, NULL, NULL, NULL);
}

               




