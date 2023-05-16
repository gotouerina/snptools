## combine Gvcf
ref=cahirinus.fasta
gatk CombineGVCFs -R $ref \
--variant $sample1.gvcf \
--variant $sample2.gvcf \
--variant $sample3.gvcf \
--variant $sampel4.gvcf \
--variant $sample5.gvcf \
-O tmp.gvcf ;

##genotype
gatk GenotypeGVCFs -R $ref -V ./tmp.gvcf  -O  ./all.tmp.vcf
bgzip -f ./all.tmp.vcf
tabix -p vcf ./all.tmp.vcf.gz
