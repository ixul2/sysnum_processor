
(* Analyseur lexical pour Arith *)

{
  open Lexing
  open Parser

  exception UnrecognizedCharacter of string 
  exception InvalidString of string
  exception InvalidComment of string

  let last_caller_pos = ref (-2);;
}

let ident = ['a'-'z' '_']+
let integer = ('-' | '+')?['0'-'9']+

%token <int> REG IMM

rule token = parse
  | '\n'    { new_line lexbuf; token lexbuf }
  | ';'  {comment lexbuf; new_line lexbuf; token lexbuf }
  | "or" { OR }
  | "and" { AND }
  | "xor" { XOR }
  | "sub" { SUB }
  | "add" { ADD }
  | "cmp" { CMP }
  | "mov" { MOV }
  | "shr" { RSHIFT }
  | "shl" { LSHIFT }  
  | "load" { LOAD }
  | "store" { STORE } 
  | "push" { PUSH }
  | "pop" { POP }
  | "call" { CALL }
  | "ret" { RET }
  | "jmp" { JMP }
  | "je" { JE }
  | "jd" { JD }
  | "jlt" { JLT }
  | "jle" { JLE }
  | "jge" { JGE }
  | "jd" { JD }
  | "%r"(reg as integer) { REG (int_of_string reg) }
  | "$"(imm as integer) { IMM (int_of_string imm) }
  | (ident as label)":" {LABEL ident}
  | eof { EOF }
  | _ as c  {
    let err_msg = "invalid_character : " ^ (String.make 1 c) in
    raise (UnrecognizedCharacter err_msg ) }


and comment = parse
| '\n' { }
| eof { }
| _    { one_line_comment lexbuf }

