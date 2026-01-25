import sys

sys.setrecursionlimit(100000)

from functools import cache

d = {}

with open("processor_netlists", "r") as file:
	for _ in range(4):
		file.readline()
		
	for line in file.readlines():
		line = line.strip().split()
		if len(line) > 3 and line[2] not in ("REG", "CONCAT", "SELECT"):
			d[line[0]] = [i for i in line[3:] if i.startswith("_")]


@cache
def depth(name):
	d_so_far = 0
	if name not in d:
		return 0
	
	for n in d[name]:
		if depth(n) > d_so_far:
			d_so_far = depth(n)
	
	return d_so_far+1

m = 0
for i in d:
	if depth(i) > m:
		m = depth(i)

print(m)
