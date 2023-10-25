setwd(getwd())
library(tidyverse)

data1 <- read_csv("derived_data/Sleep_health_and_lifestyle_dataset.csv")

figure_1 <- ggplot(data1) + geom_histogram(aes(x=Age))
ggsave(filename="figures/figure1.png", plot=figure_1)


figure_2 <- ggplot(data1) + geom_boxplot(aes(x=`Sleep Duration`))
ggsave(filename="figures/figure2.png", plot=figure_2)
