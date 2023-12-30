main: main.o
	ld -o main main.o print.o random.o
	rm *.o
main.o: main.s
	as -g -o main.o main.s
	as -g -o print.o print.s
	as -g -o random.o random.s
clean:
	rm *.o main
