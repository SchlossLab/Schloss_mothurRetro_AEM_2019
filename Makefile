# utility function to print various variables. For example, running the
# following at the command line:
#
#	make print-BAM
#
# will generate:
#	BAM=data/raw_june/V1V3_0001.bam data/raw_june/V1V3_0002.bam ...
print-%:
	@echo '$*=$($*)'



################################################################################
#
# Render the manuscript
#
################################################################################

#submission/figure_1.ps : results/figures/scfa_comparisons.pdf
#	pdf2ps $^ $@


#%.png : %.ps
#	convert -density 300 $^ $@


submission/manuscript.pdf submission/manuscript.md submission/manuscript.tex : \
#		submission/figure_1.ps
		$(FINAL)/manuscript.Rmd\
		$(FINAL)/references.bib $(FINAL)/mbio.csl $(FINAL)/header.tex
	R -e 'library(rmarkdown); render("submission/manuscript.Rmd", clean=FALSE)'
	mv submission/manuscript.knit.md submission/manuscript.md
	rm submission/manuscript.utf8.md


submission/manuscript.docx : submission/manuscript.tex
	pandoc $< -o $@


# module load perl-modules latexdiff/1.2.0
# submission/marked_up.pdf : submission/manuscript.tex
# 	git cat-file -p d2a784e63f58566232ff:submission/manuscript.tex > submission/manuscript_old.tex
# 	latexdiff submission/manuscript_old.tex submission/manuscript.tex > submission/marked_up.tex
# 	pdflatex -output-directory=submission submission/marked_up.tex
# 	rm submission/marked_up.aux
# 	rm submission/marked_up.log
# 	rm submission/marked_up.out
# 	rm submission/marked_up.tex
# 	rm submission/manuscript_old.tex
#
#
# submission/response_to_reviewers.pdf : submission/response_to_reviewers.md submission/header.tex
# 	pandoc -s --include-in-header=submission/header.tex -V geometry:margin=1in -o $@ $<
