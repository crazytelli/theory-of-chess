all:
	cd chess-openings && $(MAKE) all
	cd chess-rules && $(MAKE) all
	cp */*.pdf .

clean:
	cd chess-openings && $(MAKE) clean
	cd chess-rules && $(MAKE) clean
	find . -maxdepth 1 -type f -name '*.pdf' -print -delete