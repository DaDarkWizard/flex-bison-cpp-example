SRCS = CminusScanner.cpp CminusParser.cpp
LEX_SRCS = CminusScanner.l
YACC_SRCS = CminusParser.y
CC = g++
CFLAGS = 
ENV = -g

TARGET = tester

INCLUDES= -I. \
	  -I..

CFLAGS	= $(INCLUDES) -DYYERROR_VERBOSE $(ENV) 
LEX	= flex
LFLAGS = 
YACC	= bison
YFLAGS	= 
ARFLAGS = ru

CFILES = scanner.cc parser.cc
HFILES = parser.h
OFILES = scanner.o parser.o driver.o exprtest.o

RM = /bin/rm -f


$(TARGET): scanner.o parser.o driver.o exprtest.o
	$(CC) $(CFLAGS) scanner.o parser.o driver.o exprtest.o -o $(TARGET)

exprtest.o: driver.cc expression.h
	$(CC) -c $(CFLAGS) exprtest.cc

driver.o: driver.h driver.cc scanner.h
	$(CC) -c $(CFLAGS) driver.cc

scanner.o: scanner.cc
	$(CC) -c $(CFLAGS) scanner.cc

parser.o: parser.cc
	$(CC) -c $(CFLAGS) parser.cc

scanner.cc: parser.h scanner.ll
	$(LEX) scanner.ll

parser.h parser.cc: parser.yy
	$(YACC) -d parser.yy

.PHONY: clean

clean:
	$(RM) $(CFILES) $(HFILES) $(OFILES)


# DO NOT DELETE THIS LINE -- make depend depends on it.