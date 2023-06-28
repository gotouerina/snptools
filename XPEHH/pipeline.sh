##使用过滤好二等位基因的VCF文件
vcftools --gzvcf acomys.vcf.gz --min-alleles 2 --max-alleles 2 --recode --out 2alleles.vcf
##重命名VCF文件中SNP的名字
perl addid.pl 2alleles.vcf 2alleles.rename.vcf
##切分染色体
for i in LG{01..19}; do echo -e "vcftools --gzvcf 2alleles.rename.vcf --chr $i --recode – recode-INFO-all --stdout | bgzip -c > $i.vcf.gz"
for i in *.gz ; do tabix $i
##提取map文件
for i in *.gz ; do perl -F'\t' -alne '$,="\t";$i=$F[1]* 0.000554779412;  print $F[0],$F[2],$i,$F[1] unless /#/' $i> $i.map; done
##进行beagle分型
for i in LG{01..19}; do echo -e "java -jar -Xmn12G -Xms24G -Xmx50G  /data/01/user157/software/beagle.22Jul22.46e.jar  nthreads=20  map=$i.genetic.map gt=$i.vcf  out=$i.input.beagle" >> beagle.sh;done
##提取不同种群的个体
for i in *.vcf ; do vcftools --vcf $i --keep kem.list  --recode --recode-INFO-all --out kem/$i.kem; done
for i in *.vcf ; do vcftools --vcf $i --keep cah.list   --recode --recode-INFO-all --out cah/$i.cah; done
for i in *.vcf ; do vcftools --vcf $i --keep rus.list    --recode --recode-INFO-all --out rus/$i.rus; done 
for i in *.vcf ; do vcftools --vcf $i --keep per.list    --recode --recode-INFO-all --out per/$i.per; done 
##XPEHH计算
