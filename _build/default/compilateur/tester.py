from sys import argv
file_name = argv[1]

def imm(n):
	if n >= 2**16:
		return n-2**17
	
	return n

with open(file_name, "rb") as file:
	while True:
		instr = file.read(4)
		if not instr:
			break
		
		instr = int.from_bytes(instr, "big")
		opcode = instr >> 27
		rw = (instr >> 22)%(2**5)
		ra = (instr >> 17)%(2**5)
		rb = instr%(2**17)
		if rb%(2**12):
			print(f"op:{opcode} rw:{rw} ra:{ra} imm:{imm(rb)}")
		
		else:
			print(f"op:{opcode} rw:{rw} ra:{ra} (imm:{imm(rb)} or reg:{rb >> 12})")
