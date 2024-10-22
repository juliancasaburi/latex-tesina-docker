#!/bin/bash

# Navigate to the working directory
cd /latex

# Use latexmk to compile the document
echo "Compiling LaTeX documents using latexmk..."

# Compile the LaTeX document with bibtex support
echo "" | latexmk -pdf -pdflatex="pdflatex -shell-escape" -use-make *.tex

# Check for the presence of an index command in the .tex file
if grep -q '\\makeindex' *.tex; then
    echo "Generating index..."
    makeindex *.idx
fi

# Clean up auxiliary files
rm -f *.aux *.lof *.log *.lot *.fls *.out *.toc *.fmt *.fot *.cb *.cb3 *.lb *.bbl *.bcf *.blg *.xml *.fdb_latexmk *.synctex *.synctex\(busy\) *.pdfsync *.alg *.loa *.nav *.pre *.snm *.vrb *.acn *.acr *.glg *.glo *.gls *.glsdefs *.lzo *.lzs *.slg *.slo *.sls *.nlg *.nlo *.nls *.xdy *idx *ilg *ind *lol
rm -rf _minted-main

echo "Compilation completed."
