################################################################################
############################## Data Preparation ################################
################################################################################

### Set wd and load libraries
library("SummarizedExperiment")
library(edgeR)


### Load original data
dat = readRDS('data/tcga_data.RDS')

### Checking the attributes of original data
table(dat$sample_type)
table(dat$vital_status)
table(dat$gender)

### Extracting gene data
limma_pipeline = function(tcga_data, condition_variable, reference_group=NULL){
  
  design_factor = colData(tcga_data)[, condition_variable, drop=T]
  
  group = factor(design_factor)
  if(!is.null(reference_group)){group = relevel(group, ref=reference_group)}
  
  design = model.matrix(~ group)
  
  dge = DGEList(counts=assay(tcga_data),
                samples=colData(tcga_data),
                genes=as.data.frame(rowData(tcga_data)))
  
  # filtering
  keep = filterByExpr(dge,design)
  dge = dge[keep,,keep.lib.sizes=FALSE]
  rm(keep)
  
  # Normalization (TMM followed by voom)
  dge = calcNormFactors(dge)
  v = voom(dge, design, plot=TRUE)
  
  return(list(voomObj=v))
}

limma_res = limma_pipeline(
  tcga_data=dat,
  condition_variable="definition",
  reference_group="Solid Tissue Normal"
)

### To save the last step, we can read limma_res here
limma_res = readRDS('data/limma_res.RDS')

### Checking gene data dimension
gene = as.matrix(t(limma_res$voomObj$E))
dim(gene)

### Checking response variable
temp = factor(limma_res$voomObj$targets$definition)
resp = rep(0,421)
resp[temp=="Primary solid Tumor"]=1
rm(temp)

### Loading gender and age variables
age = -dat$days_to_birth/365
temp = dat$gender
gender = rep(0,421)
gender[temp=='male']=1
rm(temp)

### Implement na data of age
age[is.na(age)] = mean(age, na.rm=T)

### Merging all data together and rename rows
data0 = cbind(resp, age, gender, gene)
row.names(data0) = 1:length(data0[,1])

### Change column names
geneNames = base::paste('#',sep='',1:22730)
colnames(data0) = c('resp', 'age', 'gender', geneNames)
rm(geneNames)

### remove all intermediate variables
rm(dat, gene, limma_res, age, gender, resp, limma_pipeline)

### Save data
save(data0, file = 'data/data0.RData')

