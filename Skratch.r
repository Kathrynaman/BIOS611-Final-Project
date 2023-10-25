setwd(getwd())
library(tidyverse)

data1 <- read_csv("source_data/sleep_health_and_lifestyle_dataset.csv")

figure_1 <- ggplot(data1) + geom_histogram(aes(x=Age))
ggsave(filename="figures/figure1_age_hist.png", plot=figure_1)


figure_2 <- ggplot(data1) + geom_boxplot(aes(x=`Sleep Duration`))
ggsave(filename="figures/figure2_sleepduration_boxplot.png", plot=figure_2)
