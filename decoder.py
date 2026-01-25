from lib_carotte import *
from settings import *
from ALU import op_dict
from memory import arbitrary_sized_multiplexer
allow_ribbon_logic_operations(True)

opcode_conversion_list = [
            #MR      MW      JMP     ALUSRC  OP0SRC  STACK   Sup     Eq      Inf     OPALU
    Constant("0"  +  "0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["add"]), #0 -> add
    Constant("0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["add"]), #1 -> addi
    Constant("0"  +  "0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["sub"]), #2 -> sub
    Constant("0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["sub"]), #3 -> subi
    Constant("0"  +  "0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["xor"]), #4 -> xor
    Constant("0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["xor"]), #5 -> xori
    Constant("0"  +  "0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["and"]), #6 -> and
    Constant("0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["and"]), #7 -> andi
    Constant("0"  +  "0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["or"]),  #8 -> or
    Constant("0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["or"]),  #9 -> ori
    Constant("1"  +  "0"  +  "0"  +  "1"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["add"]), #10 -> load
    Constant("1"  +  "1"  +  "0"  +  "1"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["add"]), #11 -> store
    Constant("1"  +  "1"  +  "0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["add"]), #12 -> storei
    Constant("0"  +  "0"  +  "1"  +  "1"  +  "0"  +  "0"  +  "0"  +  "1"  +  "0"  +  op_dict["add"]), #13 -> jmpe
    Constant("0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  "1"  +  "0"  +  op_dict["add"]), #14 -> jmpei
    Constant("0"  +  "0"  +  "1"  +  "1"  +  "0"  +  "0"  +  "0"  +  "1"  +  "1"  +  op_dict["add"]), #15 -> jmple
    Constant("0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  "1"  +  "1"  +  op_dict["add"]), #16 -> jmplei
    Constant("0"  +  "0"  +  "1"  +  "1"  +  "0"  +  "0"  +  "1"  +  "1"  +  "0"  +  op_dict["add"]), #17 -> jmpge
    Constant("0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "1"  +  "1"  +  "0"  +  op_dict["add"]), #18 -> jmpgei
    Constant("0"  +  "0"  +  "1"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  "1"  +  op_dict["add"]), #19 -> jmpl
    Constant("0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "1"  +  op_dict["add"]), #20 -> jmpli
    Constant("0"  +  "0"  +  "1"  +  "1"  +  "0"  +  "0"  +  "1"  +  "0"  +  "0"  +  op_dict["add"]), #21 -> jmpg
    Constant("0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "1"  +  "0"  +  "0"  +  op_dict["add"]), #22 -> jmpgi
    Constant("0"  +  "0"  +  "1"  +  "1"  +  "0"  +  "0"  +  "1"  +  "0"  +  "1"  +  op_dict["add"]), #23 -> jmpd
    Constant("0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "1"  +  "0"  +  "1"  +  op_dict["add"]), #24 -> jmpdi
    Constant("0"  +  "0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["shl"]), #25 -> shl
    Constant("0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["shl"]), #26 -> shli
    Constant("0"  +  "0"  +  "0"  +  "1"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["shr"]), #27 -> shr
    Constant("0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  "0"  +  op_dict["shr"]), #28 -> shri
    Constant("1"  +  "1"  +  "0"  +  "1"  +  "1"  +  "1"  +  "0"  +  "0"  +  "0"  +  op_dict["add"]), #29 -> push
    Constant("1"  +  "1"  +  "0"  +  "0"  +  "1"  +  "1"  +  "0"  +  "0"  +  "0"  +  op_dict["add"]), #30 -> pushi
    Constant("1"  +  "0"  +  "0"  +  "1"  +  "1"  +  "1"  +  "0"  +  "0"  +  "0"  +  op_dict["add"])  #31 -> pop
]

zero_padding = Constant("0" * (REG_SIZE - IMM_SIZE))
one_padding = Constant("1" * (REG_SIZE - IMM_SIZE))

def set_flags(opcode):
    flags = arbitrary_sized_multiplexer(Slice(0, OPCODE_SIZE, opcode), opcode_conversion_list)
    MR      =   Select(0, flags)
    MW      =   Select(1, flags)
    JMP     =   Select(2, flags)
    ALUSRC  =   Select(3, flags)
    OP0SRC  =   Select(4, flags)
    STACK   =   Select(5, flags)
    Sup     =   Select(6, flags)
    Eq      =   Select(7, flags)
    Inf     =   Select(8, flags)
    OPALU   =   Slice(9, 9 + OPALU_SIZE, flags)
    Rw = Slice(REG_ADDR_SIZE, 2 * REG_ADDR_SIZE, opcode)
    Ra = Slice(2 * REG_ADDR_SIZE, 3 * REG_ADDR_SIZE, opcode)
    Rb = Slice(3 * REG_ADDR_SIZE, 4 * REG_ADDR_SIZE, opcode)
    not_extended_imm = Slice(3 * REG_ADDR_SIZE, INSTRUCTION_SIZE, opcode)
    Imm = Concat(Mux(not_extended_imm[0], zero_padding, one_padding), not_extended_imm)
    return MR, MW, JMP, ALUSRC, OP0SRC, STACK, Sup, Eq, Inf, OPALU, Ra, Rb, Rw, Imm
