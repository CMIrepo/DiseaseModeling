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
The tile plots produced by the Paper_Visualizations.Rmd file, in this case those that represent sections of Figures 5 and 6 in the manuscript.

### NHANES RA Analysis / MC_DEPR_DEM_CRP.csv
A cleaned csv file containing medical conditions, depression, demographic, and CRP data.

### NHANES RA Analysis / Paper_Visualizations.Rmd
An R markdown file that produces all plots found in the manuscript. The "Cumulative distributions" sections produces the cumulative distribution plots comparing Triglyceride, CRP, Depression, and BMI in the RA vs the non-RA samples. The "Summary Table" section computes the summaries reported in the demographics table for weighted and unweighted measures of the RA and non-RA samples. The "CRP Vis" section computes the visualization of different variables across levels of CRP. The "Tile Plot" section creates the tile plots (Figure 5 and Figure 6) in the manuscript. The "Chi Sq" section contains all Chi Squared calculations done for this manuscript.  

### NHANES RA Analysis / data_extraction_and_preparation.R
An R script that takes as inputs the raw NHANES data files and returns cleaned csv files. The 2007-2008 and 2009-2010 csv files are those utilized in this work and can be found in the Cleaned Data subfolder. 
