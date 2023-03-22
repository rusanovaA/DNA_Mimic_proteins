#!/bin/bash
data_dir=/home/lam16/Mimic_proteins/final_files/prot_fasta
#Create dir with fasta representative sequences after clustering
mkdir $data_dir/clu_rep
#Cluster blast results with MMseq2. Get tsv file with clusters and fasta file with representative sequences
for i in `ls -a $data_dir/ | grep 'fasta' | sed -r "s/(.+).fasta/\1/" | uniq | sort -d`
do
	echo $i
mkdir ./${i}
cp ${i}.fasta ${i}_copy.fasta
sed 's, ,_,g' -i ${i}_copy.fasta
cd ./${i}
mmseqs createdb ../${i}_copy.fasta ${i}_DB
mmseqs cluster ${i}_DB ${i}_clu tmp --min-seq-id 0.9 -c 0.9
mmseqs createtsv ${i}_DB ${i}_DB ${i}_clu ../clu_rep/${i}_clu.tsv
mmseqs result2repseq ${i}_DB ${i}_clu ${i}_clu_rep
mmseqs result2flat ${i}_DB ${i}_DB ${i}_clu_rep ../clu_rep/${i}_clu_rep.fasta
cd ../
rm -r ./${i}
rm -f ${i}_copy.fasta
done
