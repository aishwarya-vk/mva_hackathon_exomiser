#!/usr/bin/env bash
# Usage: phase_region.sh <ref.fa> <vcf.gz> <fastq_dir> <chr:start-end>
# region in VCF naming; reference uses chr-prefixed names
# run in env containing bbmap, minimap2, samtools, bcftools, htslib, whatshap

set -euo pipefail

if [ $# -ne 4 ]; then
  echo "Usage: $0 <ref.fa> <vcf.gz> <fastq_dir> <chr:start-end>" >&2
  exit 1
fi

REF=$1
VCF=$2
FQDIR=$3
REGION=$4

CHR=${REGION%%:*}                 
REF_REGION="chr${REGION}"         

SAMPLE=$(bcftools query -l "$VCF" | head -1)
OUT=phase_${REGION//[:-]/_}
mkdir -p "$OUT"

# 1. region sequence
samtools faidx "$REF" "$REF_REGION" > "$OUT/target.fa"

# 2. bait read pairs from every lane that share 31-mers with the region
for R1 in "$FQDIR"/*_L00?_R1*.fastq.gz; do
  R2=${R1/_R1/_R2}
  L=$(basename "$R1" | grep -oE 'L00[0-9]')
  bbduk.sh in1="$R1" in2="$R2" ref="$OUT/target.fa" k=31 hdist=0 threads=32 \
    outm1="$OUT/bait_${L}_R1.fq.gz" outm2="$OUT/bait_${L}_R2.fq.gz"
done
cat "$OUT"/bait_L00?_R1.fq.gz > "$OUT/bait_R1.fq.gz"
cat "$OUT"/bait_L00?_R2.fq.gz > "$OUT/bait_R2.fq.gz"

# 3. align baited reads to the whole genome
minimap2 -ax sr -t 32 -R "@RG\tID:bait\tSM:${SAMPLE}" "$REF" \
  "$OUT/bait_R1.fq.gz" "$OUT/bait_R2.fq.gz" \
  | samtools sort -@ 8 -o "$OUT/bait.bam"
samtools index "$OUT/bait.bam"

# 4. VCF records in the region, renamed to match the reference (15 -> chr15)
bcftools view -r "$REGION" "$VCF" \
  | bcftools annotate --rename-chrs <(echo -e "${CHR}\tchr${CHR}") -Oz -o "$OUT/region.vcf.gz"
tabix -p vcf "$OUT/region.vcf.gz"

# 5. phase
whatshap phase --reference "$REF" -o "$OUT/region.phased.vcf" \
  "$OUT/region.vcf.gz" "$OUT/bait.bam"

# 6. result: genotype and phase set for every het in the region
echo -e "CHROM\tPOS\tREF\tALT\tGT\tPS"
bcftools query -i 'GT="het"' -f '%CHROM\t%POS\t%REF\t%ALT\t[%GT\t%PS]\n' "$OUT/region.phased.vcf"
