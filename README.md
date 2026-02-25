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
- Default √p variable sampling  

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

### Requirements

- R (version 4.5.2 recommended)
- RStudio
- renv

### Setup

Clone the repository:

```bash
git clone https://github.com/UBC-DSCI-310-2025W2/dsci-310-group-10.git
cd dsci-310-group-10
```

Open the project:

```
dsci-310-group-10.Rproj
```

Restore environment:

```r
install.packages("renv")  # if needed
renv::restore()
```

---

## Running the Analysis

The complete analysis is located in:

```
src/predicting_diabetes.Rmd
```

To reproduce results:

1. Open `predicting_diabetes.Rmd`
2. Click **Knit**
3. Output will be generated as:

```
src/predicting_diabetes.html
```

---

## References

Chang, V., Bailey, J., Xu, Q. A., & Sun, Z. (2022). Pima Indians diabetes mellitus classification based on machine learning algorithms. Neural Computing & Applications.

Roumie, C. L., et al. (2020). Blood Pressure Control and the Association With Diabetes Mellitus Incidence. Hypertension.

Kautzky-Willer, A., Leutner, M., & Harreiter, J. (2023). Sex differences in type 2 diabetes. Diabetologia.

OpenML Dataset (2025). https://www.openml.org/search?type=data&id=43483

---
