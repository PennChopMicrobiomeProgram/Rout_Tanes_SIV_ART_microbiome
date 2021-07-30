# Rout_Tanes_SIV_ART_microbiome

This repository contains the analysis code to generate the results represented in the paper 

Sequencing data from Illumina HiSeq2500 was processed using the [Sunbeam pipeline](https://github.com/sunbeam-labs/sunbeam) on an HPC machine. We also used the Sunbeam [extension](https://github.com/ctanes/sbx_gene_clusters) to align reads to a butyrate protein database curated from the [2014 Vital et al](https://pubmed.ncbi.nlm.nih.gov/24757212/) paper. The command used to run the pipeline was: 

```
snakemake -j 50 --keep-going --configfile rout_config.yml \
  --cluster-config configs/cluster.json -w 90 --notemp -p \
  -c "qsub -cwd -r n -V -l h_vmem={cluster.h_vmem} -l mem_free={cluster.mem_free} -pe smp {threads}"
```

After obtaining the processed files from the Sunbeam pipeline, they were downloaded to a local computer and the code described in this repository was run to obtain the analysis and figures represented in the paper. 
