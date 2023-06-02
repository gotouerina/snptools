##草稿

bcftools view -H sample.snp.vcf.gz | cut -f 1 | uniq | awk '{print $0"\t"$0}' > chrom-map.txt
vcftools --gzvcf sample.snp.vcf.gz --plink-tped --chrom-map chrom-map.txt --out sample

cat sample.tfam |awk '{print $1"\t"$2"\t"$1}' >sample.pop.cov
plink --threads 12 --tfile sample --freq --allow-extra-chr --within sample.pop.cov
python2 /path/to/plink2treemix.py plink.frq.strat.gz sample.treemix.in.gz

treemix -i sample.treemix.in.gz -o sample -tf sample.tre -root outgroup1,outgroup2 -m 3 -k 1000 -se -bootstrap -global -noss
