# sh freebayes.step3.sh $ref
ref=$1
freebayes -f $ref -L bamlist > output.vcf
vcffilter  -f "TYPE = snp & QUAL > 20" output.vcf > raw1.vcf
vcftools --remove-indels --recode --recode-INFO-all --vcf raw1.vcf  --maf 0.05 --minDP 5 --maxDP 50 --minGQ 20 --hwe 0.001 --max-missing 0.8 --stdout  > raw2.vcf
bcftools filter -g 5 -O v raw2.vcf -o final.vcf
