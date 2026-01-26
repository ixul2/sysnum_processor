open Lexing

type program = line list

and line =
  | Label of string
  | Instr of instr

and instr = op_code * reg * reg * operand

and operand = 
   | Reg of int
   | Imm of int
   | ImmLabel of string

and op_code = int
and reg = int

(*OPCODE RW RA RB*)
let xor_code = 4
let xori_code = 5
let or_code = 8
let ori_code = 9
let and_code = 6
let andi_code = 7
let add_code = 0
let addi_code = 1
let sub_code = 2
let subi_code = 3
let rshift_code = 27
let rshifti_code = 28
let lshift_code = 25
let lshifti_code = 26
let load_code = 10
let store_code = 11
let storei_code = 12
let push_code = 29
let pushi_code = 30
let pop_code = 31
let je_code = 13
let jei_code = 14
let jmp_code = 23
let jmpi_code = 24
let jlt_code = 19
let jlti_code = 20
let jle_code = 15
let jlei_code = 16
let jgt_code = 21
let jgti_code = 22
let jge_code = 17
let jgei_code = 18

(*OPCODE RW RA RB*)
let xor opS1 opS2 opD = (xor_code, opD, opS1, Reg opS2)
let xori opS1 opS2 opD = (xori_code, opD, opS1, Imm opS2)
let or_ opS1 opS2 opD = (or_code, opD, opS1, Reg opS2)
let ori opS1 opS2 opD = (ori_code, opD, opS1, Imm opS2)
let and_ opS1 opS2 opD = (and_code, opD, opS1, Reg opS2)
let andi opS1 opS2 opD = (andi_code, opD, opS1, Imm opS2)
let add opS1 opS2 opD = (add_code, opD, opS1, Reg opS2)
let addi opS1 opS2 opD = (addi_code, opD, opS1, Imm opS2)
let sub opS1 opS2 opD = (sub_code, opD, opS1, Reg opS2)
let subi opS1 opS2 opD = (subi_code, opD, opS1, Imm opS2)
let rshift opS1 opS2 opD = (rshift_code, opD, opS1, Reg opS2)
let rshifti opS1 opS2 opD = (rshifti_code, opD, opS1, Imm opS2)
let lshift opS1 opS2 opD = (lshift_code, opD, opS1, Reg opS2)
let lshifti opS1 opS2 opD = (lshifti_code, opD, opS1, Imm opS2)
let load opS1 opD = (load_code, opD, opS1, Imm 0)
let store opS1 opS2 = (store_code, 0, opS1, Reg opS2)
let storei opS1 opS2 = (storei_code, 0, opS1, Imm opS2)
let push opS2 = (push_code, 0, 0, Reg opS2)
let pushi opS2 = (pushi_code, 0, 0, Imm opS2)
let pop opD = (pop_code, opD, 0, Imm 0)
let ret () = (pop_code, 2, 0, Imm 0)
let je opS1 = (je_code, 0, opS1, Imm 0)
let jei opS2 = (jei_code, 0, 2, ImmLabel opS2)
let jlt opS1 = (jlt_code, 0, opS1, Imm 0)
let jlti opS2 = (jlti_code, 0, 2, ImmLabel opS2)
let jle opS1 = (jle_code, 0, opS1, Imm 0)
let jlei opS2 = (jlei_code, 0, 2, ImmLabel opS2)
let jgt opS1 = (jgt_code, 0, opS1, Imm 0)
let jgti opS2 = (jgti_code, 0, 2, ImmLabel opS2)
let jge opS1 = (jge_code, 0, opS1, Imm 0)
let jgei opS2 = (jgei_code, 0, 2, ImmLabel opS2)
let jmp opS1 = (jmp_code, 2, opS1, Imm 0)
let jmpi opS2 = (jmpi_code, 2, 2, ImmLabel opS2)
let call opS1 = (-1, 0, opS1, Imm 0)
let calli opS1 = (-2, 0, 2, ImmLabel opS1)
let subi_rev opS1 opS2 opD = (-3, opD, opS1, Imm opS2)
