#!/usr/bin/env bash
# Run from exomiser-cli-15.1.0/. Usage: bash run_exomiser.sh <analysis.yml> <sample.vcf.gz>
ANALYSIS=$1
VCF=$2
NAME=$(basename "$ANALYSIS" .yml)

java -jar exomiser-cli-15.1.0.jar analyse \
  --analysis "$ANALYSIS" \
  --vcf "$VCF" \
  --assembly hg38 \
  2>&1 | tee "${NAME}.log"
