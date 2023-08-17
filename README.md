# DNA Mimic proteins

### Get_prot_fasta.sh
Run psiblast, divide result by protein names for several files, get protein id, get fasta by that id, filter duplicates, delete proteins with 'X' (Filter_protein_with_X.py) and count number of resultant proteins

### Cluster_get_fasta.sh
Cluster fasta sequences with MMseq2, get representative

### Make_hist_homologs_length.sh and Make_hist_homologs_length.py
Get initial proteins, measure it's length, record in a table and draw a histogram of the distribution of lengths of homologues with a threshold for the initial protein

### filter_proteins_max_len.sh and filter_proteins_max_len.py
Filter homologues by length - no more than 1.5 times the length of the original protein

### Create_csv_from_fasta.py
Create 
