# https://exomiser.readthedocs.io/en/stable/installation.html

# Download the Exomiser program (small, fast)
# path had to be modified as the one in the documentation didn't work
wget https://github.com/exomiser/Exomiser/releases/download/15.1.0/exomiser-cli-15.1.0-distribution.zip

# Download the data files (large — allow several hours)
wget https://g-879a9f.f5dc97.75bc.dn.glob.us/data/2512_phenotype.zip
wget https://g-879a9f.f5dc97.75bc.dn.glob.us/data/2512_hg38.zip
wget https://g-879a9f.f5dc97.75bc.dn.glob.us/data/2512_hg19.zip

# Extract the program
unzip exomiser-cli-15.1.0-distribution.zip

# Extract the data files into the data subdirectory
unzip 2512_hg19.zip -d exomiser-cli-15.1.0/data
unzip 2512_hg38.zip -d exomiser-cli-15.1.0/data
unzip 2512_phenotype.zip -d exomiser-cli-15.1.0/data

# Navigate into the Exomiser folder
cd exomiser-cli-15.1.0

# Make a directory for saving remm files
mkdir -p /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/remm/hg19 /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/remm/hg38

# download remm files from https://remm.bihealth.org/download
wget -c -P /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/remm/hg38 "https://kircherlab.bihealth.org/download/ReMM/ReMM.v0.4.hg38.tsv.gz"
wget -c -P /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/remm/hg38 "https://kircherlab.bihealth.org/download/ReMM/ReMM.v0.4.hg38.tsv.gz.tbi"

wget -c -P /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/remm/hg19 "https://kircherlab.bihealth.org/download/ReMM/ReMM.v0.4.hg19.tsv.gz"
wget -c -P /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/remm/hg19 "https://kircherlab.bihealth.org/download/ReMM/ReMM.v0.4.hg19.tsv.gz.tbi"

# make changes in the application.properties file to add the file path to /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/remm/hg38/ReMM.v0.4.hg38.tsv.gz ; similarly for hg19
# make sure to uncomment those lines

# download cadd files from https://cadd.gs.washington.edu/download
wget -c -P /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/cadd/hg19 "https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/whole_genome_SNVs.tsv.gz"
wget -c -P /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/cadd/hg19 "https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/whole_genome_SNVs.tsv.gz.tbi"
wget -c -P /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/cadd/hg19 "https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/gnomad.genomes-exomes.r4.0.indel.tsv.gz"
wget -c -P /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/cadd/hg19 "https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh37/gnomad.genomes-exomes.r4.0.indel.tsv.gz.tbi"


wget -c -P /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/cadd/hg38 "https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/whole_genome_SNVs.tsv.gz"
wget -c -P /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/cadd/hg38 "https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/whole_genome_SNVs.tsv.gz.tbi"
wget -c -P /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/cadd/hg38 "https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/gnomad.genomes.r4.0.indel.tsv.gz"
wget -c -P /NAS/aishwaryav/mva_hackathon/exomiser/exomiser-cli-15.1.0/data/cadd/hg38 "https://krishna.gs.washington.edu/download/CADD/v1.7/GRCh38/gnomad.genomes.r4.0.indel.tsv.gz.tbi"





