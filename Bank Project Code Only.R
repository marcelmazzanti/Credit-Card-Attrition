#installing and calling used packages 
library(tidyverse)
#package to use a specific theme for graphs (install if necessary)
#install.packages("ggthemes")
#install.packages("ggpubr")
library(ggthemes)
library(ggpubr)
library(broom)
library(tidyverse)
#install.packages("rms")
library(rms)
#install.packages("yardstick")
library(yardstick)


#reading the dataset
data <- read_csv("./Bank.csv")
#showing first rows
data %>% 
  head(n=10)

#no missing values in the data-set
#sum(is.na(data))

#demographics stacked bar charts for attrition
data %>% 
  select(Attrition) %>% 
  group_by(Attrition) %>% 
  count()


data %>% 
  ggplot(., mapping = aes(Gender, fill = Attrition)) +
  geom_bar(position = "fill") +
  coord_flip()+
  labs(title = "Gender", subtitle = "Based on attrition", caption = "Figure 1")+
  theme_minimal()

data %>% 
  filter(MaritalStatus!= "Unknown") %>% 
  ggplot(., mapping = aes(MaritalStatus, fill = Attrition)) +
  geom_bar(position = "fill") +
  coord_flip()+
  labs(title = "Marital Satus", subtitle = "Based on attrition", caption = "Figure 2")+
  theme_minimal()

data %>% 
  filter(EducationLevel!= "Unknown") %>% 
  ggplot(., mapping = aes(EducationLevel, fill = Attrition)) +
  geom_bar(position = "fill") +
  coord_flip()+
  labs(title = "Educational Level", subtitle = "Based on attrition", caption = "Figure 3")+
  theme_minimal()


#run for all demographics to make sure proportion is balanced
#data %>% 
#select(Gender) %>% 
#group_by(Gender) %>% 
#count()


#creating histogram for age over lost customers
ggplot(data, aes(x=Age, fill=Attrition))+
  geom_histogram(position = "dodge")+
  labs(title = "Age", subtitle = "Distribution based on attrition", caption = "Figure 4")+
  theme_minimal()


#excluding unknown values and creating a bar chart for lost customers over income category
data %>% 
  filter(IncomeCategory!="Unknown") %>% 
  ggplot(., mapping = aes(IncomeCategory)) +
  geom_bar(mapping = aes(fill=Attrition)) +
  labs(title = "Income Category", subtitle = "Based on attrition", caption = "Figure 5")+
  theme_minimal()


#plotting transaction count and amount over lost customers
ggplot(data, aes(x=CreditLimit)) +
  geom_freqpoly(mapping = aes(color = Attrition))+
  labs(title = "Credit Card Limit", subtitle = "Based on attrition", caption = "Figure 6")+
  theme_minimal()


#plotting relationship count based on attrition
data %>% 
  ggplot(., mapping = aes(x=RelationshipCount, fill=Attrition)) +
  geom_bar(position = "dodge") +
  labs(title = "Relationship Count", subtitle = "Based on attrition", caption = "Figure 7")+
  theme_minimal()


#creating scatterplot of transactions over lost customers
ggplot(data = data, mapping = aes(x =TotalTransCt , y = TotalTransAmt)) + 
  geom_point(mapping = aes(colour = Attrition))+
  geom_hline(yintercept = 6500, linetype= "dotted")+
  geom_hline(yintercept = 11500, linetype= "dotted")+
  labs(title = "Transactions Amount and Count", subtitle = "Based on attrition", caption = "Figure 8")+
  theme_minimal()


#density of utilization ratio by lost customers
data %>% 
  ggplot(., mapping = aes(AvgUtilizationRatio, color= Attrition)) +
  geom_density() +
  labs(title = "Average Utilization Ratio", subtitle = "Based on attrition", caption = "Figure 9")+
  theme_minimal()


#Bar charts for contacts and inactivity in the last 12 Months for lost customers
ggplot(data = data, mapping = aes(Contacts12Mon, fill = Attrition)) + 
  geom_bar(position = "dodge")+
  labs(title = "Contacts Count in the last 12 Months", subtitle = "Based on attrition", caption = "Figure 10")+
  theme_minimal()

ggplot(data = data, mapping = aes(Inactive12Mon , fill = Attrition)) + 
  geom_bar(position = "dodge")+
  labs(title = "Inactive in the last 12 Months", subtitle = "Based on attrition", caption = "Figure 11")+
  theme_minimal()


#boxplots to show outliers 
bp1<-ggplot(data, mapping = aes(x = MonthsOnBook, fill= Attrition )) + 
  geom_boxplot()+
  labs(title = "Months on the Book", caption = "Figure 12")+
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())
bp2<-ggplot(data, mapping = aes(x =TotalRevolvingBal , fill= Attrition )) + 
  geom_boxplot()+
  labs(title = "Revolving Balance", caption = "Figure 13")+
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank())

ggarrange(bp1,bp2,
          labels = c("",""),
          ncol = 1, nrow = 2)


data %>% 
  group_by(Attrition) %>% 
  summarise("Average MonthsOnBook" = round(mean(MonthsOnBook),2))


#Train sample:
#set.seed(100)
#data_t <- data %>% 
#mutate(DummyAttrition = ifelse(Attrition == "Attrited Customer", 1, 0)) %>% 
#slice_sample(prop = 0.8)

#create data with dummy variable to be predicted and running logistic regression
data_r <- data %>% 
  mutate(DummyAttrition = ifelse(Attrition == "Attrited Customer", 1, 0))

model <- glm(data= data_r, formula = DummyAttrition ~ RelationshipCount +	Inactive12Mon +	Contacts12Mon +	TotalRevolvingBal +	TotalTransAmt	+ TotalTransCt , family = "binomial" (link = "logit"))

broom::tidy(model)

#broom::augment(model) %>% 
#select(.fitted, .resid)


#Logistic regression with Frank Harrell's rms package

#model <- lrm(data,formula = Attrition ~ RelationshipCount +	Inactive12Mon +	Contacts12Mon +	TotalRevolvingBal +	TotalTransAmt	+ TotalTransCt)

#model


#creating column with predicted values between 1 and 0
data_r$AttritionRisk <- predict(model, data_r, type = "response") 


#distribution of leaving probability and actual observed cases
data_r %>% 
  ggplot(., aes(AttritionRisk, fill= Attrition)) + 
  geom_histogram(position = "dodge")+
  labs(title = "Predicted Probability of Attrition", subtitle= "Based on actual attrited observations", caption = "Figure 14")+
  theme_minimal()


data_r$PredictAttrition <- ifelse(data_r$AttritionRisk > 0.5, 1, 0)
Accuracy <- as_tibble(mean(data_r$DummyAttrition == data_r$PredictAttrition)) %>% 
  round(digits = 2)

Accuracy


#confusion matrix values stored in a table
CMatrix <- table(data_r$DummyAttrition, data_r$PredictAttrition)



#plotting confusion matrix table for better output
vector_obs_pred<-c(8179,807,321,820)
matrix_obs_pred<-matrix(data = vector_obs_pred, nrow = 2, ncol = 2)
colnames(matrix_obs_pred) <- c("0","1") 
rownames(matrix_obs_pred) <- c("0","1") 



cm <- conf_mat(matrix_obs_pred, "1", "2")

autoplot(cm, type = "heatmap") +
  scale_fill_gradient(low="#F8766D",high = "#00BFC4") + 
  labs(fill="Frequency") + 
  theme(legend.position = "right") + 
  labs(x = "Predicted") + 
  labs(y = "Observed")


set.seed(5000)
#changing the seed gives the opportunity to use AIC and compare which testing model backs up the most the assumptions that are made
#running the model again with test sample
data_test <- data %>% 
  mutate(DummyAttrition = ifelse(Attrition == "Attrited Customer", 1, 0)) %>% 
  slice_sample(prop = 0.7)

model_test <- glm(data= data_test, formula = DummyAttrition ~ RelationshipCount +	Inactive12Mon +	Contacts12Mon +	TotalRevolvingBal +	TotalTransAmt	+ TotalTransCt, family = "binomial" (link = "logit"))

broom::tidy(model_test)


#creating column to make prediction as dummy based on a threshold and calculate accuracy for test model
data_test$AttritionRisk <- predict(model_test, data_test, type = "response")

data_test$PredictAttrition <- ifelse(data_test$AttritionRisk > 0.5, 1, 0)
Accuracy_test <- as_tibble(mean(data_test$DummyAttrition == data_test$PredictAttrition)) %>% 
  round(digits = 2)
#creating confusion matrix for test model
CMatrix_test <- table(data_test$DummyAttrition, data_test$PredictAttrition)


#plotting confusion matrix table for better output on test model
vector_obs_pred<-c(5714,557,232,585)
matrix_obs_pred<-matrix(vector_obs_pred, nrow = 2, ncol = 2)
colnames(matrix_obs_pred) <- c("0","1") 
rownames(matrix_obs_pred) <- c("0","1") 

cm <- conf_mat(matrix_obs_pred, "1", "2")

autoplot(cm, type = "heatmap") +
  scale_fill_gradient(low="#F8766D",high = "#00BFC4") + 
  labs(fill="Frequency") + 
  theme(legend.position = "right") + 
  labs(x = "Predicted") + 
  labs(y = "Observed")




