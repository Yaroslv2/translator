all: lexer parser compile run

lexer: lexer.l
	flex lexer.l
	mv lex.yy.c ./src/

parser: parser.y
	bison -d -v parser.y --debug
	mv parser.tab.c ./src/
	mv parser.tab.h ./src/

compile: ./src/parser.tab.c ./src/lex.yy.c
	gcc ./src/parser.tab.c ./src/lex.yy.c -o ./build/translator

run: ./build/translator
	./build/translator > ./output/program_output.txt
	mv parser.output ./output/