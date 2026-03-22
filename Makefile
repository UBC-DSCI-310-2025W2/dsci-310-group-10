# author: DSCI310 Group10
# date: 2026-03-19

all: results/eda_plot.png results/final_plot.png \
     results/eda_summary.csv results/final_results.csv \
     results/model.rds data/clean_data.rds \
     reports/predicting_diabetes.html

# Step 1: Load data
data/clean_data.rds: src/01_load_data.R
	Rscript src/01_load_data.R 43483 data/clean_data.rds

# Step 2: EDA + preprocessing
results/eda_plot.png results/eda_summary.csv data/processed_data.rds: src/02_methods.R data/clean_data.rds
	Rscript src/02_methods.R data/clean_data.rds data/processed_data.rds results/eda_plot.png results/eda_summary.csv
# Step 3: Model training
results/model.rds: src/03_model.R data/processed_data.rds
	Rscript src/03_model.R data/processed_data.rds results/model.rds results/test_data.rds

# Step 4: Results
results/final_plot.png results/final_results.csv: src/04_results.R results/model.rds results/test_data.rds
	Rscript src/04_results.R results/model.rds results/test_data.rds results/conf_mat.rds results/final_results.csv results/final_plot.png

# Step 5: Render Quarto Report 
reports/predicting_diabetes.html: reports/predicting_diabetes.qmd results/eda_plot.png results/final_plot.png results/final_results.csv
	quarto render reports/predicting_diabetes.qmd --to html

# Clean everything
clean:
	rm -f data/*.rds
	rm -rf results/*
	rm -f reports/predicting_diabetes.html
	
.PHONY: all clean