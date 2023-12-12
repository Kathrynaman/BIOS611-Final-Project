library(tidyverse)
library(matlab) 
sleep_data <- read_csv("source_data/sleep_health_and_lifestyle_dataset.csv")

sleep_data$Systolic_BP <- as.numeric(sub("\\/.*", "", sleep_data$`Blood Pressure`))
sleep_data$Diastolic_BP <- as.numeric(sub(".*\\/", "", sleep_data$`Blood Pressure`))
sleep_data$`BMI Category` <- ifelse(sleep_data$`BMI Category` == "Normal Weight", "Normal", sleep_data$`BMI Category`)
character_columns <- sapply(sleep_data, is.character)
sleep_data[, character_columns] <- lapply(sleep_data[, character_columns], tolower)
names(sleep_data) <- tolower(names(sleep_data))
names(sleep_data) <- gsub("\\s+", "_", names(sleep_data))

sleep_data_mod <- sleep_data
sleep_data_mod$gender_numeric <- as.integer(sleep_data$gender == "male")
sleep_data_mod$bmi_category_numeric <- as.integer(factor(sleep_data$bmi_category, levels = c("normal", "overweight", "obese")))
occupation_dummies <- model.matrix(~occupation - 1, data = sleep_data_mod)
colnames(occupation_dummies) <- gsub("occupation", "", colnames(occupation_dummies))
sleep_data_mod <- cbind(sleep_data_mod, occupation_dummies)
sleep_disorder_dummies <- model.matrix(~sleep_disorder - 1, data = sleep_data_mod)
colnames(sleep_disorder_dummies) <- gsub("sleep_disorder", "", colnames(sleep_disorder_dummies))
sleep_data_mod <- cbind(sleep_data_mod, sleep_disorder_dummies)

#principle component analysis (pca) with one hot encoded variables
numeric_data_only <- sleep_data_mod[, !names(sleep_data_mod) %in% c("person_id", "gender", "occupation", "bmi_category", "sleep_disorder", "blood_pressure")]
normalized_data <- scale(numeric_data_only)
pca_result <- prcomp(normalized_data, center = TRUE, scale. = TRUE)
imagesc(pca_result$x)
summary(pca_result)

ggplot(pca_result$x %>% as_tibble() %>% select(PC1, PC2), aes(PC1, PC2)) +
  geom_point()

#re-trying PCA with only original numeric variables, likely better 
numeric_data_og <- sleep_data[, !names(sleep_data) %in% c("person_id", "gender", "occupation", "bmi_category", "sleep_disorder", "blood_pressure")]
normalized_data2 <- scale(numeric_data_og)
pca_result2 <- prcomp(normalized_data2, center = TRUE, scale. = TRUE)
imagesc(pca_result2$x)
summary(pca_result2)

pca1 <- ggplot(pca_result2$x %>% as_tibble() %>% select(PC1, PC2), aes(PC1, PC2)) +
  geom_point(aes(color=sleep_data$occupation)) + ggtitle("PCA: Colored by Occupation")
ggsave(filename="figures/pca1_occupation.png", plot=pca1, width = 10, height = 10)
pca2 <- ggplot(pca_result2$x %>% as_tibble() %>% select(PC1, PC2), aes(PC1, PC2)) +
  geom_point(aes(color=sleep_data$gender)) + ggtitle("PCA: Colored by Gender")
ggsave(filename="figures/pca2_gender.png", plot=pca2, width = 10, height = 10)
pca3 <- ggplot(pca_result2$x %>% as_tibble() %>% select(PC1, PC2), aes(PC1, PC2)) +
  geom_point(aes(color=sleep_data$bmi_category)) + ggtitle("PCA: Colored by BMI Category")
ggsave(filename="figures/pca3_bmi_category.png", plot=pca3, width = 10, height = 10)
pca4 <- ggplot(pca_result2$x %>% as_tibble() %>% select(PC1, PC2), aes(PC1, PC2)) +
  geom_point(aes(color=sleep_data$sleep_disorder)) + ggtitle("PCA: Colored by Sleep Disorder")
ggsave(filename="figures/pca4_sleep_disorder.png", plot=pca4, width = 10, height = 10)

