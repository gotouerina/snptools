##从RFMIX开始，使用切分好染色体的beagle后的VCF文件
##重命名VCF文件
for i in *.gz; do perl addid.pl $i $i.vcf; done
##提取XPEHH的map文件
