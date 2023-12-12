# Assuming sleep_data is your dataset
library(tidyverse)
sleep_data <- read_csv("source_data/sleep_health_and_lifestyle_dataset.csv")
sleep_data$Systolic_BP <- as.numeric(sub("\\/.*", "", sleep_data$`Blood Pressure`))
sleep_data$Diastolic_BP <- as.numeric(sub(".*\\/", "", sleep_data$`Blood Pressure`))
sleep_data$`BMI Category` <- ifelse(sleep_data$`BMI Category` == "Normal Weight", "Normal", sleep_data$`BMI Category`)
character_columns <- sapply(sleep_data, is.character)
sleep_data[, character_columns] <- lapply(sleep_data[, character_columns], tolower)
names(sleep_data) <- tolower(names(sleep_data))
names(sleep_data) <- gsub("\\s+", "_", names(sleep_data))
install.packages("randomForest")
library(randomForest)
set.seed(118)  # for reproducibility

# Define the features and target variable
features <- c("age", "gender", "sleep_duration", "quality_of_sleep", 
              "physical_activity_level", "stress_level", "bmi_category", "sleep_disorder",
              "systolic_bp", "diastolic_bp", "heart_rate", "daily_steps")

target_variable <- "occupation"

# Convert other categorical variables to factors
sleep_data$gender <- as.factor(sleep_data$gender)
sleep_data$bmi_category <- as.factor(sleep_data$bmi_category)
sleep_data$sleep_disorder <- as.factor(sleep_data$sleep_disorder)
sleep_data$occupation <- as.factor(sleep_data$occupation)


# Create a random forest model
model <- randomForest(formula(paste(target_variable, "~", paste(features, collapse = "+"))),
                      data = sleep_data)

# Print the model summary (optional)
print(model)