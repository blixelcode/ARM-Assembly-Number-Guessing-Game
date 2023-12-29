main: main.o
	ld -o main main.o print.o
	rm *.o
main.o: main.s
	as -g -o main.o main.s
	as -g -o print.o print.s
clean:
	rm *.o main
