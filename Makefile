all: chess-openings.pdf

chess-openings.pdf: src/open.tex src/semi.tex src/closed.tex src/indian.tex chess-openings.tex
	mkdir -p build
	pdflatex --output-directory=build chess-openings.tex
	cp build/chess-openings.pdf .

src/open.tex: src/*-o-*.tex
	./tools/converter.bash 4 src/open.tex o

src/semi.tex: src/*-s-*.tex
	./tools/converter.bash 4 src/semi.tex s

src/closed.tex: src/*-c-*.tex
	./tools/converter.bash 4 src/closed.tex c

src/indian.tex: src/*-n-*.tex
	./tools/converter.bash 4 src/indian.tex n

clean:
	rm -rf build chess-openings.pdf