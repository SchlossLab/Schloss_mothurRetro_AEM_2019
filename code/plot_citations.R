library(tidyverse)

read_tsv('data/citations.tsv') %>%
	gather(-year, key="tool", value="citations") %>%
	filter(tool == "mothur") %>%
	ggplot(aes(x=year, y=citations)) +
		geom_line() +
		theme_classic() +
		labs(x="Year", y="Number of Citations") +
		scale_x_continuous(breaks=seq(2009,2019,2), labels=seq(2009,2019,2))

ggsave("figures/mothur_citations.pdf", width=6, height=4, units="in")
