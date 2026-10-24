java -jar exomiser-cli-15.1.0.jar analyse \
  --analysis "$ANALYSIS" \
  --vcf "$VCF" \
  --assembly hg38 \
  2>&1 | tee "${NAME}.log"
