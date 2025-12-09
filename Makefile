#!/usr/bin/make

.PHONY: all clean
.SUFFIXES: .txt .html

default: README.html

README.html: README.md
	@pandoc -s --toc -c public/style.css $< -o $@
	-mv README.html public/index.html

clean:
	@$(RM) -rf *.log *.html cache figure
