library(foreign)
library(tidyverse)
library(magrittr)
#where you will write the data to
setwd("~/Dropbox/Grayden's Project/Cleaned Data")

#Loading the raw data files, extension is where it currently is
blood_pressure = "../Raw Data/07-08/blood_pressure.XPT"
blood_pressure = read.xport(blood_pressure)

diabetes = "../Raw Data/07-08/diabetes.XPT"
diabetes = read.xport(diabetes)

medical_conditions = "../Raw Data/07-08/medical_conditions.XPT"
medical_conditions = read.xport(medical_conditions)

demographics = "../Raw Data/07-08/demographics.XPT"
demographics = read.xport(demographics)

body_measures = "../Raw Data/07-08/body_measures.XPT"
body_measures = read.xport(body_measures)

#Joining the datasets and selecting the variables I'm interested in
#The variables selected below are id, weights, RA, Age, systolic BP 
#measurements 1-4, diastolic BP measuremens 1-4, BMI, Diabetes, 
#Gender, MaritalStatus, IncomeRatio, Edu, Systolic, Diastolic

data = blood_pressure %>%
  inner_join(diabetes, by="SEQN") %>%
  inner_join(medical_conditions, by="SEQN") %>%
  inner_join(demographics, by="SEQN") %>%
  inner_join(body_measures, by="SEQN") %>%
  select(SEQN, WTMEC2YR, MCQ190, RIDAGEYR, 
         BPXSY1, BPXSY2, BPXSY3, BPXSY4, 
         BPXDI1, BPXDI2, BPXDI3, BPXDI4, 
         BMXBMI, DIQ010, RIAGENDR, DMDMARTL, INDFMPIR,DMDEDUC2)

#Averaging blood pressure data into two new columns, 
#dropping the raw measures
#BP was measured 3-4 times per patient, so we want the average 
#of all this


data %<>% mutate(Systolic = rowMeans(data[,c(5:8)], na.rm=TRUE), 
                 Diastolic = rowMeans(data[,c(9:12)], na.rm=TRUE)) %>%
  select(-BPXSY1, -BPXSY2, -BPXSY3, -BPXSY4, 
         -BPXDI1, -BPXDI2, -BPXDI3, -BPXDI4)


#Setting meaningful column names
names(data) <- c(
  'id', 'weights', 'RA', 'Age', 'BMI', 
  'Diabetes','Gender','MaritalStatus','IncomeRatio', 'Edu', 'Systolic', 'Diastolic'
) 

#Filtering
data %<>% filter(
  RA %in% c(1, NA), 
  Age>=20 & Age<80, 
  Diabetes!=9
)


#Setting meaningful factor levels
data$RA <- factor(data$RA, levels=c(1), labels=c('Rheumatoid'))
data$RA <- addNA(data$RA)
levels(data$RA)[2] <- 'No Arthritis'

#data <- data %>% filter(grepl('7|9|.', Edu))
#data <- data %>% filter(grepl('.', Gender))
#data <- data %>% filter(!grepl('77|99|.', MaritalStatus))

data$Diabetes <- factor(data$Diabetes, 
                        levels=c(1,2,3), 
                        labels=c('Diabetes', 
                                 'No Diabetes', 
                                 'Borderline'))

data$Gender <- factor(data$Gender, 
                        levels=c(1,2), 
                        labels=c('Male', 
                                 'Female'))

data$MaritalStatus <- factor(data$MaritalStatus, 
                        levels=c(1,2,3,4,5,6), 
                        labels=c('Married', 
                                 'Widowed', 
                                 'Divorced',
                                 'Separated',
                                 'Never Married',
                                 'Living with Partner'))

data$Edu <- factor(data$Edu, 
                             levels=c(1,2,3,4,5), 
                             labels=c('>9th Grade', 
                                      '9-11th Grade', 
                                      'High School Grad',
                                      'Some College',
                                      'College Grad'))

#Binning Age into 10 year segments
data$Age = ifelse(data$Age<30, "20-29",
           ifelse(data$Age<40, "30-39",
           ifelse(data$Age<50, "40-49",
           ifelse(data$Age<60, "50-59",
           ifelse(data$Age<70, "60-69", "70-79")))))

#Export to a csv for easy loading in the future
write_csv(data, '../Cleaned Data/07-08.csv')

#Give unique name for joining years
data -> df78

### 2009-2010


#Loading the raw data files
blood_pressure = "../Raw Data/09-10/blood_pressure.XPT"
blood_pressure = read.xport(blood_pressure)

diabetes = "../Raw Data/09-10/diabetes.XPT"
diabetes = read.xport(diabetes)

medical_conditions = "../Raw Data/09-10/medical_conditions.XPT"
medical_conditions = read.xport(medical_conditions)

demographics = "../Raw Data/09-10/demographics.XPT"
demographics = read.xport(demographics)

body_measures = "../Raw Data/09-10/body_measures.XPT"
body_measures = read.xport(body_measures)

#Joining the datasets and selecting the variables I'm interested in
data = blood_pressure %>%
  inner_join(diabetes, by="SEQN") %>%
  inner_join(medical_conditions, by="SEQN") %>%
  inner_join(demographics, by="SEQN") %>%
  inner_join(body_measures, by="SEQN") %>%
  select(SEQN, WTMEC2YR, MCQ191, RIDAGEYR, 
         BPXSY1, BPXSY2, BPXSY3, BPXSY4, 
         BPXDI1, BPXDI2, BPXDI3, BPXDI4, 
         BMXBMI, DIQ010, RIAGENDR, DMDMARTL, INDFMPIR, DMDEDUC2)

#Averaging blood pressure data into two new columns, dropping the raw measures
data %<>% mutate(Systolic = rowMeans(data[,c(5:8)], na.rm=TRUE), 
                 Diastolic = rowMeans(data[,c(9:12)], na.rm=TRUE)) %>%
  select(-BPXSY1, -BPXSY2, -BPXSY3, -BPXSY4, 
         -BPXDI1, -BPXDI2, -BPXDI3, -BPXDI4)


#Setting human readable column names
names(data) <- c(
  'id', 'weights', 'RA', 'Age', 'BMI', 
  'Diabetes', 'Gender','MaritalStatus','IncomeRatio', 'Edu', 'Systolic', 'Diastolic'
) 

#Filtering
data %<>% filter(
  RA %in% c(1, NA), 
  Age>=20 & Age<80, 
  Diabetes!=9
)


#Setting human readable factor levels
data$RA <- factor(data$RA, levels=c(1), labels=c('Rheumatoid'))
data$RA <- addNA(data$RA)
levels(data$RA)[2] <- 'No Arthritis'

data$Diabetes <- factor(data$Diabetes, 
                        levels=c(1,2,3), 
                        labels=c('Diabetes', 
                                 'No Diabetes', 
                                 'Borderline'))
data$Gender <- factor(data$Gender, 
                      levels=c(1,2), 
                      labels=c('Male', 
                               'Female'))

data$MaritalStatus <- factor(data$MaritalStatus, 
                             levels=c(1,2,3,4,5,6), 
                             labels=c('Married', 
                                      'Widowed', 
                                      'Divorced',
                                      'Separated',
                                      'Never Married',
                                      'Living with Partner'))

data$Edu <- factor(data$Edu, 
                   levels=c(1,2,3,4,5), 
                   labels=c('>9th Grade', 
                            '9-11th Grade', 
                            'High School Grad',
                            'Some College',
                            'College Grad'))

#Binning Age into 10 year segments
data$Age = ifelse(data$Age<30, "20-29",
           ifelse(data$Age<40, "30-39",
           ifelse(data$Age<50, "40-49",
           ifelse(data$Age<60, "50-59",
           ifelse(data$Age<70, "60-69", "70-79")))))

#Export to a csv for easy loading in the future
write_csv(data, '../Cleaned Data/09-10.csv')

#Give unique name for joining years
data -> df910


### 2011-2012

#Loading the raw data files
blood_pressure = "../Raw Data/11-12/blood_pressure.XPT"
blood_pressure = read.xport(blood_pressure)

diabetes = "../Raw Data/11-12/diabetes.XPT"
diabetes = read.xport(diabetes)

medical_conditions = "../Raw Data/11-12/medical_conditions.XPT"
medical_conditions = read.xport(medical_conditions)

demographics = "../Raw Data/11-12/demographics.XPT"
demographics = read.xport(demographics)

body_measures = "../Raw Data/11-12/body_measures.XPT"
body_measures = read.xport(body_measures)

#Joining the datasets and selecting the variables I'm interested in
data = blood_pressure %>%
  inner_join(diabetes, by="SEQN") %>%
  inner_join(medical_conditions, by="SEQN") %>%
  inner_join(demographics, by="SEQN") %>%
  inner_join(body_measures, by="SEQN") %>%
  select(SEQN, WTMEC2YR, MCQ195, RIDAGEYR, 
         BPXSY1, BPXSY2, BPXSY3, BPXSY4, 
         BPXDI1, BPXDI2, BPXDI3, BPXDI4, 
         BMXBMI, DIQ010, RIAGENDR, DMDMARTL, INDFMPIR, DMDEDUC2)

#Averaging blood pressure data into two new columns, dropping the raw measures
data %<>% mutate(Systolic = rowMeans(data[,c(5:8)], na.rm=TRUE), 
                 Diastolic = rowMeans(data[,c(9:12)], na.rm=TRUE)) %>%
  select(-BPXSY1, -BPXSY2, -BPXSY3, -BPXSY4, 
         -BPXDI1, -BPXDI2, -BPXDI3, -BPXDI4)


#Setting human readable column names
names(data) <- c(
  'id', 'weights', 'RA', 'Age', 'BMI', 
  'Diabetes', 'Gender','MaritalStatus','IncomeRatio', 'Edu', 'Systolic', 'Diastolic'
) 

#Filtering
data %<>% filter(
  RA %in% c(1, NA), 
  Age>=20 & Age<80, 
  Diabetes!=9
)


#Setting human readable factor levels
data$RA <- factor(data$RA, levels=c(1), labels=c('Rheumatoid'))
data$RA <- addNA(data$RA)
levels(data$RA)[2] <- 'No Arthritis'

data$Diabetes <- factor(data$Diabetes, 
                        levels=c(1,2,3), 
                        labels=c('Diabetes', 
                                 'No Diabetes', 
                                 'Borderline'))
data$Gender <- factor(data$Gender, 
                      levels=c(1,2), 
                      labels=c('Male', 
                               'Female'))

data$MaritalStatus <- factor(data$MaritalStatus, 
                             levels=c(1,2,3,4,5,6), 
                             labels=c('Married', 
                                      'Widowed', 
                                      'Divorced',
                                      'Separated',
                                      'Never Married',
                                      'Living with Partner'))

data$Edu <- factor(data$Edu, 
                   levels=c(1,2,3,4,5), 
                   labels=c('>9th Grade', 
                            '9-11th Grade', 
                            'High School Grad',
                            'Some College',
                            'College Grad'))

#Binning Age into 10 year segments
data$Age = ifelse(data$Age<30, "20-29",
           ifelse(data$Age<40, "30-39",
           ifelse(data$Age<50, "40-49",
           ifelse(data$Age<60, "50-59",
           ifelse(data$Age<70, "60-69", "70-79")))))

#Export to a csv for easy loading in the future
write_csv(data, '../Cleaned Data/11-12.csv')

#Give unique name for joining years
data -> df1112


### 2013-2014

#Loading the raw data files
blood_pressure = "../Raw Data/13-14/blood_pressure.XPT"
blood_pressure = read.xport(blood_pressure)

diabetes = "../Raw Data/13-14/diabetes.XPT"
diabetes = read.xport(diabetes)

medical_conditions = "../Raw Data/13-14/medical_conditions.XPT"
medical_conditions = read.xport(medical_conditions)

demographics = "../Raw Data/13-14/demographics.XPT"
demographics = read.xport(demographics)

body_measures = "../Raw Data/13-14/body_measures.XPT"
body_measures = read.xport(body_measures)

#Joining the datasets and selecting the variables I'm interested in
data = blood_pressure %>%
  inner_join(diabetes, by="SEQN") %>%
  inner_join(medical_conditions, by="SEQN") %>%
  inner_join(demographics, by="SEQN") %>%
  inner_join(body_measures, by="SEQN") %>%
  select(SEQN, WTMEC2YR, MCQ195, RIDAGEYR, 
         BPXSY1, BPXSY2, BPXSY3, BPXSY4, 
         BPXDI1, BPXDI2, BPXDI3, BPXDI4, 
         BMXBMI, DIQ010, RIAGENDR, DMDMARTL, INDFMPIR, DMDEDUC2)

#Averaging blood pressure data into two new columns, dropping the raw measures
data %<>% mutate(Systolic = rowMeans(data[,c(5:8)], na.rm=TRUE), 
                 Diastolic = rowMeans(data[,c(9:12)], na.rm=TRUE)) %>%
  select(-BPXSY1, -BPXSY2, -BPXSY3, -BPXSY4, 
         -BPXDI1, -BPXDI2, -BPXDI3, -BPXDI4)


#Setting human readable column names
names(data) <- c(
  'id', 'weights', 'RA', 'Age', 'BMI', 
  'Diabetes', 'Gender','MaritalStatus','IncomeRatio', "Edu", 'Systolic', 'Diastolic'
) 

#Filtering
data %<>% filter(
  RA %in% c(1, NA), 
  Age>=20 & Age<80, 
  Diabetes!=9
)


#Setting human readable factor levels
data$RA <- factor(data$RA, levels=c(1), labels=c('Rheumatoid'))
data$RA <- addNA(data$RA)
levels(data$RA)[2] <- 'No Arthritis'

data$Diabetes <- factor(data$Diabetes, 
                        levels=c(1,2,3), 
                        labels=c('Diabetes', 
                                 'No Diabetes', 
                                 'Borderline'))
data$Gender <- factor(data$Gender, 
                      levels=c(1,2), 
                      labels=c('Male', 
                               'Female'))

data$MaritalStatus <- factor(data$MaritalStatus, 
                             levels=c(1,2,3,4,5,6), 
                             labels=c('Married', 
                                      'Widowed', 
                                      'Divorced',
                                      'Separated',
                                      'Never Married',
                                      'Living with Partner'))

data$Edu <- factor(data$Edu, 
                   levels=c(1,2,3,4,5), 
                   labels=c('>9th Grade', 
                            '9-11th Grade', 
                            'High School Grad',
                            'Some College',
                            'College Grad'))

#Binning Age into 10 year segments
data$Age = ifelse(data$Age<30, "20-29",
           ifelse(data$Age<40, "30-39",
           ifelse(data$Age<50, "40-49",
           ifelse(data$Age<60, "50-59",
           ifelse(data$Age<70, "60-69", "70-79")))))

#Export to a csv for easy loading in the future
write_csv(data, '../Cleaned Data/13-14.csv')

#Give unique name for joining years
data -> df1314


### 2015-2016

#Loading the raw data files
blood_pressure = "../Raw Data/15-16/blood_pressure.XPT"
blood_pressure = read.xport(blood_pressure)

diabetes = "../Raw Data/15-16/diabetes.XPT"
diabetes = read.xport(diabetes)

medical_conditions = "../Raw Data/15-16/medical_conditions.XPT"
medical_conditions = read.xport(medical_conditions)

demographics = "../Raw Data/15-16/demographics.XPT"
demographics = read.xport(demographics)

body_measures = "../Raw Data/15-16/body_measures.XPT"
body_measures = read.xport(body_measures)

diet = "../Raw Data/15-16/diet.XPT"
diet = read.xport(diet)

physical_functioning = "../Raw Data/15-16/physical_functioning.XPT"
physical_functioning = read.xport(physical_functioning)

#Joining the datasets and selecting the variables I'm interested in
data = blood_pressure %>%
  inner_join(diabetes, by="SEQN") %>%
  inner_join(medical_conditions, by="SEQN") %>%
  inner_join(demographics, by="SEQN") %>%
  inner_join(body_measures, by="SEQN") %>%
  inner_join(diet, by="SEQN") %>%
  inner_join(physical_functioning, by="SEQN") %>%
  select(SEQN, WTMEC2YR, MCQ195, RIDAGEYR, 
         BPXSY1, BPXSY2, BPXSY3, BPXSY4, 
         BPXDI1, BPXDI2, BPXDI3, BPXDI4, 
         BMXBMI, DIQ010, DBQ700, PFQ049, PFQ051,
         PFQ063A, RIAGENDR, DMDMARTL, INDFMPIR, DMDEDUC2)

#Averaging blood pressure data into two new columns, dropping the raw measures
data %<>% mutate(Systolic = rowMeans(data[,c(5:8)], na.rm=TRUE), 
                 Diastolic = rowMeans(data[,c(9:12)], na.rm=TRUE)) %>%
  select(-BPXSY1, -BPXSY2, -BPXSY3, -BPXSY4, 
         -BPXDI1, -BPXDI2, -BPXDI3, -BPXDI4)


#Setting human readable column names
names(data) <- c(
  'id', 'weights', 'RA', 'Age', 'BMI', 
  'Diabetes', 'Diet', 'Work1', 'Work2',
  'Cause', 'Gender','MaritalStatus','IncomeRatio',
  'Edu', 'Systolic', 'Diastolic'
) 

#Filtering
data %<>% filter(
  RA %in% c(1, NA), 
  Age>=20 & Age<80, 
  Diabetes!=9
)


#Setting human readable factor levels
data$RA <- factor(data$RA, levels=c(1), labels=c('Rheumatoid'))
data$RA <- addNA(data$RA)
levels(data$RA)[2] <- 'No Arthritis'

data$Diabetes <- factor(data$Diabetes, 
                        levels=c(1,2,3), 
                        labels=c('Diabetes', 
                                 'No Diabetes', 
                                 'Borderline'))
data$Gender <- factor(data$Gender, 
                      levels=c(1,2), 
                      labels=c('Male', 
                               'Female'))

data$MaritalStatus <- factor(data$MaritalStatus, 
                             levels=c(1,2,3,4,5,6), 
                             labels=c('Married', 
                                      'Widowed', 
                                      'Divorced',
                                      'Separated',
                                      'Never Married',
                                      'Living with Partner'))

data$Edu <- factor(data$Edu, 
                   levels=c(1,2,3,4,5), 
                   labels=c('>9th Grade', 
                            '9-11th Grade', 
                            'High School Grad',
                            'Some College',
                            'College Grad'))

#Binning Age into 10 year segments
data$Age = ifelse(data$Age<30, "20-29",
           ifelse(data$Age<40, "30-39",
           ifelse(data$Age<50, "40-49",
           ifelse(data$Age<60, "50-59",
           ifelse(data$Age<70, "60-69", "70-79")))))

#Export to a csv for easy loading in the future
write_csv(data, '../Cleaned Data/15-16.csv')

#Give unique name for joining years
data -> df1516


# Master

data <- bind_rows(df78, df910, df1112, df1314, df1516)
data$weights <- data$weights/5

write_csv(data, '../Cleaned Data/master.csv')

data <- bind_rows(df78, df910)
write_csv(data, '../Cleaned Data/07_10.csv')

