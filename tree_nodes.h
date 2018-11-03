
enum enExprType { 
	
	enRETURN,
	
	enASSIGN,
	enASSPLUS, enASSMINUS, enASSMULTI, enASSDIV, enASSTRUEDIV, enASSMOD, 
	enASSAND, enASSOR, enASSXOR, enASSSHIFTLEFT, enASSSHIFTRIGHT, enASSPOWER,
	enOR, enAND, enNOT,
	enGT, enLT, enEQ, enNEQ, enEL, enEG,
	enORBIT, enXOR, enANDBIT,
	enPLUS, enMINUS, enMULTI, enDIV, enTRUEDIV, enMOD,
	enUMINUS, enUPLUS,
};

enum enStmtType {
	enEXPR, enCLASSDEF, enFUNCDEF,
	enBREAK, enCONTINUE,
	enIF, enIFELSE, enIFELIF, enIFELIFELSE,
	enWHILE, enWHILEELSE,
	enFOREXPR, enFOREXPRELSE, enFORCMPLID, enFORCMPLIDELSE
};
struct RootStruct {
	struct StatementListStruct * stmts;
};

struct StatementListStruct {
	struct StatementStruct*		first;
	struct StatementStruct*		last;
};

struct StatementStruct {
	enum enStmtType 			type;	
	struct ExpressionStruct* 	expr;
	struct ClassStruct*			clss;
	struct FunctionStruct*		function;
	
	char*				Id;
	
	struct StatementListStruct*	mainstmts;
	struct StatementListStruct* elsestmts;
	struct ElseInIfStruct*		elif;
	
	struct StatementStruct*		next;
};

struct ElIfStruct {
	struct ExpressionStruct*	expr;
	struct StatementListStruct*	stmts;
	
	struct ElIfStruct*			next;
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

struct ExpressionStruct* createBinaryExpr(enum enExprType type, struct ExpressionStruct* left, struct ExpressionStruct* right);
struct FunctionStruct* createFunction(char * id, struct IdListStruct* argmts, struct StatementListStruct* stmts);
struct ElIfStruct* createElIfStruct(struct ExpressionStruct* expr, struct StatementListStruct* stmts);
struct ElseInIfStruct* createElseInIfStruct(struct ExpressionStruct* expr, struct StatementListStruct* stmts);
struct ElseInIfStruct* addtoElseInIfStruct(struct ElseInIfStruct* list, struct ExpressionStruct* expr, struct StatementListStruct* stmts);
struct StatementStruct* createFuncDefStatementStruct(struct FunctionStruct* function);
struct StatementListStruct* createStatementList(struct StatementStruct* stmt);
struct StatementListStruct* addtoStatmentList(struct StatementListStruct* list, struct StatementStruct* stmt);
struct RootStruct * createRoot(struct StatementListStruct* stmts);