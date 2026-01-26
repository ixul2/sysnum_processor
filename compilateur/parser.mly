
%{
  open Ast
  open Lexing
  
  module IntSet = Set.Make(Int)
  
%}

%token EOF
%token <string> LABEL LABEL_DEC
%token <int> REG IMM
%token AND OR XOR ADD RSHIFT LSHIFT MOV CMP SUB
%token STORE LOAD
%token PUSH POP CALL RET
%token JMP JE JLT JLE JGT JGE 

/* Définitions des pimmoimmtés et associativités des tokens */

/* Point d'entrée de la grammaire */
%start file

/* Type des valeurs retournées par l'analyseur syntaxique */
%type <Ast.program> file
%%

file:
| instrs=list(line) EOF { instrs }
;

line:
| i=instr { Instr i}
| l=LABEL_DEC { Label l}
;

instr:
| AND rsa=REG rsb=REG rd=REG {and_ rsa rsb rd}
| AND imm=IMM rg=REG rd=REG {andi rg imm rd}
| AND rg=REG imm=IMM rd=REG {andi rg imm rd}
| OR rsa=REG rsb=REG rd=REG {or_ rsa rsb rd}
| OR imm=IMM rg=REG rd=REG {ori rg imm rd}
| OR rg=REG imm=IMM rd=REG {ori rg imm rd}
| XOR rsa=REG rsb=REG rd=REG {xor rsa rsb rd}
| XOR imm=IMM rg=REG rd=REG {xori rg imm rd}
| XOR rg=REG imm=IMM rd=REG {xori rg imm rd}
| ADD rsa=REG rsb=REG rd=REG {add rsa rsb rd}
| ADD imm=IMM rg=REG rd=REG {addi rg imm rd}
| ADD rg=REG imm=IMM rd=REG {addi rg imm rd}
| SUB rsa=REG rsb=REG rd=REG {sub rsa rsb rd}
| SUB imm=IMM rg=REG rd=REG {subi_rev rg imm rd}
| SUB rg=REG imm=IMM rd=REG {subi rg imm rd}
| CMP rsa=REG rsb=REG {sub rsa rsb 0}
| CMP imm=IMM rg=REG {subi rg imm 0}
| CMP rg=REG imm=IMM {subi rg imm 0}
| RSHIFT rsa=REG rsb=REG rd=REG {rshift rsa rsb rd}
| RSHIFT imm=IMM rg=REG rd=REG {rshifti rg imm rd}
| RSHIFT rg=REG imm=IMM rd=REG {rshift rg imm rd}
| LSHIFT rsa=REG rsb=REG rd=REG {lshift rsa rsb rd}
| LSHIFT imm=IMM rg=REG rd=REG {lshifti rg imm rd}
| LSHIFT rg=REG imm=IMM rd=REG {lshift rg imm rd}
| MOV rsa=REG rd=REG {add 0 rsa rd}
| MOV imm=IMM rd=REG {addi 0 imm rd}
| LOAD radd=REG rd=REG {load radd rd}
| STORE radd=REG ra=REG {store radd ra}
| STORE radd=REG imm=IMM {storei radd imm}
| PUSH r=REG {push r}
| PUSH imm=IMM {pushi imm}
| POP r=REG {pop r}
| CALL r=REG {call r}
| CALL l=LABEL {calli l}
| RET {ret ()}
| JMP r=REG {jmp r}
| JMP l=LABEL {jmpi l}
| JE r=REG {je r}
| JE l=LABEL {jei l}
| JLT r=REG {jlt r}
| JLT l=LABEL {jlti l}
| JLE r=REG {jle r}
| JLE l=LABEL {jlei l}
| JGT r=REG {jgt r}
| JGT l=LABEL {jgti l}
| JGE r=REG {jge r}
| JGE l=LABEL {jgei l}
