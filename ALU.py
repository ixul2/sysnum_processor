from lib_carotte import *
from settings import *
from functools import *
from memory import update_registers
allow_ribbon_logic_operations(True)

def bitwise_op(a, b, op):
    assert(a.bus_size == b.bus_size)
    c = [op(a[i], b[i]) for i in range(a.bus_size)]
    return reduce(lambda s, r: s + r, c[-1], c)

def carry_lookahead(a, b, c, g, p):
    

def main():
    a = Input(REG_SIZE)
    b = Input(REG_SIZE)
    ctrl = Input(3)
      
    r_or = bitwise_op(a, b, lambda x, y: x | y)
    r_and = bitwise_op(a, b, lambda x, y: x & y)
    r_xor = bitwise_op(a, b, lambda x, y: x ^ y)
    r_not = bitwise_op(a, b, lambda _, y: ~y)

    r_lshift = ...
    r_rshift = ...
	
    r_sum = carry_lookahead(a, Mux(ctrl[2], b, r_not), ctrl[2], r_and, r_xor)

    r_bw = Mux(ctrl[1], Mux(ctrl[2], r_or, r_and), Mux(ctrl[2], r_xor, r_not))
    r_s = Mux(ctrl[2], r_rshift, r_lshift)
    r = Mux(ctrl[0], Mux(ctrl[1], r_s, r_sum), r_bw)

    r.set_as_output()
