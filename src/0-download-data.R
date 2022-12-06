if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("TCGAbiolinks")
BiocManager::install(c("limma", 'edgeR', 'genefilter'))

library(genefilter)
install.packages(c('glmnet', 'factoextra', 'FactoMineR', 'caret', 
                   'SummarizedExperiment', 'gplots', 'survival', 'survminer',
                   'RColorBrewer'))
install.packages('gProfileR')
library("TCGAbiolinks")
library("limma")
library("edgeR")
library("glmnet")
library("factoextra")
library("FactoMineR")
library("caret")
library("SummarizedExperiment")
library("gplots")
library("survival")
library("survminer")
library("RColorBrewer")
library("gProfileR")
library("genefilter")

### Data
GDCprojects = getGDCprojects()

head(GDCprojects[c("project_id", "name")])
TCGAbiolinks:::getProjectSummary("TCGA-LIHC")

query_TCGA = GDCquery(
  project = "TCGA-LIHC",
  data.category = "Transcriptome Profiling", # parameter enforced by GDCquery
  experimental.strategy = "RNA-Seq",
  workflow.type = "STAR - Counts")

lihc_res = getResults(query_TCGA) # make results as table
# head(lihc_res) # data of the first 6 patients.
colnames(lihc_res) # columns present in the table

query_TCGA = GDCquery(
  project = "TCGA-LIHC",
  data.category = "Transcriptome Profiling", # parameter enforced by GDCquery
  experimental.strategy = "RNA-Seq",
  workflow.type = "STAR - Counts",
  sample.type = c("Primary Tumor", "Solid Tissue Normal"),
  data.type =  "Gene Expression Quantification")

GDCdownload(query = query_TCGA)
tcga_data = GDCprepare(query_TCGA)

saveRDS(object = tcga_data,
        file = "tcga_data.RDS",
        compress = FALSE)



