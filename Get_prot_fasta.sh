#!/bin/bash
data_dir=/home/lam16/Mimic_proteins/final_files
#Run psiblast 
#screen -S Psiblast psiblast -query DNA_mimic_protein_bac_bf.fasta -db /opt/ncbi-blast-2.13.0+/blastdb/nrdb/nr -num_iterations=0  -outfmt "6 qseqid sseqid stitle pident length qcovs qcovhsp mismatch gapopen qstart qend sstart send evalue bitscore" -num_threads 60 -out DNA_mimic_protein_bac_bf_res_psiblast_num_0 -out_pssm ./DNA_mimic_protein_bac_bf_res_psiblast_num_0.pssm  -save_pssm_after_last_round
#Get file with psiblast results and split by first column
awk -F"\t" '{print >> ("Mimic_prot_" $1 ".txt")}'  DNA_mimic_protein_bac_bf_res_psiblast_num_0
rm -f Mimic_prot_.txt Mimic_prot_Search\ has\ CONVERGED\!.txt
#Get new files with second column with IDs of proteins
mkdir $data_dir/prot_id
for i in `ls -a $data_dir/ | grep 'txt' | sed -r "s/(.+).txt/\1/" | uniq | sort -d`
do
	echo $i
awk -F"\t" '{print $2}' $data_dir/${i}.txt > $data_dir/prot_id/${i}_ID.txt
done
#Get fasta files with protein sequences
mkdir $data_dir/prot_fasta
for i in `ls -a $data_dir/prot_id | grep 'txt' | sed -r "s/(.+)_ID.txt/\1/" | uniq | sort -d`
do
	echo $i
blastdbcmd -db /opt/ncbi-blast-2.13.0+/blastdb/nrdb/nr -entry_batch $data_dir/prot_id/${i}_ID.txt -out $data_dir/prot_fasta/${i}_with_all_names.fasta
done
#Delete extra names of proteins
for i in `ls -a $data_dir/prot_fasta | grep 'fasta' | sed -r "s/(.+)_with_all_names.fasta/\1/" | uniq | sort -d`
do
	echo $i
awk -F" >" '{print $1;next}1' $data_dir/prot_fasta/${i}_with_all_names.fasta > $data_dir/prot_fasta/${i}.fasta
done
#Delete excess files
rm -f $data_dir/prot_fasta/*_with_all_names.fasta
