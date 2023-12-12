#Script on activity levels and health metrics 

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

data2$freq <- ave(1:nrow(data2), data2$systolic_bp, data2$physical_activity_level, FUN = length)
figure_3a <- ggplot(data2, aes(x=systolic_bp, y=physical_activity_level)) + 
  geom_point((aes(size = freq))) + xlab("Systolic Blood Pressure") + 
  ylab("Physical Activity Level in Minutes/Day") + 
  ggtitle("Frequency Graph of Systolic Blood Pressure vs. Physical Activity Level in Minutes per Day")
ggsave(filename="figures/figure3a_systolic_bp_phys_level.png", plot=figure_3a,  width = 10, height = 10)

data2$freq2 <- ave(1:nrow(data2), data2$diastolic_bp, data2$physical_activity_level, FUN = length)
figure_3b <- ggplot(data2, aes(x=diastolic_bp, y=physical_activity_level)) + geom_point((aes(size = freq2))) +
  xlab("Diastolic Blood Pressure") + ylab("Physical Activity Level in Minutes/Day") + 
  ggtitle("Frequency Graph of Diastolic Blood Pressure vs. Physical Activity Level in Minutes per Day")
ggsave(filename="figures/figure3b_diastolic_bp_phys_level.png", plot=figure_3b,  width = 10, height = 10)






