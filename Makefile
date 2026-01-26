all:
	dune build netlist_simulator/
	dune build compilateur/
	python3 carotte.py -o processor_netlists processor.py

clean:
	dune clean

.PHONY: all clean
