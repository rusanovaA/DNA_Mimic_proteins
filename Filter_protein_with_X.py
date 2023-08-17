#!/usr/bin/env python3

#import sys
import argparse

parser = argparse.ArgumentParser(description="Filtered protein sequences that have X")
parser.add_argument("-f", "--file", help="Fasta with proteins")
parser.add_argument("-o", "--output", help="Filtered output")
args, unknown = parser.parse_known_args()

sequences = {}
header = ""
data = ""
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
            #if data.count('X') == 0:
                #sequences[header] = data


with open(args.output, "w") as good_out:
    for header, prot_seq in sequences.items():
        if prot_seq.find("X") == -1:
            good_out.write("{}\n{}\n".format(header, prot_seq))

                    
                    