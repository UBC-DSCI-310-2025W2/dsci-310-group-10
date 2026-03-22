# dsci-310-group-10
# Diabetes Prediction Using Machine Learning  
**Group Member:** Niki Duan, Vivian Pu, Nathan Sihombing, Yun Tian  

---

## About

This study investigates the use of machine learning techniques to predict diabetes status using clinical and demographic data from the Pima Indian Diabetes dataset. The dataset includes physiological variables such as glucose level, body mass index (BMI), age, and number of pregnancies.

A random forest classification model was developed to capture nonlinear relationships among predictors and improve prediction accuracy. The model demonstrated strong performance on the test dataset, achieving an accuracy of 88.9%, precision of 89.5%, recall of 94.0%, and an F1 score of 91.7%. The high recall indicates that the model is particularly effective at identifying individuals with diabetes, making it well-suited for screening and early detection applications.

**Research Question:**  
Can we predict the presence of diabetes in individuals based on clinical and demographic features?

---
## Report

The final report can be found [here](https://github.com/UBC-DSCI-310-2025W2/dsci-310-group-10/tree/main/reports).

## Dataset

The dataset originates from:

- UCI Machine Learning Repository  
- Processed version available via OpenML  
- OpenML Dataset ID: 43483  
  https://www.openml.org/search?type=data&id=43483

## Reproducibility

This project uses `renv` for reproducible package management.


## Usage (pick one method from below)

### 1. Using renv

A. Open your terminal.

B. Navigate to the directory where you want to store the project. For example:

```bash
cd Desktop
```

C. Clone the repository:

```bash
git clone https://github.com/UBC-DSCI-310-2025W2/dsci-310-group-10.git
```

D. Open the project folder in RStudio (inside RStudio, click "File" then "open project", and select dsci-310-group-10)

E. Restore environment:

```r
install.packages("renv")  # if needed
renv::activate()
renv::restore()
```

---

F. Running the Analysis

The complete analysis is located in:

```
src/predicting_diabetes.Rmd
```

G. To reproduce results:

1. Open `predicting_diabetes.Rmd`
2. Click **Run All**

---

### 2. Using Docker compose to launch containers

A. Open your terminal.

B. Navigate to the directory where you want to store the project. For example:

```bash
cd Desktop
```

C. Clone the repository:

```bash
git clone https://github.com/UBC-DSCI-310-2025W2/dsci-310-group-10.git
```

Make sure the `docker-compose.yml` is in the root folder

D. Navigate into the project directory

```bash
cd dsci-310-group-10
```

E. Pull the image from Docker Hub:

```bash
docker pull duantianyu200/group-10-diabetes-prediction:latest
```

F. To launch the container interactively using this file:

```bash
docker-compose up
```
G. Open RStudio in your browser at:

http://localhost:8787

Login credentials:
Username: rstudio  
Password: yourpassword123

H. To reproduce results:

Open src/predicting_diabetes.Rmd
Click Run All


I. To stop and clean up the container, you would use Ctrl + c in the terminal where you launched the container, and then type: 

```bash
docker-compose down
```

### 3. Manually launch docker containers

A. Open your terminal.

B. Navigate to the directory where you want to store the project. For example:

```bash
cd Desktop
```

C. Clone the repository:

```bash
git clone https://github.com/UBC-DSCI-310-2025W2/dsci-310-group-10.git
```

D. Navigate into the project directory

```bash
cd dsci-310-group-10
```

E. Pull the image from Docker Hub:

```bash
docker pull duantianyu200/group-10-diabetes-prediction:latest
```

F. Run the container:

```bash
docker run -p 8787:8787 duantianyu200/group-10-diabetes-prediction:latest
```

G. Open RStudio in your browser at:

http://localhost:8787

Login credentials:
Username: rstudio  
Password: printed in the terminal when the container starts

H. To reproduce results:

Open src/predicting_diabetes.Rmd
Click Run All

### Running the Pipeline

This project uses a Makefile to automate the analysis workflow.

To run the full pipeline and generate all outputs (including processed data, models, and the final report), run:

```bash
make all
```

To remove all generated files and reset the project to a clean state, run:

```bash
make clean
```

make clean will delete intermediate and output files so the pipeline can be run again from scratch.

---

## Dependencies

- R version 4.5.2 and R packages:
- caret=7.0-1
- ggplot2=4.0.2
- dplyr=1.2.0
- readr=2.2.0
- tidyr=1.3.2
- tibble=3.3.1
- broom=1.0.12
- GGally=2.4.0
- OpenML=1.12
- ModelMetrics=1.2.2.2
- DBI=1.2.3
- Matrix=1.7-4
- MASS=7.3-65
- Rcpp=1.1.1

All package versions and additional dependencies are recorded in the renv.lock file to ensure reproducibility.

---

## License
This project is licensed under the Creative Commons Attribution 2.5 Canada License (CC BY 2.5 CA).

Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)

If re-using or adapting these materials, please provide attribution and link to this repository.

---
