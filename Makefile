cronograma.pdf: cronograma.tex
	pdflatex cronograma.tex
	rm *.aux *.log
	xdg-open cronograma.pdf
