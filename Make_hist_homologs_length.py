#!/usr/bin/env python3

#import sys
import argparse
from Bio import SeqIO
from matplotlib import pyplot as plt

parser = argparse.ArgumentParser(description="Make histograme pf the length")
parser.add_argument("-f", "--file", help="Fasta with homolog proteins")
parser.add_argument("-i", "--initial", help="Fasta with initial proteins")
parser.add_argument("-o", "--output", help="Histogtam")
args, unknown = parser.parse_known_args()

initial_prot_length = {}
homolog_prot_length = []

for record in SeqIO.parse(args.initial, "fasta"):
    initial_prot_length[record.id] = len(record.seq)

list_name = args.file.split("_")
initial_name= list_name[2]

for name in initial_prot_length.keys():
    if initial_name == name:
        del_for_hist = initial_prot_length[name]
    

for record in SeqIO.parse(args.file, "fasta"):
    homolog_prot_length.append(len(record.seq))
    #print(len(record.seq))

len_hom = len(homolog_prot_length)
n_bins = int((max(homolog_prot_length) - min(homolog_prot_length))/100)+1

plt.hist(homolog_prot_length, bins=n_bins, alpha=0.5)
plt.axvline(del_for_hist, color='k', linestyle='dashed', linewidth=1)
plt.title(''+str(initial_name)+' distribution of homologs length, n = '+str(len_hom)+'\n '+str(initial_name)+' length = '+str(del_for_hist)+'')
plt.xlabel('Length, aa')
plt.ylabel('Count')
plt.savefig(args.output)
         

