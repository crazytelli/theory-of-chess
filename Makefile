all:
	cd chess-openings && $(MAKE) all
	cp chess-openings/chess-openings.pdf .

clean:
	cd chess-openings && $(MAKE) clean
	find . -maxdepth 1 -type f -name '*.pdf' -print -delete