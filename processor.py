from lib_carotte import *
from settings import *
from memory import update_registers, read_registers
from ALU import op_ALU, nadder
from jump_block import jump_block
from decoder import set_flags
allow_ribbon_logic_operations(True)


def main():
	opcode = ROM(REG_SIZE, WORD_SIZE, Reg(Defer(REG_SIZE, lambda:PC)))
	MR_flag, MW_flag, JMP_flag, ALUSRC_flag, OP0SRC_flag, STACK_flag, Sup, Eq, Inf, OP_flag, Ra, Rb, Rw, Imm = set_flags(opcode)

	will_jump = jump_block(Reg(Defer(1, lambda:V)), Reg(Defer(1, lambda:N)), Reg(Defer(1, lambda:Z)), Sup, Eq, Inf, JMP_flag)
	jump_reg = Mux(will_jump, Constant("".rjust(REG_ADDR_SIZE, "0")), Constant("10".rjust(REG_ADDR_SIZE, "0")))
	write_reg = Mux(JMP_flag, Rw, jump_reg)

	reg_data_A, reg_data_B = read_registers(Ra, Rb)

	imm_or_rb = Mux(ALUSRC_flag, Imm, reg_data_B)
	second_entry_ALU = Mux(OP0SRC_flag, imm_or_rb, Constant("0" * REG_SIZE))
	result_ALU, V, N, Z = op_ALU(OP_flag, reg_data_A, second_entry_ALU)

	reg_sp = Reg(Defer(REG_SIZE, lambda:SP))
	reg_sp_adder = nadder(reg_sp, Constant("00".rjust(REG_SIZE, "1")), Constant("0"))[0]
	ram_address = Mux(STACK_flag, result_ALU, Mux(MW_flag, reg_sp, reg_sp_adder))
	ram = RAM(REG_SIZE, WORD_SIZE, ram_address, MW_flag, ram_address, imm_or_rb)

	reg_data_write = Mux(MR_flag, ram, result_ALU)
	SP, PC = update_registers(write_reg, reg_data_write, STACK_flag, MW_flag, will_jump)

	PC.set_as_output()
	opcode.set_as_output()
	#write_reg.set_as_output()
	reg_data_A.set_as_output()
	second_entry_ALU.set_as_output()
	result_ALU.set_as_output()
	#SP.set_as_output()

