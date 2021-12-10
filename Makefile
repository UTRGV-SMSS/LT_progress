# makefile

all: open_pdf

gb.csv:
	mv g*.csv gb.csv
	touch gb.csv

all_students.tex: gb.csv
	julia --project=. -e 'using Pkg; Pkg.instantiate()'
	julia --project=. process.jl

all_students.pdf: all_students.tex 
	rm -f latex.out/all_students.pdf
	rm -f all_students.pdf
	latexmk  all_students.tex

.PHONY: clean open_pdf
clean:
	rm -r students
	rm -f all_students.tex 
	rm -f all_students.pdf
	rm -rf latex.out/

open_pdf: all_students.pdf
	open all_students.pdf

