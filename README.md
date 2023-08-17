# DNA Mimic proteins

### Get_prot_fasta.sh
Run psiblast, divide result by protein names for several files, get protein id, get fasta by that id, filter duplicates, delete proteins with 'X' (Filter_protein_with_X.py) and count number of resultant proteins

### Cluster_get_fasta.sh
Cluster fasta sequences with MMseq2, get representative

### Make_hist_homologs_length.sh and Make_hist_homologs_length.py
Get initial proteins, measure it's length, record in a table and draw a histogram of the distribution of lengths of homologues with a threshold for the initial protein

### 
