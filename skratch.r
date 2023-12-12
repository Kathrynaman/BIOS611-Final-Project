#Script on age and sleep duration 

setwd("~/work/611bios/bios611-final-project")
library(tidyverse)

data1 <- read_csv("source_data/sleep_health_and_lifestyle_dataset.csv")
data1$Systolic_BP <- as.numeric(sub("\\/.*", "", data1$`Blood Pressure`))
data1$Diastolic_BP <- as.numeric(sub(".*\\/", "", data1$`Blood Pressure`))
data1$`BMI Category` <- ifelse(data1$`BMI Category` == "Normal Weight", "Normal", data1$`BMI Category`)
character_columns <- sapply(data1, is.character)
data1[, character_columns] <- lapply(data1[, character_columns], tolower)
names(data1) <- tolower(names(data1))
names(data1) <- gsub("\\s+", "_", names(data1))
data2 <- data1

figure_1 <- ggplot(data2) + geom_histogram(aes(x=age), bins=20) + ggtitle("Histogram of Ages in Years") + ylab("Count") + xlab("Age in Years")
ggsave(filename="figures/figure1_age_hist.png", plot=figure_1)

figure_2 <- ggplot(data2) + geom_boxplot(aes(x=sleep_duration)) + xlab("Sleep Duration in Hours") +
  ggtitle("Boxplot of Sleep Duration (Hours)")
ggsave(filename="figures/figure2_sleepduration_boxplot.png", plot=figure_2)
