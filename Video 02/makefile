main: main.o
	ld -o main main.o
	rm *.o
main.o: main.s
	as -g -o main.o main.s
clean:
	rm *.o main
