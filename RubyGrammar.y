%%

PROGRAM         : COMPSTMT

COMPSTMT        : STMTS OPT_TERMS

STMTS           : /*empty*/
                | STMT
                | STMTS TERMS STMT

OPT_TERMS       :/*empty*/ 
                | TERMS

TERMS           : TERM
                | TERMS ';'

TERM            : ';'
                | '\n' 

STMT            : /*empty*/                         // Confirm whether if and while loop should be in statement
                | put EXPR
                | return
                | return CALL_ARGS_LIST
                | LHS '=' COMMAND 
                | EXPR                         


/* In ruby unlike other languages if , while are expressons , they return value
for example minimum = if x < y then x else y end
while loop and method definition return nil so they are part of expr
in ruby functions return value so they are expressions
*/

EXPR            : INT_LITERAL
                | STRING_LITERAL
                | IDENTIFIER
                | LHS '=' EXPR
                | '[' ']'
                |'['ARGS']'
                | EXPR and EXPR   /* logical-expression
                | EXPR or EXPR
                | not EXPR         */
                | EXPR tOROP EXPR
                | EXPR tANDOP EXPR 
                | EXPR '+' EXPR 
                | EXPR '-' EXPR 
                | EXPR '*' EXPR 
                | EXPR '/' EXPR
                | tUPLUS EXPR 
                | tMINUS EXPR
                | EXPR '>' EXPR 
                | EXPR tGEQ EXPR 
                | EXPR '<' EXPR 
                | EXPR tLEQ EXPR
                | EXPR tEQ EXPR 
                | EXPR tNEQ EXPR
                | '!' EXPR
                | IF_EXPR
                | WHILE_EXPR
                | FUNCTION_DECLARATION
                | '(' COMPSTMT ')' 
                | EXPR '[' ']'                
                | EXPR '[' ARGS ']'
                | COMMAND            
                | '!' COMMAND
                
IF_EXPR         :if EXPR THEN     
                    COMPSTMT
                  IF_TAIL
                  end

IF_TAIL         : OPT_ELSE
                |ELSIF EXPR THEN
                   COMPSTMT
                 IF_TAIL

OPT_ELSE        :NONE
                |ELSE CMPSTMT  
          
WHILE_EXPR      : while EXPR DO COMPSTMT end                

DO              : TERM 
                | do 
                | TERM do

THEN            : TERM 
                | then 
                | TERM then 


// Function call 
COMMAND         : IDENTIFIER
                | IDENTIFIER CALL_ARGS  
                | IDENTIFIER '('CALL_ARGS_LIST')' 

CALL_ARGS_LIST  : /*empty*/
                | ARGS

ARGS            : EXPR
                |ARGS ',' EXPR



// function declaration
FUNCTION_DECLARATION  :def IDENTIFIER ARGDECL
                          COMPSTMT
                        end 
                        
LHS             : IDENTIFIER                    
                | IDENTIFIER '[' ']'
                | IDENTIFIER '['ARGS']'


ARGDECL         : '(' ARGLIST ')'       
                | ARGLIST TERM


ARGLIST        :EXPR
               |ARGLIST ',' EXPR 


%%

                




