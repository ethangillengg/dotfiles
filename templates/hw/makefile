DOCNAME=presentation
PDFLATEX="pdflatex -synctex=1 -interaction=nonstopmode"

.PHONY: $(DOCNAME).pdf all clean

all: $(DOCNAME).pdf

$(DOCNAME).pdf: $(DOCNAME).tex
	latexmk -pdf -pdflatex=$(PDFLATEX) -use-make $(DOCNAME).tex

watch: $(DOCNAME).tex
	latexmk -pvc -pdf -pdflatex=$(PDFLATEX) -use-make $(DOCNAME).tex

clean:
	latexmk -CA

install:
	cp $(DOCNAME).pdf ${out}/

