CC=gcc
CFLAGS=-Wall -Werror -Wextra -std=c11 -pedantic -c #-D _DEBUG #-fsanitize=address
LFLAGS=#-fsanitize=address
DEBUGFLAGS=-g

all: s21_grep

s21_grep: s21_grep.o ../common/s21_getline.o
	$(CC) $(LFLAGS) $^ -o $@ $(DEBUGFLAGS)

s21_grep.o: s21_grep.c
	$(CC) $(CFLAGS) $< -o $@ $(DEBUGFLAGS)

../common/s21_getline.o: ../common/s21_getline.c ../common/s21_getline.h
	$(CC) $(CFLAGS) $< -o $@ $(DEBUGFLAGS)

clean:
	rm -rf *.o s21_grep ../common/*.o
