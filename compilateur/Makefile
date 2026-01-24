
#all: test.s test.out
#	./test.out

pyret.exe:
	dune build pyretc.exe

#%.s: %.exp pyretc.exe
#	dune exec ./pyretc.exe $<

#%.out: %.s
#	gcc -g -no-pie $< -o $@

clean:
	dune clean

.PHONY: all clean arithc.exe
