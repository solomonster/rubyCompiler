%{
	#include <math.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <conio.h>
	#include <locale.h> 
	#include "tree_nodes.h"
    #include "rubyparser_tab.h"
	#include "lexHelper.h"
	
	int yylval;
	 extern ProgramList *root;
    extern int yyparse(void);
%}


%option noyywrap
%option never-interactive
%option yylineno
%option case-insensitive


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



\"									{printf("\n\nSTART DOUBLE_QUOTED_STRING\n\n"); BEGIN(DOUBLE_QUOTED_STRING); literal[0] = '\0'; startLine=yylineno; }
<DOUBLE_QUOTED_STRING>[^\"\\]+		{ strcat(literal, yytext);}
<DOUBLE_QUOTED_STRING>\\a           {strcat(literal,"\a");} 
<DOUBLE_QUOTED_STRING>\\b           {strcat(literal,"\b");} 
<DOUBLE_QUOTED_STRING>\\t           {strcat(literal,"\t");} 
<DOUBLE_QUOTED_STRING>\\n           {strcat(literal,"\n");} 
<DOUBLE_QUOTED_STRING>\\\"           {strcat(literal,"\"");}
<DOUBLE_QUOTED_STRING>\\e           {strcat(literal,"\e");} 
<DOUBLE_QUOTED_STRING>\\f           {strcat(literal,"\f");} 
<DOUBLE_QUOTED_STRING>\\[0-7]{3}      { append_special_char_by_octcode(literal, yytext);}
<DOUBLE_QUOTED_STRING>\\r           {strcat(literal,"\r");} 
<DOUBLE_QUOTED_STRING>\\s           {strcat(literal,"\s");} 
<DOUBLE_QUOTED_STRING>\\v           {strcat(literal,"\v");} 
<DOUBLE_QUOTED_STRING>\\x[0-9a-fA-F]{2}   { append_special_char_by_hexcode(literal, yytext);}     
<DOUBLE_QUOTED_STRING>\"			{printf("\n\nEND DOUBLE_QUOTED_STRING\n\n"); printf("Found double quoted literal \"%s\". From line %d to line %d\n", literal, startLine, yylineno); BEGIN(INITIAL);}


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
"then"    {printf("Found Keyword :\"%s\" in line %d\n", "THEN",yylineno);}
"end"    {printf("Found Keyword :\"%s\" in line %d\n", "END",yylineno);}
"begin"   {printf("Found Keyword :\"%s\" in line %d\n", "BEGIN",yylineno);}
"def"       {printf("Found Keyword :\"%s\" in line %d\n", "DEF",yylineno);}
"break"      {printf("Found Keyword :\"%s\" in line %d\n", "BREAK",yylineno);}
"when"      {printf("Found Keyword :\"%s\" in line %d\n", "WHEN",yylineno);}
"in"        {printf("Found Keyword :\"%s\" in line %d\n", "IN",yylineno);}

\+ 		{printf("Found arithmetic operator :\"%s\" in line %d\n", yytext,yylineno);}
\- 		{printf("Found arithmetic operator :\"%s\" in line %d\n", yytext,yylineno);}
\* 		{printf("Found arithmetic operator :\"%s\" in line %d\n", yytext,yylineno);}
\/ 		{printf("Found arithmetic operator :\"%s\" in line %d\n", yytext,yylineno);}


= 		{printf("Found assignment operator :\"%s\" in line %d\n", yytext,yylineno);}


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
"." 					{ printf("Found symbol \"%s\" in line %d\n", yytext,yylineno); }
"," 					{ printf("Found symbol \"%s\" in line %d\n", yytext,yylineno); }
".."                    { printf("Found symbol \"%s\" in line %d\n", yytext,yylineno); }
"..."                   { printf("Found symbol \"%s\" in line %d\n", yytext,yylineno); }

{BOOLEAN}  {printf("Found boolean : \"%s\" in line %d\n", yytext,yylineno);}
{IDENTIFIER} {printf("Found an identifier: \"%s\" in line %d\n", yytext,yylineno);}
{BASE_10}					{ printf("Found int value \"%d\" in line %d\n", yy_parse_int(yytext, 'a'),yylineno);}
{BASE_16}					{ printf("Found int value \"%d\" in line %d\n", yy_parse_int(yytext, 'x'),yylineno);}
{BASE_8}						{ printf("Found int value \"%d\" in line %d\n", yy_parse_int(yytext, 'c'),yylineno);}
{BASE_2}						{ printf("Found int value \"%d\" in line %d\n", yy_parse_int(yytext, 'b'),yylineno);}
{NUM}		{printf("Found an integer : \"%d\" in line %d\n",atoi(yytext),yylineno);}
{FLOAT}  {printf("Found a floating point constant: \"%f\" in line %d\n", atof(yytext),yylineno);}
{EXPONENT}  {printf("Found a floating point : \"%f\" in line %d\n", atof(yytext),yylineno);}

\n  {}
\t  {}

%%

typedef struct TreeUnit TreeUnit;
struct TreeUnit
{
    char *label;
	char *edgeLabel;
	
    int num;
    int parentNum;
    
    TreeUnit *next;
};

typedef struct Tree Tree;
struct Tree
{
    TreeUnit * begin;
    TreeUnit * end;
};

FILE* fileOpen(int iter, const char* fname,const char* prefix, const char key);

void printTree(ProgramList *pr);
char *expr_type_str(EXPR_TYPE et);
char *stmt_type_str(STMT_TYPE et);
char *variable_type_str(VAR_TYPE et);


void print_node(int nodeNum, char *nodeName);
void print_edge(int numNode1, int numNode2, char* name);

TreeUnit *newTreeUnit(int parentNum, const char *label, const char *edgeLabel);
void addTreeUnit(Tree *tree, TreeUnit *element);

void programParse(Program *prog, Tree *tree, int parentNum);


void parseExpression(Expression *prog, Tree *tree, int parentNum);
void parseExpressionList(ExpressionList *prog, Tree *tree, int parentNum);
void parseVariableList(VariableList *prog, Tree *tree, int parentNum);
void parseStatementList(StatementList *prog, Tree *tree, int parentNum);
void parseStatement(Statement *prog, Tree *tree, int parentNum);
void parseWhileStatement(WhileStatement *whileStmt, Tree *tree, int parentNum);

void parseIfStatement(IfStatement *prog, Tree *tree, int parentNum);
void parseElse(ElseStatement *prog, Tree *tree, int parentNum);
void parseElseIfStatementList(ElseIfStatementList *prog, Tree *tree, int parentNum);

void main()
{
    int iterator = 4;
    
    const char* infname = "in\\test";
    const char* outfname = "out\\output";
    
    if( yyin = fileOpen(iterator, infname, ".adb", 'r') )
    {
		yyparse();
		fclose (yyin);
		
		fileOpen(iterator, outfname, ".txt", 'w');
		printTree(root);
		fclose (stdout);
    }
}

FILE* fileOpen(int iter, const char* fname,const char* prefix, const char key)
{
    char outname[51];
    char fnum[7];
    
    strcpy(outname, fname);
    itoa(iter, fnum, 10);
    strcat(outname, fnum);
    strcat(outname, prefix);
    
    switch(key)
    {
        case 'r':
            return fopen(outname, "rb");
        break;
    
        case 'w':
            return freopen(outname, "w", stdout);
        break;
    }
}

TreeUnit *newTreeUnit(int parentNum, const char *label, const char *edgeLabel)
{
    if(label!=NULL && edgeLabel!=NULL && parentNum>=0)
    {
        TreeUnit *unit = (TreeUnit *)malloc(sizeof(TreeUnit));
        
        unit->label = (char *)malloc( sizeof(char)*(strlen(label)+1) );
        strcpy(unit->label,label);
		
		unit->edgeLabel = (char *)malloc( sizeof(char)*(strlen(edgeLabel)+1) );
        strcpy(unit->edgeLabel,edgeLabel);
        
        unit->parentNum = parentNum;
		
		unit->next = NULL;
        
        return unit;
    }
    
    return NULL;
}

void addTreeUnit(Tree *tree, TreeUnit *element)
{
    if(tree!=NULL && element!=NULL )
    {
        if(tree->begin==NULL)
        {
            tree->begin = element;
            tree->end = element;
            element->num = 1;
        }
        else
        {
            tree->end->next = element;
            element->num = tree->end->num+1;
            tree->end = element;
        }
    }
}

//Tree print section


char *expr_type_str(EXPR_TYPE et)
{
    if(et==ET_INTEGER) return "ET_INTEGER";
    if(et==ET_FLOAT) return "ET_FLOAT";
    if(et==ET_STRING) return "ET_STRING";
    if(et==ET_CHARACTER) return "ET_CHARACTER";
    if(et==ET_ID) return "ET_ID";
    if(et==ET_ARRAY_OR_FUNC) return "ET_ARRAY_OR_FUNC";
    if(et==ET_BOOL) return "ET_BOOL";
    if(et==ET_EQUAL) return "=";
    if(et==ET_NOT_EQUAL) return "/=";
    if(et==ET_LESSER) return "<";
    if(et==ET_GREATER) return ">";
    if(et==ET_LESSER_EQUAL) return "<=";
    if(et==ET_GREATER_EQUAL) return ">=";
    if(et==ET_PLUS) return "+";
    if(et==ET_MINUS) return "-";
    if(et==ET_CONCAT) return "&";
    if(et==ET_MULT) return "*";
    if(et==ET_DIV) return "/";
    if(et==ET_LOGIC_OR) return "OR";
    if(et==ET_LOGIC_AND) return "AND";
    if(et==ET_ASSIGN) return ":=";
    if(et==ET_NOT) return "NOT";
 
    if(et==ET_LENGTH_ARR_ATTR) return "ET_LENGTH_ARR_ATTR";
    return "";
}

char *stmt_type_str(STMT_TYPE et)
{
    if(et==ST_EXPRESSION) return "ST_EXPRESSION";
    if(et==ST_RETURN) return "ST_RETURN";
    if(et==ST_NULL) return "ST_NULL";
    if(et==ST_WHILE) return "ST_WHILE";
    if(et==ST_IF) return "ST_IF";
    if(et==ST_ASSIGN) return ":=";
    return "";
}

char *variable_type_str(VAR_TYPE et)
{
    if(et==VT_INTEGER) return "INTEGER";
    if(et==VT_FLOAT) return "FLOAT";
    if(et==VT_STRING) return "STRING";
    
    return "";
}


void print_node(int nodeNum, char *nodeName)
{
    printf("%d  [label=\"%s\"];\n",nodeNum,nodeName);
}

void print_edge(int numNode1, int numNode2, char* name)
{
    printf("%d->%d[label=\"%s\"];\n",numNode1,numNode2,name);
}

void printTree(ProgramList *pr)
{
    if(pr!=NULL)
    {
        Tree *tree = (Tree *)malloc(sizeof(Tree));
        tree->begin = NULL;
        tree->end = NULL;
		
        programParse(pr->end, tree, 0);
        
		printf("digraph Program {\n");
		
			TreeUnit *i_units = tree->begin;
			while(i_units!=NULL)
			{
				print_node(i_units->num,i_units->label);
				i_units = i_units->next;
			}
			printf("\n");
			TreeUnit *i_parent = tree->begin;
			while(i_parent!=NULL)
			{
				TreeUnit *i_child = tree->begin;
				while(i_child!=NULL)
				{
					if(i_parent->num==i_child->parentNum)
					{
						print_edge(i_parent->num, i_child->num,i_child->edgeLabel);
					}
					
					i_child = i_child->next;
				}
				i_parent = i_parent->next;
			}
			
		printf("\n}");
    }
}

void programParse(Program *prog, Tree *tree, int parentNum)
{
    if(prog!=NULL)
    {
        //main title
        addTreeUnit(tree, newTreeUnit(parentNum,prog->identifier,"Function"));
		int currentIter = tree->end->num;
        
        //parts of program
      
        
        if(prog->performSection!=NULL)
        {
            parseStatementList(prog->performSection,tree,currentIter);
        }
        
        if(prog->globalariables!=NULL)
        {
			parseVariableDeclarationList(prog->globalariables,tree,currentIter);
        }
        
        //type of function
        addTreeUnit(
			tree, 
			newTreeUnit(currentIter,variable_type_str(prog->returnType),
			"Return type"));
    }
}



void parseExpression(Expression *prog, Tree *tree, int parentNum)
{
	if(prog!=NULL)
	{
		addTreeUnit(tree, newTreeUnit(parentNum,expr_type_str(prog->type),"Expression"));
		int currentIter = tree->end->num;
		
		char buf[51];
		switch(prog->type)
		{
			case ET_INTEGER :
			case ET_BOOL:
			
				itoa(prog->val.int_val,buf,10);
				
				addTreeUnit(tree, newTreeUnit(currentIter,buf,expr_type_str(prog->type)));
			break;
			
			case ET_FLOAT:
			
				sprintf(buf, "%f", prog->val.float_val);
				
				addTreeUnit(tree, newTreeUnit(currentIter,buf,"float"));
			break;
			
			case ET_STRING:
			case ET_ID:
			case ET_LENGTH_ARR_ATTR:
			
				addTreeUnit(tree, 
							newTreeUnit(currentIter,prog->val.string_val,expr_type_str(prog->type)));
			break;
			
			case ET_ARRAY_OR_FUNC:
				addTreeUnit(tree, newTreeUnit(currentIter,prog->val.string_val,expr_type_str(prog->type)));
				parseExpressionList(prog->exprList, tree, currentIter);
				
			break;
			
			
			
			default:
				
				if(prog->left!=NULL){
					parseExpression(prog->left, tree, currentIter);
				}
				
				if(prog->right!=NULL){
					parseExpression(prog->right, tree, currentIter);
				}
		}
		
		
	}
}

void parseExpressionList(ExpressionList *prog, Tree *tree, int parentNum)
{
    if(prog!=NULL)
    {
		addTreeUnit(tree, newTreeUnit(parentNum,"ExpressionList",""));
		int currentIter = tree->end->num;
		
		Expression *ds = prog->begin;
		for(; ds!=NULL; ds = ds->nextInList)
        {
            parseExpression(ds,tree,currentIter);
        }
    }
}

void parseVariableList(VariableList *prog, Tree *tree, int parentNum)
{
	if(prog!=NULL)
	{
		addTreeUnit(tree, newTreeUnit(parentNum,"VariableList",""));
		int currentIter = tree->end->num;
		
		VariableList *ds = prog;
		for(; ds!=NULL; ds = ds->nextInList)
        {
			addTreeUnit(tree, newTreeUnit(currentIter,ds->identifier,"variable"));
        }
	}
}

void parseStatementList(StatementList *prog, Tree *tree, int parentNum)
{
    if(prog!=NULL)
    {
		addTreeUnit(tree, newTreeUnit(parentNum,"StatementList",""));
		int currentIter = tree->end->num;
		
		Statement *ds = prog->begin;
		for(; ds!=NULL; ds = ds->nextInList)
        {
            parseStatement(ds,tree,currentIter);
        }
    }   
}

void parseStatement(Statement *prog, Tree *tree, int parentNum)
{
	if(prog!=NULL)
	{
		addTreeUnit(tree, newTreeUnit(parentNum,stmt_type_str(prog->type),"Statement"));
		int currentIter = tree->end->num;
	
		switch(prog->type)
		{
			case ST_EXPRESSION:
				parseExpression(prog->stmtVal.exprStmt,tree,currentIter);
			break;
			
			case ST_RETURN:
				parseExpression(prog->stmtVal.exprStmt,tree,currentIter);
			break;
			
			case ST_NULL:
				addTreeUnit(tree, newTreeUnit(currentIter,"NULL",""));
			break;
			
			case ST_WHILE:
				parseWhileStatement(prog->stmtVal.whileStmt,tree,currentIter);
			break;
			
			
			case ST_IF:
				parseIfStatement(prog->stmtVal.ifStmt, tree, currentIter);
			break;
			
			
		}
	}
}

void parseWhileStatement(WhileStatement *whileStmt, Tree *tree, int parentNum)
{
    if(whileStmt!=NULL)
    {
		addTreeUnit(tree, newTreeUnit(parentNum,"WhileStatement",""));
		int currentIter = tree->end->num;
	
		parseExpression(whileStmt->condition,tree,currentIter);

        parseStatementList(whileStmt->whileBlock, tree, currentIter);
    }
}



void parseIfStatement(IfStatement *prog, Tree *tree, int parentNum)
{
    if(prog!=NULL)
	{
		addTreeUnit(tree, newTreeUnit(parentNum,"IfStatement",""));
		int currentIter = tree->end->num;
	
		parseExpression(prog->condition,tree,currentIter);
		parseStatementList(prog->stmtList, tree, currentIter);
		parseElse(prog->elseStmt, tree, currentIter);
		parseElseIfStatementList(prog->elseIfStmtList, tree, currentIter);
	}
}

void parseElse(ElseStatement *prog, Tree *tree, int parentNum)
{
	if(prog!=NULL)
	{
		addTreeUnit(tree, newTreeUnit(parentNum,"ElseStatement",""));
		int currentIter = tree->end->num;
		
		parseStatementList(prog->stmtList, tree, currentIter);
	}
}

void parseElseIfStatementList(ElseIfStatementList *prog, Tree *tree, int parentNum)
{
	if(prog!=NULL)
    {
		addTreeUnit(tree, newTreeUnit(parentNum,"ElseIfStatementList",""));
		int currentIter = tree->end->num;
		
		ElseIfStatement *ds = prog->begin;
		for(; ds!=NULL; ds = ds->nextInList)
        {
			parseExpression(ds->condition,tree,currentIter);
			parseStatementList(ds->stmtList, tree, currentIter);
        }
    }
}