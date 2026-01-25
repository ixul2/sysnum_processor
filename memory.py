from lib_carotte import *
from settings import *
from ALU import nadder

registers = [None]*NB_REG

def to_binary(n, n_bits):
	return map(int, bin(n)[2:].rjust(n_bits, "0"))

def arbitrary_sized_multiplexer(c, registers, i = 0, a = 0, b = 32):
	if b-a == 2:
		return Mux(c[i], registers[a], registers[a+1])

	return Mux(
		c[i],
		arbitrary_sized_multiplexer(c, registers, i+1, a, (b+a)//2), 
		arbitrary_sized_multiplexer(c, registers, i+1, (b+a)//2, b))

def read_registers(reg_addr_read1, reg_addr_read2):
	old_registers = [None] * NB_REG
	for i in range(NB_REG):
		old_registers[i] = Reg(Defer(REG_SIZE, (lambda i: lambda: registers[i])(i)))
	reg_data1 = arbitrary_sized_multiplexer(reg_addr_read1, old_registers) 
	reg_data2 = arbitrary_sized_multiplexer(reg_addr_read2, old_registers)
	return reg_data1, reg_data2

def update_registers(reg_addr_write, reg_data_write, S_flag, MW_flag, will_jump):
	"""CODE IN CHARGE OF THE REGISTERS
	inputs: 
	reg_addr_read1 : REG_ADDR_SIZE bits
	reg_addr_read2 : REG_ADDR_SIZE bits
	reg_addr_write : REG_ADDR_SIZE bits
	reg_data_write : REG_SIZE bits
	Stack_flag : 1 bit

	outputs:
	reg_data1 : REG_SIZE bits
	reg_data2 : REG_SIZE bits
	SP : REG_SIZE bits
	"""

	for reg_n in range(1, NB_REG):
		cond = Constant("1")
		for i, digit in enumerate(to_binary(reg_n, REG_ADDR_SIZE)):
			if digit:
				cond = cond & reg_addr_write[i]

			else:
				cond = cond & (~reg_addr_write[i])
		
		current_register = (lambda reg_n: lambda:registers[reg_n])(reg_n)
		registers[reg_n] = Mux(cond, Reg(Defer(REG_SIZE, current_register)), reg_data_write)

	registers[0] = Constant("0"*REG_SIZE) #first register is always set to 0
	registers[1] = Mux(S_flag, 
		registers[1], 
		Mux(MW_flag, 
	  		nadder(registers[1], Constant("100".rjust(REG_SIZE, "0")), Constant("0"))[0],
			nadder(registers[1], Constant("00".rjust(REG_SIZE, "1")), Constant("0"))[0]))
	
	SP = registers[1] #SP is the first register
	
	registers[2] = Mux(will_jump, nadder(registers[2], Constant("100".rjust(REG_SIZE, "0")), Constant("0"))[0], registers[2])
	PC = registers[2]
	
	return SP, PC
