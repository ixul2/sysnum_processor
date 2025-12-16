from lib_carotte import *
from settings import *
from memory import update_registers
allow_ribbon_logic_operations(True)

def main():
	reg_addr_read1 = Input(REG_ADDR_SIZE) #Placeholder
	reg_addr_read2 = Input(REG_ADDR_SIZE)
	reg_addr_write = Input(REG_ADDR_SIZE)
	reg_data_write = Input(REG_SIZE)
	S_flag = Constant("0")
	MW_flag = Constant("0")
	
	previous_reg_addr_write = Reg(Defer(REG_ADDR_SIZE, lambda:reg_addr_write)) #keep these 3 lines as they are
	previous_reg_data_write = Reg(Defer(REG_SIZE, lambda:reg_data_write)) 
	reg_data1, reg_data2, SP = update_registers(reg_addr_read1, reg_addr_read2, previous_reg_addr_write, previous_reg_data_write, S_flag, MW_flag) 
	
	reg_data1.set_as_output()
	reg_data2.set_as_output()
