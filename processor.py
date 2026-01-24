from lib_carotte import *
from settings import *
from memory import update_registers
from ALU import op_ALU
from jump_block import jump_block
from decoder import set_flags
allow_ribbon_logic_operations(True)


def main():
	opcode = ROM(REG_ADDR_SIZE, WORD_SIZE, Reg(Defer(REG_ADDR_SIZE, lambda:PC)))
	MR_flag, MW_flag, JMP_flag, ALUSRC_flag, OP0SRC_flag, STACK_flag, Sup, Eq, Inf, OP_flag, Ra, Rb, Rw, Imm = set_flags(opcode)

	will_jump = jump_block(Reg(Defer(1, V)), Reg(Defer(1, N)), Reg(Defer(1,Z)), Sup, Eq, Inf, JMP_flag)
	jump_reg = Mux(will_jump, Constant("0" * REG_SIZE), Constant("0" * (REG_SIZE - 2) + "10"))
	write_reg = Mux(JMP_flag, Rw, jump_reg)


	previous_reg_addr_write = Reg(Defer(REG_ADDR_SIZE, lambda:write_reg)) #keep these 3 lines as they are
	previous_reg_data_write = Reg(Defer(REG_SIZE, lambda:reg_data_write)) 
	reg_data_A, reg_data_B, SP, PC = update_registers(Ra, Rb, previous_reg_addr_write, previous_reg_data_write, STACK_flag, MW_flag)


	imm_or_rb = Mux(ALUSRC_flag, Imm, reg_data_B)
	second_entry_ALU = Mux(OP0SRC_flag, Constant("0" * REG_SIZE), imm_or_rb)
	result_ALU, V, N, Z = op_ALU(OP_flag, reg_data_A, second_entry_ALU)

	ram_address = Mux(STACK_flag, SP, result_ALU)
	ram = RAM(REG_SIZE, WORD_SIZE, ram_address, MR_flag, ram_address, imm_or_rb)

	reg_data_write = Mux(MR_flag, ram, result_ALU)


	reg_data_A.set_as_output()
	reg_data_B.set_as_output()
