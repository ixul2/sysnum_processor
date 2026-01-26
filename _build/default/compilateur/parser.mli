
(* The type of tokens. *)

type token = 
  | XOR
  | SUB
  | STORE
  | RSHIFT
  | RET
  | REG of (int)
  | PUSH
  | POP
  | OR
  | MOV
  | LSHIFT
  | LOAD
  | LABEL_DEC of (string)
  | LABEL of (string)
  | JMP
  | JLT
  | JLE
  | JGT
  | JGE
  | JE
  | IMM of (int)
  | EOF
  | CMP
  | CALL
  | AND
  | ADD

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val file: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.program)
