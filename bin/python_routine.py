#!/usr/bin/env python

"""
Suppose you want to use Pandas for some purpose. 
In this case we just take file head and output a file. 
However, this could be any operation, with argparse to manage I/O.
"""

import argparse
import pandas as pd 
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='return first 5 lines of a .tsv loaded via pandas')
    parser.add_argument('--input_filename', 
        dest='input_filename', 
        action='store',
        help='path to input filename')
    parser.add_argument('--output_tag', 
        dest='output_tag', 
        action='store',
        default = ".head5.tsv",
        help='path to input filename')
    parser.add_argument('--sep', 
        dest='sep', 
        action='store',
        default='\t',
        help='seperator for input file')

    args = parser.parse_args()
    df = pd.read_csv(args.input_filename, sep = args.sep)
    df = df.head(5)
    df.to_csv(f"{args.input_filename}{args.output_tag}", sep = args.sep)
