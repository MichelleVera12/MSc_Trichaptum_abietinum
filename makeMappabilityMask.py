#!/usr/bin/env python

import gzip
import sys

class MaskGenerator:
  def __init__(self, filename, chr):
    self.lastCalledPos = -1
    self.lastStartPos = -1
    sys.stderr.write("making mask {}\n".format(filename))
    self.file = gzip.open(filename, "w")
    self.chr = chr

  # assume 1-based coordinate, output in bed format
  def addCalledPosition(self, pos):
    if self.lastCalledPos == -1:
      self.lastCalledPos = pos
      self.lastStartPos = pos
    elif pos == self.lastCalledPos + 1:
      self.lastCalledPos = pos
    else:
      self.file.write("{}\t{}\t{}\n".format(self.chr, self.lastStartPos - 1, self.lastCalledPos))
      self.lastStartPos = pos
      self.lastCalledPos = pos

with open("/cluster/projects/nn9699k/Speciomics/Michelle/Sequences/data_analysis/msmc/SNPable/split_TA10106M1Ref_reads35_mask.50.fa", "r") as f:
  for line in f:
    if line.startswith('>'):
      chr = line.split()[0][1:]
      mask = MaskGenerator("/cluster/projects/nn9699k/Speciomics/Michelle/Sequences/data_analysis/msmc/masks/TA10106M1Ref_{}.mask.bed.gz".format(chr), chr)
      pos = 0
      continue
    for c in line.strip():
      pos += 1
      if pos % 1000000 == 0:
        sys.stderr.write("processing pos:{}\n".format(pos))
      if c == "3":
        mask.addCalledPosition(pos)
