
read_gene_aln_results <- function(base_dir, s_seq) {
  data_frame(FileName = list.files(
    base_dir, pattern="*_1.txt")) %>%
    group_by(FileName) %>%
    do(read.delim(file.path(base_dir, .$FileName), stringsAsFactors = F)) %>%
    ungroup() %>%
    mutate(SampleID = sub("_1.txt", "", FileName, perl=T)) %>%
    select(-FileName) %>%
    
    right_join(select(s_seq, SampleID), by="SampleID") %>%
    
    complete(SampleID, nesting(geneID, taxon), fill = list(count=0)) %>%
    filter(!is.na(geneID)) %>%
    
    mutate(database = basename(base_dir))
  
}


## This is the file to match the geneID and taxonomy information with the butyrate pathways 
## from the Vital et al. 2014 paper
butyrate_info <- read.delim("butyrate/butyrate_20180612.txt", stringsAsFactors = F) %>%
  select(geneID, taxon, pathway_name) %>%
  group_by(geneID,taxon, pathway_name) %>%
  slice(1) %>%
  ungroup()


## Read in the alignment files from the https://github.com/ctanes/sbx_gene_clusters Sunbeam extension.
but <- read_gene_aln_results( file.path(data_dir, "sbx_gene_family", "butyrate_20180612"), s_toTest) %>%
  left_join(butyrate_info, by=c("geneID", "taxon"))

## Merge and normalize
but <- but %>%
  left_join(select(s_toTest,SampleID, nonhost), by="SampleID") %>%
  mutate(props = count/nonhost) %>%
  group_by(SampleID, geneID, database, pathway_name) %>%
  summarize(count = sum(count), props = sum(props)) %>%
  ungroup()


#write.table(but, file.path(data_dir, "rout_butyrate.tsv"), sep='\t', quote=F, row.names = F)
