from lib_carotte import *
from settings import *
from ALU import op_dict
from memory import arbitrary_sized_multiplexer
allow_ribbon_logic_operations(True)

opcode_conversion_list = [
    #MR     MW     JMP    ALUSRC OP0SRC STACK   Sup     Eq      Inf     OPALU
    (1,     0,     0,     1,     0,     0,      0,      0,      0,      op_dict["add"]), #0 -> add
    (1,     0,     0,     0,     0,     0,      0,      0,      0,      op_dict["add"]), #1 -> addi
    (1,     0,     0,     1,     0,     0,      0,      0,      0,      op_dict["sub"]), #2 -> sub
    (1,     0,     0,     0,     0,     0,      0,      0,      0,      op_dict["sub"]), #3 -> subi
    (1,     0,     0,     1,     0,     0,      0,      0,      0,      op_dict["xor"]), #4 -> xor
    (1,     0,     0,     0,     0,     0,      0,      0,      0,      op_dict["xor"]), #5 -> xori
    (1,     0,     0,     1,     0,     0,      0,      0,      0,      op_dict["and"]), #6 -> and
    (1,     0,     0,     0,     0,     0,      0,      0,      0,      op_dict["and"]), #7 -> andi
    (1,     0,     0,     1,     0,     0,      0,      0,      0,      op_dict["or"]),  #8 -> or
    (1,     0,     0,     0,     0,     0,      0,      0,      0,      op_dict["or"]),  #9 -> ori
    (0,     0,     0,     1,     1,     0,      0,      0,      0,      op_dict["add"]), #10 -> load
    (0,     1,     0,     1,     1,     0,      0,      0,      0,      op_dict["add"]), #11 -> store
    (0,     1,     0,     0,     1,     0,      0,      0,      0,      op_dict["add"]), #12 -> storei
    (1,     0,     1,     1,     0,     0,      0,      1,      0,      op_dict["add"]), #13 -> jmpe
    (1,     0,     1,     0,     0,     0,      0,      1,      0,      op_dict["add"]), #14 -> jmpei
    (1,     0,     1,     1,     0,     0,      0,      1,      1,      op_dict["add"]), #15 -> jmple
    (1,     0,     1,     0,     0,     0,      0,      1,      1,      op_dict["add"]), #16 -> jmplei
    (1,     0,     1,     1,     0,     0,      1,      1,      0,      op_dict["add"]), #17 -> jmpge
    (1,     0,     1,     0,     0,     0,      1,      1,      0,      op_dict["add"]), #18 -> jmpgei
    (1,     0,     1,     1,     0,     0,      0,      0,      1,      op_dict["add"]), #19 -> jmpl
    (1,     0,     1,     0,     0,     0,      0,      0,      1,      op_dict["add"]), #20 -> jmpli
    (1,     0,     1,     1,     0,     0,      1,      0,      0,      op_dict["add"]), #21 -> jmpg
    (1,     0,     1,     0,     0,     0,      1,      0,      0,      op_dict["add"]), #22 -> jmpgi
    (1,     0,     1,     1,     0,     0,      1,      0,      1,      op_dict["add"]), #23 -> jmpd
    (1,     0,     1,     0,     0,     0,      1,      0,      1,      op_dict["add"]), #24 -> jmpdi
    (1,     0,     0,     1,     0,     0,      0,      0,      0,      op_dict["shl"]), #25 -> shl
    (1,     0,     0,     0,     0,     0,      0,      0,      0,      op_dict["shl"]), #26 -> shli
    (1,     0,     0,     1,     0,     0,      0,      0,      0,      op_dict["shr"]), #27 -> shr
    (1,     0,     0,     0,     0,     0,      0,      0,      0,      op_dict["shr"]), #28 -> shri
    (0,     1,     0,     1,     1,     1,      0,      0,      0,      op_dict["add"]), #29 -> push
    (0,     1,     0,     0,     1,     1,      0,      0,      0,      op_dict["add"]), #30 -> pushi
    (0,     0,     0,     1,     1,     1,      0,      0,      0,      op_dict["add"])  #31 -> pop
]

zero_padding = Constant("0" * (IMM_SIZE - REG_SIZE))
one_padding = Constant("1" * (IMM_SIZE - REG_SIZE))

def set_flags(opcode):
    MR, MW, JMP, ALUSRC, OP0SRC, STACK, Sup, Eq, Inf, OPALU = arbitrary_sized_multiplexer(Slice(0, REG_SIZE-1, opcode), opcode_conversion_list)
    Ra = Slice(REG_SIZE, 2 * REG_SIZE - 1, opcode)
    Rb = Slice(2 * REG_SIZE, 3 * REG_SIZE - 1, opcode)
    Rw = Slice(3 * REG_SIZE, 4 * REG_SIZE - 1, opcode)
    not_extended_imm = Slice(4 * REG_SIZE, INSTRUCTION_SIZE - 1)
    Imm = Concat(Mux(not_extended_imm[0], zero_padding, one_padding), not_extended_imm)
    return MR, MW, JMP, ALUSRC, OP0SRC, STACK, Sup, Eq, Inf, OPALU, Ra, Rb, Rw, Imm
