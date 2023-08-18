#!/bin/bash
data_dir=/mnt/c/Users/rusla/OneDrive/Desktop
mkdir $data_dir/test/filter_by_length
for i in `ls -a $data_dir/test | grep 'fasta' | sed -r "s/(.+).fasta/\1/" | uniq | sort -d`
do
	echo "Filtering homolog proteins by length "$i
python $data_dir/filter_proteins_max_len.py -f $data_dir/test/${i}.fasta -i $data_dir/DNA_mimic_protein_bac_bf.fasta -o $data_dir/test/filter_by_length/${i}_filtr.fasta
done
