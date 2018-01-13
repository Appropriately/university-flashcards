MAKEFLAGS=-s
.PHONY: all clean

default: all

PDF_FILES=$(patsubst %.tex,%.pdf,$(shell find . -type f -name *.tex ))

all: $(PDF_FILES)

%.pdf: %.tex
	while (pdflatex -halt-on-error -output-dir=$(dir $<) $< ;\
		grep -q "Rerun to get cross" $*.log) do true; \
	done

clean:
	-rm $(patsubst %.pdf,%.aux,$(PDF_FILES)) 2> /dev/null
	-rm $(patsubst %.pdf,%.log,$(PDF_FILES)) 2> /dev/null
	-rm $(PDF_FILES) 2> /dev/null
