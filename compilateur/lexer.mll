
(* Analyseur lexical pour Arith *)

{
  open Lexing
  open Parser

  exception UnrecognizedCharacter of string 

  let last_caller_pos = ref (-2);;
}

let ident = ['a'-'z' '_']+
let integer = ('-' | '+')?['0'-'9']+
let blank = [' ' '\t']

rule token = parse
  | blank { token lexbuf }
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
  | "jlt" { JLT }
  | "jle" { JLE }
  | "jge" { JGE }
  | "jgt" { JGT }
  | "%r"(integer as reg) { REG (int_of_string reg) }
  | "$"(integer as imm) { IMM (int_of_string imm) }
  | (ident as label)":" {LABEL_DEC label}
  | (ident as label) {LABEL label}
  | eof { EOF }
  | _ as c  {
    let err_msg = "invalid_character : " ^ (String.make 1 c) in
    raise (UnrecognizedCharacter err_msg ) }


and comment = parse
| '\n' { }
| eof { }
| _    { comment lexbuf }

