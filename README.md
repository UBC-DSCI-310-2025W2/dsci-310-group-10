# dsci-310-group-10
# Diabetes Prediction Using Machine Learning  
**Group Member:** Niki Duan, Vivian Pu, Nathan Sihombing, Yun Tian  

---

## Project Overview

Diabetes is a chronic metabolic disease affecting millions of individuals worldwide. Early detection is essential to prevent severe complications such as cardiovascular disease, kidney damage, neuropathy, and vision impairment.

The goal of this project is to investigate whether diabetes status can be predicted using clinical and demographic features. Using the Pima Indian Diabetes dataset, we conduct exploratory data analysis (EDA) and develop a machine learning classification model to predict the presence of diabetes.

**Research Question:**  
Can we predict the presence of diabetes in individuals based on clinical and demographic features?

---

## Dataset

The dataset originates from:

- UCI Machine Learning Repository  
- Processed version available via OpenML  
- OpenML Dataset ID: 43483  
  https://www.openml.org/search?type=data&id=43483

### Dataset Description

- Population: Female patients, age 21 years or older  
- Heritage: Pima Indian  
- Number of observations: 768  
- Target variable: `Outcome`  
  - 0 = No diabetes  
  - 1 = Diabetes  

### Features

- Pregnancies — Number of pregnancies  
- Glucose — Plasma glucose concentration  
- BloodPressure — Diastolic blood pressure  
- SkinThickness — Triceps skinfold thickness  
- Insulin — Serum insulin  
- BMI — Body Mass Index  
- DiabetesPedigreeFunction — Genetic predisposition score  
- Age — Age in years  
- Outcome — Diabetes diagnosis (binary)

Approximately 35% of individuals in the dataset are diabetic.

---

## Repository Structure

```
.
├── .github/
│   └── docker-image.yml
├── data/
│   └── pima_indian_diabetes.csv
├── src/
│   ├── predicting_diabetes.Rmd
│   └── predicting_diabetes.html
├── renv/
│   ├── .gitignore
│   ├── active.R
│   └── settings.json
├── .Rprofile
├── .gitignore
├── CODE_OF_CONDUCT.md
├── Dockerfile
├── LICENSE
├── README.md
├── dsci-310-group-10.Rproj
└── renv.lock
```

---

## Methods

### Exploratory Data Analysis (EDA)

We performed:

- Summary statistics  
- Missing value checks  
- Correlation analysis  
- Density plots by outcome  
- Pairwise scatterplot matrices  

Key findings:

- Glucose is the strongest predictor of diabetes.
- BMI, Age, and Pregnancies are positively associated with diabetes.
- Moderate class imbalance exists (~35% diabetic).

---

### Model Development

We trained a Random Forest classifier using:

- 80/20 stratified train-test split  
- 500 decision trees  

Random Forest was chosen because it:

- Captures nonlinear relationships  
- Handles feature interactions  
- Is robust to overfitting  
- Performs well on structured clinical data  

---

## Model Evaluation

Performance metrics:

| Metric     | Value  |
|------------|--------|
| Accuracy   | 88.9%  |
| Precision  | 89.5%  |
| Recall     | 94.0%  |
| F1 Score   | 91.7%  |

### Interpretation

- High recall indicates strong detection of diabetic patients.
- High precision reduces false positives.
- Strong F1 score reflects balanced classification performance.

The model may serve as a useful screening tool but is not a substitute for clinical diagnosis.

---

## Limitations

- Dataset includes only female participants.
- Results may not generalize to other populations.
- External validation is needed.
- Advanced models (e.g., gradient boosting) could be explored.

---

## Reproducibility

This project uses `renv` for reproducible package management.


### Usage (pick one method from below)

#### 1. Using renv

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

#### 2. Using Docker compose to launch containers

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

#### 3. Manually launch docker containers

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

---

### Dependencies

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

### License
This project is licensed under the Creative Commons Attribution 2.5 Canada License (CC BY 2.5 CA).

Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)

If re-using or adapting these materials, please provide attribution and link to this repository.

---