library(tidyverse)

actual <- read_tsv('data/citations.tsv') %>%
	gather(-year, key="tool", value="citations") %>%
	filter(tool == "mothur") %>%
	select(-tool) %>%
	mutate(numbers = "actual")

projected <- actual %>%
	mutate(numbers = "projected") %>%
	mutate(citations = if_else(year == 2019, citations * 3/2, citations))

rbind(projected, actual)	%>%
	ggplot(aes(x=year, y=citations, color=reorder(numbers, desc(numbers)))) +
		geom_line(show.legend=FALSE) +
		scale_color_manual(values=c("gray", "black")) +
		theme_classic() +
		labs(x="Year", y="Number of Citations") +
		scale_x_continuous(breaks=seq(2009,2019,2), labels=seq(2009,2019,2))

ggsave("figures/mothur_citations.pdf", width=6, height=4, units="in")
