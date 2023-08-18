#!/usr/bin/env python3

#import sys
import argparse

parser = argparse.ArgumentParser(description="Create tsv file from fasta")
parser.add_argument("-f", "--file", help="Fasta with proteins")
parser.add_argument("-o", "--output", help="csv output")
args, unknown = parser.parse_known_args()

sequences = {}
header = ""
with open(args.file, "r") as file:
    for line in file:
        line=line.rstrip()
        if (line[0] == ">"):
            if header != "" and data != "":
                #print(header, data)
                sequences[header] = data
            header = line
            data = ""
            #sequences[header] = ""
                    #print(line)
        else:
            data += line
    sequences[header] = data


with open(args.output, "w+") as good_out:
    good_out.write('Protein_name\tSequence\n')
    for header in sequences.keys():
        good_out.write("{}\t{}\n".format(header, sequences[header]))

                    
