# NHANES-SAS
SAS-based analysis of NHANES data integrating demographics, body measures, blood pressure, diabetes, and lipid profiles to evaluate cardiometabolic health.


# NHANES Cardiometabolic Profiling (SAS Version)

This project replicates the NHANES cardiometabolic analysis using **SAS 9.4**.  
It merges demographic, body measure, blood pressure, diabetes, and lipid datasets to describe cardiometabolic health indicators by gender, race, education, and marital status.


## Methods
- **Merge rule:** Left join with `BMX` as the base dataset (`if C;`) to include all participants with body-measure data.  
- Created average systolic/diastolic BP from three oscillometric readings.  
- Used `PROC FORMAT`, `PROC MEANS`, and `PROC FREQ` to create Table 1 (Mean (SD), n (%)).  
- Built visual comparisons using `PROC SGPLOT`.  


## ⚙️ How to Run
1. Place NHANES `.xpt` files into the `/data/` folder.  
2. Open `NHANES Project.sas` in SAS 9.4.  
3. Run the program to generate tables and figures in `/outputs/`.

