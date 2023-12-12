#Script on sleep 

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

data2$freq3 <- ave(1:nrow(data2), data2$quality_of_sleep, data2$stress_level, FUN = length)
figure_4 <- ggplot(data2, aes(x=quality_of_sleep, y=stress_level, fill=freq3)) + geom_tile() +
  xlab("Quality of Sleep (1-10 scale)") + ylab("Stress Level (1-10 scale)") + 
  ggtitle("A Tile Graph Assessing Stress Level vs. Quality of Sleep")
ggsave(filename="figures/figure4_quality_sleep_stress_level.png", plot=figure_4,  width = 10, height = 10)

avg_sleep_by_job <- aggregate(sleep_duration ~ occupation, data = data2, FUN = mean)
figure_5 <- ggplot(data2, aes(x = occupation, y = sleep_duration)) +
  geom_bar(stat = "summary", fun = "mean", fill = "skyblue") +   
  geom_text(data = avg_sleep_by_job, aes(x = occupation, y = sleep_duration, label = 
                                           sprintf("%.2f", sleep_duration)),
            vjust = -0.5, color = "black", size = 3) + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  labs(
    title = "Average Sleep Duration by Job Profession",
    x = "Job Profession",
    y = "Average Sleep Duration (hours)"
  )
ggsave(filename="figures/figure5_sleep_duration_occupation.png", plot=figure_5, width = 10, height = 10)
