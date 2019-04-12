typedef enum expression_type{ ET_INTEGER, ET_FLOAT, ET_STRING, ET_CHARACTER, ET_ID, ET_ARRAY_OR_FUNC, ET_BOOL,ET_ARRAY_ACCESS,
								ET_EQUAL, ET_NOT_EQUAL, ET_LESSER, ET_GREATER,ET_LESSER_EQUAL,ET_GREATER_EQUAL,
								ET_PLUS, ET_MINUS, ET_CONCAT, ET_MULT, ET_DIV,
								ET_LOGIC_OR, ET_LOGIC_AND, ET_ASSIGN, ET_NOT,
								 ET_LENGTH_ARR_ATTR	} EXPR_TYPE;

typedef enum statement_type{ST_EXPRESSION,ST_RETURN,ST_NULL,ST_WHILE,ST_FOR,ST_IF, ST_ASSIGN} STMT_TYPE;
								
typedef enum variable_type{VT_INTEGER, VT_FLOAT, VT_STRING} VAR_TYPE;

typedef enum declaration_type{DT_VARIABLE,DT_FUNCTION} DEC_TYPE;

typedef union value value;
typedef union stmtValue stmtValue;
typedef union declarationStmt declarationStmt;
typedef struct Expression Expression;
typedef struct ExpressionList ExpressionList;
typedef struct Statement Statement;
typedef struct StatementList StatementList;
typedef struct WhileStatement WhileStatement;
typedef struct IfStatement IfStatement;
typedef struct ElseStatement ElseStatement;
typedef struct ElseIfStatement ElseIfStatement;
typedef struct ElseIfStatementList ElseIfStatementList;

typedef struct VariableList VariableList;

typedef struct Program Program;
typedef struct ProgramList ProgramList;

union value{
		
	int int_val;
	float float_val;
	char char_val;
	char *string_val;
};

union stmtValue{
	
	WhileStatement *whileStmt;
	
	IfStatement *ifStmt;
	Expression *exprStmt;
};

union declarationStmt{
	
	
	Program *prog;
};

struct Expression
{
	EXPR_TYPE type;
	value val;
	
	Expression *left;
	Expression *right;
	
	ExpressionList *exprList;//expression has expression list
	
	Expression *nextInList;//expression is part of list
};



struct ExpressionList
{
	Expression *begin;
	Expression *end;
};

struct Statement
{
	STMT_TYPE type;
	
	stmtValue stmtVal;
	
	Statement *nextInList;//statement is part of list
};

struct StatementList
{
	Statement *begin;
	Statement *end;
};

struct WhileStatement
{
	Expression *condition;
	StatementList *whileBlock;
};



struct IfStatement
{
	Expression *condition;
	StatementList *stmtList;
	ElseIfStatementList *elseIfStmtList;
	ElseStatement *elseStmt;
};

struct ElseStatement
{
	StatementList *stmtList;
};

struct ElseIfStatement
{
	Expression *condition;
	StatementList *stmtList;
	
	ElseIfStatement *nextInList;//statement is part of list
};

struct ElseIfStatementList
{
	ElseIfStatement *begin;
	ElseIfStatement *end;
};

struct VariableList
{
	char *identifier;
	
	VariableList *nextInList;
	VariableList *end;
};




struct Program
{
	char *identifier;
	ExpressionList *exprList;
	StatementList *stmtList;
	
	Program *nextInList;
};

struct ProgramList
{
	Program *begin;
	Program *end;
};