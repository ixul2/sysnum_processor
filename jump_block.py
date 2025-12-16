from lib_carotte import *
from settings import *


def full_adder(a, b, c):
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
		
	return concat_res

def compute_next_address(PC,Imm,V,N,Z,Sup,Eq,Inf,Jmp,Call,Res,Ret):
	is_jump = Jmp & (((Sup & (~N)) & (~Z)) | (N & Inf) | (Z & Eq) | (((V & (~Sup)) & (~Inf)) & (~Eq)))
	incr = Mux(is_jump,Constant("1"),Imm)
	new_address = nadder(PC,incr)
	return(Mux(Ret,Mux(Call,Imm,new_address),Res))