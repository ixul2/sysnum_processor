from lib_carotte import *
from settings import *
allow_ribbon_logic_operations(True)


def jump_block(V,N,Z,Sup,Eq,Inf,Jmp):
	is_jump = Jmp & (((Sup & (~N)) & (~Z)) | (N & Inf) | (Z & Eq) | (((V & (~Sup)) & (~Inf)) & (~Eq)))
	return is_jump