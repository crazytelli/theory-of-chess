all: chess-rules.pdf

chess-rules.pdf: chess-rules.tex
	mkdir -p build
	pdflatex --output-directory=build chess-rules.tex
	cp build/chess-rules.pdf .

clean:
	rm -rf build chess-rules.pdf