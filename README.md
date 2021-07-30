# Rout_Tanes_SIV_ART_microbiome

This repository contains the analysis code to generate the results represented in the paper "Gut microbiome changes associated with epithelial barrier damage and systemic inflammation during antiretroviral therapy of chronic SIV infection"

DNA from the samples were extracted using PowerSoil, libraries were generated using the NexteraXT kit and seuqenced on an Illumina HiSeq2500 machine. [Resulting fastq files](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA750063) were processed using the [Sunbeam pipeline](https://github.com/sunbeam-labs/sunbeam) (version 2.0.1) on an HPC machine using the QC, decontam, classify and report rules. We also used the Sunbeam [extension](https://github.com/ctanes/sbx_gene_clusters) to align reads to a butyrate protein database curated from the [2014 Vital et al](https://pubmed.ncbi.nlm.nih.gov/24757212/) paper. The command used to run the pipeline was: 

```
snakemake -j 50 --keep-going --configfile rout_config.yml \
  --cluster-config configs/cluster.json -w 90 --notemp -p \
  -c "qsub -cwd -r n -V -l h_vmem={cluster.h_vmem} -l mem_free={cluster.mem_free} -pe smp {threads}"
```

After obtaining the processed files from the Sunbeam pipeline, they were downloaded to a local computer and the code described in this repository was run to obtain the analysis and figures represented in the paper. 
