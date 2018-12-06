//Operator precedence should be from lowest to highest


%nonassoc IF  WHILE
%left AND OR
%right NOT
%right '='
%left '<' tLEQ '>' tGEQ
%left '+' '-'
%left '*' '/'
%right tUMINUS
%right '!' tUPLUS
%nonassoc ']'



%%

program         : compstmt

compstmt        : stmt_list opt_terms

stmt_list          : /*empty*/
                | stmt
                | stmt_list terms stmt

opt_terms       :/*empty*/ 
                | TERMS

terms           : term
                | terms ';'

TERM            : ';'
                | ENDL 

stmt            : /*empty*/                         // Confirm whether if and while loop should be in statement
                | PUT expr
                | RETURN
                | RETURN expr 
                || func_decl
                | expr                         



expr            : INT_LITERAL
                | STRING_LITERAL
                | IDENTIFIER
                | '[' ']'
                |'['args']'
                | IF expr then compstmt if_tail END
                | WHILE expr do compstmt END
                | expr AND expr  
                | expr OR expr
                | NOT expr  
                | lhs '=' expr  
                | expr '>' expr 
                | expr tGEQ expr 
                | expr '<' expr 
                | expr tLEQ expr
                | expr tEQ expr 
                | expr tNEQ expr    
                | expr '+' expr 
                | expr '-' expr 
                | expr '*' expr 
                | expr '/' expr
                | tUMINUS expr
                | tUPLUS expr 
                | '!' expr
                | command            
                | '(' compstmt ')' 
                | expr '[' ']'                
                | expr '[' expr ']'
                
                
if_tail         :/*empty*/
                |ELSE compstmt
                |ELSEIF expr then compstmt END if_tail

                         
do              : term 
                | DO 
                | term DO

then            : term 
                | THEN 
                | term THEN 


// Function call 
command        :  IDENTIFIER
                | IDENTIFIER CALL_ARGS  
                | IDENTIFIER '('call_args_list')' 

call_args_list  : /*empty*/
                | args

args            : expr
                |args ',' expr




func_decl  :  DEF IDENTIFIER argdecl
                compstmt
              END 
                        
lhs             : IDENTIFIER                    
                | IDENTIFIER expr


argdecl         : '(' arg_list ')'       
                | arg_list term


arg_list        :expr
               |arg_list ',' expr 


%%

                




