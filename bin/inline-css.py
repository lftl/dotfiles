#!/usr/bin/python2

import argparse
from premailer import transform

parser = argparse.ArgumentParser(description='Transform CSS and links')
parser.add_argument('src', type=str)
args = parser.parse_args()

f = open(args.src, 'r')
print transform(f.read())
