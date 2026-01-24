from lib_carotte import *
from settings import *
from memory import update_registers
from ALU import op_ALU
from jump_block import jump_block
allow_ribbon_logic_operations(True)


def main():
	Ra = Input(REG_ADDR_SIZE)
	Rb = Input(REG_ADDR_SIZE)
	Rw = Input(REG_ADDR_SIZE)
	MR_flag = Input(1)
	MW_flag = Input(1)
	JMP_flag = Input(1)
	ALUSRC_flag = Input(1)
	OP0SRC_flag = Input(1)
	STACK_flag = Input(1)
	RET_flag = Input(1)
	CALL_flag = Input(1)
	Imm = Input(IMM_SIZE)
	OP_flag = Input(OPCODE_SIZE)
	reg_data_write = Input(REG_SIZE)
	V = N = Z = Sup = Eq = Inf = Constant("0")
	


	will_jump = jump_block(V,N,Z,Sup,Eq,Inf,JMP_flag)
	jump_reg = Mux(will_jump, Constant("0" * REG_SIZE), Constant("0" * 30 + "10"))
	write_reg = Mux(JMP_flag, Rw, jump_reg)


	previous_reg_addr_write = Reg(Defer(REG_ADDR_SIZE, lambda:write_reg)) #keep these 3 lines as they are
	previous_reg_data_write = Reg(Defer(REG_SIZE, lambda:reg_data_write)) 
	reg_data_A, reg_data_B, SP, PC = update_registers(Ra, Rb, previous_reg_addr_write, previous_reg_data_write, STACK_flag, MW_flag)


	imm_or_rb = Mux(ALUSRC_flag, Imm, reg_data_B)
	second_entry_ALU = Mux(OP0SRC_flag, Constant("0" * REG_SIZE), imm_or_rb)
	result_ALU = op_ALU(OP_flag, reg_data_A, second_entry_ALU)

	ram_address = Mux(STACK_flag, SP, result_ALU)
	ram = RAM(REG_SIZE, WORD_SIZE, ram_address, MR_flag, ram_address, imm_or_rb)

	reg_data_write = Mux(MR_flag, ram, result_ALU)


	reg_data_A.set_as_output()
	reg_data_B.set_as_output()
