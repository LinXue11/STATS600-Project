# 600 Project - Xuelin Zhu

Everything including the codes, intermediate data/models that take a long time to run, summaries, and figures are saved in this [**Gitlab repository**](https://gitlab.umich.edu/xuelin/600-project/-/tree/main/). And this document is a guide for using this repository and reading the codes, by which if you follow you can replicate my results.

## Repository Structure

|-- README.md		   - A codes reading guidance.

|-- 600.Rproj				- <font color="#dd0000">**Please run this if you are replicating my codes**</font>, setting this directory as wd.

|-- data						 - A folder for original data, intermediate data, and models that take a long time to fit.

|-- figs						   - A folder for result figures.

|-- src							- A folder for all codes.

## Scripts Partition

Codes for the whole project are partitioned sequentially into 6 parts: downloading data, preparing data, EDA, splitting data, PCA, and modeling. After every part is done, useful processed data and models are saved in '~/data', so you can either run the codes from beginning to end or begin at any partition. Please remember to <font color="#dd0000">**run 600.Rproj**</font> no matter where you start. This R project file helps you set the working directory.

### Part 0 - Downloading Data  ([~/src/0-download-data.R](https://gitlab.umich.edu/xuelin/600-project/-/tree/main/src))

My goal is to predict liver cancer (Hepatocellular Carcinoma), so I downloaded it from *Cancer Genome Atlas (TGCA) and saved it in '[~/data/tcga_data.RDS](https://gitlab.umich.edu/xuelin/600-project/-/tree/main/data)'. 

### Part 1 - Preparing Data ([~/src/1-prepareData.R](https://gitlab.umich.edu/xuelin/600-project/-/tree/main/src))

 '[~/data/tcga_data.RDS](https://gitlab.umich.edu/xuelin/600-project/-/tree/main/data)' is not in the format that we can use to fit models, so I made a big $421\times 22733$ matrix by selecting the *response,* *age*, *gender*, and *all gene expression data* of all patients. This matrix is ready for further analysis and saved in '[~/data/data0.RData](https://gitlab.umich.edu/xuelin/600-project/-/tree/main/data)'.

### Part 2 - Exploratory Data Analysis ([~/src/2-eda.Rmd](https://gitlab.umich.edu/xuelin/600-project/-/tree/main/src))

The basic results are listed in the report. If you want to run this Rmd, please in the setting of R Studio, set R Markdown ```evaluate chunks in directory: Project``` to guarantee the right working directory. Or you can read the same name HTML file. 

### Part 3 - Data Splitting ([~/src/3-dataSplit.R](https://gitlab.umich.edu/xuelin/600-project/-/tree/main/src))

To compare different models, I split the data into a 70% training set and a 30% testing set. They are saved as '[data/1-split/testData.RData](data/1-split/testData.RData)' and '[data/1-split/trainData.RData](data/1-split/trainData.RData)'.

### Part 4 - PCA ([~/src/4-PCA.Rmd](https://gitlab.umich.edu/xuelin/600-project/-/tree/main/src))

Since we can not fit logistic regression on high dimensional gene data (MLE does not converge), we did a PCA here. PCA object, pcs of the training set, and testing set are saved in ['data/2-pcreg'](https://gitlab.umich.edu/xuelin/600-project/-/tree/main/data/2-pcreg). 

### Part 5 - Modeling ([~/src/5-Modeling.Rmd](https://gitlab.umich.edu/xuelin/600-project/-/tree/main/src))

Logistic regression models with principal components, Ridge and LASSO are implemented here. Since all preprocessing is done in previous scripts, you can directly run this R markdown file.
