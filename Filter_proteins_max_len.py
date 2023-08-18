#!/usr/bin/env python3

#import sys
import argparse
from Bio import SeqIO
from matplotlib import pyplot as plt

parser = argparse.ArgumentParser(description="Filter homolog proteins by length")
parser.add_argument("-f", "--file", help="Fasta with homolog proteins")
parser.add_argument("-i", "--initial", help="Fasta with initial proteins")
parser.add_argument("-o", "--output", help="Filtering proteins")
args, unknown = parser.parse_known_args()

initial_prot_length = {}

for record in SeqIO.parse(args.initial, "fasta"):
    initial_prot_length[record.id] = len(record.seq)

list_name = args.file.split("_")
initial_name= list_name[2]
if initial_name in initial_prot_length.keys():
    initial_length = initial_prot_length[initial_name]
else:
    print(f'Protein ID not found: {initial_name}')


with open(args.output, "w") as good_out:
    for record in SeqIO.parse(args.file, "fasta"):
        if len(record.seq) <= initial_length * 1.5:
            SeqIO.write(record, good_out, "fasta")
         

