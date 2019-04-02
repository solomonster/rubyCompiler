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

#include <stdio.h>
#include <malloc.h>
#include <ctype.h>

extern int yylex(void);    // external variable

void yyerror(char const *s){

  fprintf(stderr, "Line %d: %s\n", yylloc.first_line, s);
  exit(1);
}
  struct Expression* createExpression(enum ExpressionType type, struct Expression* left, struct Expression* middle, struct Expression* right, struct List* exprs, int intVal, float floatVal, char* strVal, struct Expression* id);
	struct Expression* createBaseTypeExpression(enum ExpressionType type, int intVal, float floatVal, char* strVal);
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

/*Секция объявлений содержит объявления символов грамматики и
описание их свойств (семантическое значение, приоритет и т.д.).
*/

%union {







}

%token IF
%token ELSE
%token ELSEIF
%token DO
%token WHILE
%token FOR
%token RETURN
%token THEN
%token END
%token BEGIN
%token DEF
%token BREAK
%token WHEN
%token CASE

%%

    /*Секция правил содержит описание грамматики (в слегка измененной форме Бэку-са-Науэра) 
    и действий на языке Си, выполняемых при срабатывании этих правил.
    */







%%


    /*Секция пользовательского кода содержит необходимые дополни-тельные функции, 
    которые будут добавлены в конец файла анализатора.Обычно здесь описывается
     функция main (другие необходимые функции,например функции вывода на экран или
      в файл синтаксического дерева,обычно размещают в отдельных файлах).
    */