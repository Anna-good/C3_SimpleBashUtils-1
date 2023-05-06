CC=gcc
CFLAGS=-Wall -Werror -Wextra -std=c11 -pedantic -c #-fsanitize=address
LFLAGS=#-fsanitize=address
DEBUGFLAGS=-g

all: s21_cat

s21_cat: s21_cat.o ../common/s21_getline.o
	$(CC) $(LFLAGS) $^ -o $@ $(DEBUGFLAGS)

s21_cat.o: s21_cat.c
	$(CC) $(CFLAGS) $< -o $@ $(DEBUGFLAGS)

../common/s21_getline.o: ../common/s21_getline.c ../common/s21_getline.h
	$(CC) $(CFLAGS) $< -o $@ $(DEBUGFLAGS)

clean:
	rm -rf *.o s21_cat ../common/*.o
