#ifndef __TREE_NODES_H__
#define __TREE_NODES_H__

enum ExpressionType { 
	ET_INT,
	ET_STRING,
	ET_ID,
	ET_FUNCTION_CALL,
	ET_ARRAY_ACCESS,
	ET_AND, ET_OR, ET_NOT,
	ET_GREATER, ET_LESSER, ET_GREATER_EQUAL, ET_LESSER_EQUAL, ET_EQUAL ,ET_NOT_EQUAL,
	ET_PLUS,ET_MINUS,ET_MULT,ET_DIV,
	ET_UMINUS,ET_UPLUS
};

enum StatementType {
	ET_EXPRESSION_TYPE, ET_FUNCTION_DEFINITION,
	enIF, enIFELSE, enIFELIF, enIFELIFELSE,
	enWHILE
};

struct RootStruct {
	struct StatementListStruct * stmts;
};

struct StatementListStruct {
	struct StatementStruct*		first;
	struct StatementStruct*		last;
};

struct StatementStruct {
	enum StatementType 			type;	
	struct Expression* 	         expr;
	struct Function*		function;
	char*						Id;
	
	struct StatementList *	mainstmts;
	struct StatementList * elsestmts;
	struct ElseInIfStruct*		elif;
	
	struct StatementStruct*		next;
};

struct ElSIfStruct {
	struct Expression*	expr;
	struct StatementList*	stmts;
	
	struct ElSIfStruct*			next;
};

struct ElseInIfStruct{
	struct ElIfStruct*			first;
	struct ElIfStruct*			last;
};


struct FunctionStruct {
	char * id;
	struct IdListStruct*	argmts;
	struct StatementListStruct*	stmts;
};

struct OneIdStruct {
	char * id;
	struct OneIdStruct*	next;
};

struct IdListStruct {
	struct OneIdStruct* first;
	struct OneIdStruct* last;
};


struct ExpressionListStruct {
	struct Expression*	first;
	struct Expression*	last;
};



struct Expression {
	enum ExpressionType type;
	struct ExpressionList* exprs;
	struct Expression*	 left;
	struct Expression*	 right;
	
	struct Expression*	next;
};


struct ExpressionListStruct* createExprList(struct ExpressionStruct* expr);
struct ExpressionListStruct* addtoExprList(struct ExpressionListStruct* list, struct ExpressionStruct* expr);
struct ExpressionStruct* createComplexIdExpr(struct ComplexIdStruct* complexid);
struct ExpressionStruct* createBinaryExpression(enum enExprType type, struct ExpressionStruct* left, struct ExpressionStruct* right);
struct ExpressionStruct* createUnaryExpression(enum enExprType type, struct ExpressionStruct* left);
struct ExpressionStruct* createArrayExpr(struct ExpressionListStruct* exprs);
struct ComplexIdStruct* createFunctCallComplexId(struct ComplexIdStruct* right, struct ExpressionListStruct* argmts);
struct ComplexIdStruct* createBuilInFunctCall(char * functname, struct ExpressionListStruct* argmts);
struct ComplexIdStruct* createArrAccessComplexId(struct ComplexIdStruct* left, struct ExpressionStruct* expr);
struct ComplexIdStruct* createArrSliceComplexId(struct ComplexIdStruct* left, struct ExpressionStruct* start, struct ExpressionStruct* end);
struct IdListStruct* createIdList(char * id);
struct IdListStruct* addToIdList(struct IdListStruct* list, char * id);
struct FunctionStruct* createFunction(char * id, struct IdListStruct* argmts, struct StatementListStruct* stmts);
struct ElIfStruct* createElIfStruct(struct ExpressionStruct* expr, struct StatementListStruct* stmts);
struct ElseInIfStruct* createElseInIfStruct(struct ExpressionStruct* expr, struct StatementListStruct* stmts);
struct ElseInIfStruct* addtoElseInIfStruct(struct ElseInIfStruct* list, struct ExpressionStruct* expr, struct StatementListStruct* stmts);
struct StatementStruct* createExprStatementStruct(struct ExpressionStruct* expr);
struct StatementStruct* createFuncDefStatementStruct(struct FunctionStruct* function);
struct StatementStruct* createSimpleStatementStruct(enum enStmtType type);
struct StatementStruct* createIfOnlyStatementStruct(struct ExpressionStruct* expr, struct StatementListStruct* mainstmts);
struct StatementStruct* createIfElseStatementStruct(struct ExpressionStruct* expr, struct StatementListStruct* mainstmts, struct StatementListStruct* elsestmts);
struct StatementStruct* createIfElifStatementStruct(struct ExpressionStruct* expr, struct StatementListStruct* mainstmts, struct ElseInIfStruct* elif);
struct StatementStruct* createIfElifElseStatementStruct(struct ExpressionStruct* expr, struct StatementListStruct* mainstmts, struct StatementListStruct* elsestmts, struct ElseInIfStruct* elif);
struct StatementStruct* createWhileStatementStruct(struct ExpressionStruct* expr, struct StatementListStruct* mainstmts);
struct StatementListStruct* createStatementList(struct StatementStruct* stmt);
struct StatementListStruct* addtoStatmentList(struct StatementListStruct* list, struct StatementStruct* stmt);




struct RootStruct * createRoot(struct StatementListStruct* stmts);

#endif
