#!/bin/bash
data_dir=/home/niagara/Storage/D_Sutormin/Metagenomes/N_Rusanova/Prot
ls >> File_names.txt
for i in `ls -a $data_dir/ | grep 'fasta' | sed -r "s/(.+).fasta/\1/" | uniq | sort -d`
do
cat ${i}.fasta | grep '>' |wc -l | >> Prot_all.txt
cd $data_dir/clu_rep
cat ${i}_clu_rep.fasta | grep '>' |wc -l | >> ../Prot_rep.txt
done
