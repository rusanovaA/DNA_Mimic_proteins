#!/bin/bash
data_dir=/mnt/c/Users/rusla/OneDrive/Desktop
mkdir $data_dir/test/hist
for i in `ls -a $data_dir/test | grep 'fasta' | sed -r "s/(.+).fasta/\1/" | uniq | sort -d`
do
	echo "Create histogram with homologs length distribution "$i
python $data_dir/Make_hist_homologs_length.py -f $data_dir/test/${i}.fasta -i $data_dir/DNA_mimic_protein_bac_bf.fasta -o $data_dir/test/hist/${i}_hom_length_hist.png
done
