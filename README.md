# README
This repository contains the code and data for the manuscript titled "A stronger association of depression with rheumatoid arthritis in presence of high BMI or hypertriglyceridemia."

## NHANES RA Analysis
Master folder containing all code and data.

### NHANES RA Analysis / Raw Data
This subfolder contains folders for the raw NHANES data for the years 2007-2008 and 2009-2010. Each data folder contains XPT files directly downloaded from the CDC NHANES site
 https://www.cdc.gov/nchs/nhanes. BMI.XPT contains body mass index data, TRIGLY_E.XPT and TRIGLY_F.XPT contain blood plasma triglyceride content data, blood_pressure.XPT contains blood pressure data, body_measure.XPT contains body measures data, cholesterol.XPT contains cholesterol data, demographics.XPT contains demographics data, diabetes.XPT contains diabetes data, and medical_conditions.XPT contains data related to any medical conditions. Documentation regarding how these variables were measured and/or calculated can be found on the CDC NHANES site. 

### NHANES RA Analysis / Cleaned Data
This subfolder contains csv files of the cleaned NHANES data for the years 2007-2008 and 2009-2010 as well as the joined dataset for years 2007-2010. The data in this folder was produced directly with data_extraction_and_preparation.R. 

### NHANES RA Analysis / Plots
Some of the plots produced by the Paper_Visualizations.Rmd file, in this case those that represent sections of Figures 5 and 6 in the manuscript.

### NHANES RA Analysis / MC_DEPR_DEM_CRP.csv
A cleaned csv file containing medical conditions, depression, demographic, and CRP data.

### NHANES RA Analysis / Paper_Visualizations.Rmd


### NHANES RA Analysis / data_extraction_and_preparation.R
