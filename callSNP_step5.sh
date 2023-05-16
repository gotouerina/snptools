##过滤Indel
gatk SelectVariants -select-type SNP -V all.tmp.vcf.gz -O ./all.snp.vcf.gz
##SNP硬过滤
gatk VariantFiltration -V ./all.snp.vcf.gz  --filter-expression "QD < 2.0 || MQ < 40.0 || FS > 60.0 || SOR > 3.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" --filter-name "Filter" -O ./all.hardfilter.vcf.gz
#SNPsoft filter
vcftools --remove-indels --recode --recode-INFO-all --gzvcf ./all.hardfilter.vcf.gz --maf 0.05 --minDP 5 --maxDP 50 --minGQ 20 --hwe 0.001 --max-missing 0.8 --stdout  > raw1.snp.vcf
bcftools filter -g 5 -O v raw1.snp.vcf -o raw2.snp.vcf
grep -v 'Filter' raw2.snp.vcf > final.vcf
