#!/bin/bash
data_dir=/home/lam16/Mimic_proteins/final_files
#Run psiblast 
#screen -S Psiblast psiblast -query DNA_mimic_protein_bac_bf.fasta -db /opt/ncbi-blast-2.13.0+/blastdb/nrdb/nr -num_iterations=0  -outfmt "6 qseqid sseqid stitle pident length qcovs qcovhsp mismatch gapopen qstart qend sstart send evalue bitscore" -num_threads 60 -out DNA_mimic_protein_bac_bf_res_psiblast_num_0 -out_pssm ./DNA_mimic_protein_bac_bf_res_psiblast_num_0.pssm  -save_pssm_after_last_round
#Get file with psiblast results and split by first column
mkdir $data_dir/psi_results
cd $data_dir/psi_results
awk -F"\t" '{print >> ("Mimic_prot_" $1 ".txt")}' $data_dir/DNA_mimic_protein_bac_bf_res_psiblast_num_0
rm -f Mimic_prot_.txt Mimic_prot_Search\ has\ CONVERGED\!.txt
#Get new files with second column with IDs of proteins
mkdir $data_dir/prot_id
for i in `ls -a $data_dir/psi_results | grep 'txt' | sed -r "s/(.+).txt/\1/" | uniq | sort -d`
do
	echo "Get new file with IDs: "$i
awk -F"\t" '{print $2}' $data_dir/psi_results/${i}.txt > $data_dir/prot_id/${i}_ID.txt
done
#Get fasta files with protein sequences
mkdir $data_dir/prot_fasta
for i in `ls -a $data_dir/prot_id | grep 'txt' | sed -r "s/(.+)_ID.txt/\1/" | uniq | sort -d`
do
	echo "Get fasta file: "$i
blastdbcmd -db /opt/ncbi-blast-2.13.0+/blastdb/nrdb/nr -entry_batch $data_dir/prot_id/${i}_ID.txt -out $data_dir/prot_fasta/${i}_with_all_names.fasta
done
#Delete extra names of proteins
for i in `ls -a $data_dir/prot_fasta | grep 'fasta' | sed -r "s/(.+)_with_all_names.fasta/\1/" | uniq | sort -d`
do
	echo "Delete extra name:"$i
awk -F" >" '{print $1;next}1' $data_dir/prot_fasta/${i}_with_all_names.fasta > $data_dir/prot_fasta/${i}.fasta
done
for f in $data_dir/prot_fasta/*.fasta; do echo $f;cat $f|grep '>'|wc -l ; done >> $data_dir/Prot_count.txt 
#Delete excess files
rm -f $data_dir/prot_fasta/*_with_all_names.fasta
#Delete sequences with 'X'
mkdir $data_dir/prot_fasta_clean
for i in `ls -a $data_dir/prot_fasta | grep 'fasta' | sed -r "s/(.+).fasta/\1/" | uniq | sort -d`
do
	echo "Delete sequences with 'X' "$i
python $data_dir/Filter_protein_with_X.py -f $data_dir/prot_fasta/${i}.fasta -o $data_dir/prot_fasta_clean/${i}.fasta
done
for f in $data_dir/prot_fasta_clean/*.fasta; do echo $f;cat $f|grep '>'|wc -l ; done >> $data_dir/Prot_clean_count.txt
