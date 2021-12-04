# makefile

all: open_pdf

gb.csv:
	mv g*.csv gb.csv
	touch gb.csv

students.tex: gb.csv
	julia process.jl

all_students.pdf: students.tex 
	rm -f latex.out/progress.pdf
	latexmk progress.tex
	mv progress.pdf all_students.pdf

.PHONY: clean open_pdf
clean:
	rm -f students.tex 
	rm -f all_students.pdf
	rm -f progress.pdf
	rm -rf latex.out/

open_pdf: all_students.pdf
	open all_students.pdf

