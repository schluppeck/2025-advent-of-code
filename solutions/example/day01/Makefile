# Makefile for compiling one.c
# might seem like overkill at first, but useful later
#
# ds 2025

default: one

one: one.c
	cc one.c -o one

clean:
	rm -f one

run: one
	# echo "compiling and running!"
	./one input.txt
