from lib_carotte import *
from settings import *

"""def full_adder(a, b, c):
	axb = a ^ b
	return (axb ^ c, (axb & c) | (a & b))

def nadder(a, b):
	assert(a.bus_size == b.bus_size)
	c = Constant("0")
	result = []
	for i in range(a.bus_size):
		i = a.bus_size-1-i
		r, c = full_adder(a[i], b[i], c)
		result.append(r)
	
	concat_res = result[0]
	for i in range(1, len(result)):
		concat_res = result[i] + concat_res
		
	return concat_res"""

def to_binary(n, n_bits):
	return map(int, bin(n)[2:].rjust(n_bits, "0"))

def arbitrary_sized_multiplexer(c, registers, i = 0):
	if len(registers) == 2:
		return Mux(c[i], registers[0], registers[1])

	return Mux(
		c[i],
		arbitrary_sized_multiplexer(c, registers[:len(registers)//2], i+1), 
		arbitrary_sized_multiplexer(c, registers[len(registers)//2:], i+1))


def update_registers(reg_addr_read1, reg_addr_read2, reg_addr_write, reg_data_write, S_flag, MW_flag):
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

	registers = [None]*NB_REG
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
	SP = registers[1] #SP is the first register
	#SP = Mux(S, SP, Mux(MW, ))
	
	reg_data1 = arbitrary_sized_multiplexer(reg_addr_read1, registers)
	reg_data2 = arbitrary_sized_multiplexer(reg_addr_read2, registers)
	return reg_data1, reg_data2, SP
