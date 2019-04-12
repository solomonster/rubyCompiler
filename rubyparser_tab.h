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


extern YYSTYPE yylval;
