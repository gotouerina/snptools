#! /bin/bash
#rfmix pipeline
#created by kogoorimasaki
vcf=$1
chr=$2

#extract species list , and split it into ref.txt and tag.txt for your need by hand
zless $vcf |grep 'REF' > species.list

#extract chr
vcftools --gzvcf $vcf  --chr LG01 --recode --recode-INFO-all --stdout > $chr.vcf

#generate map file
perl -F'\t' -alne '$,="\t";$i=$F[1]* 0.000554779412;  print $F[0],$F[2],$i,$F[1] unless /#/' $chr.vcf > $chr.genetic.map
cat $chr.genetic.map | awk '{print $1,$4,$3}' > $chr.genetic.map.rfmix

##beagle
java -jar -Xmn12G -Xms24G -Xmx50G  /data/01/user157/software/beagle.22Jul22.46e.jar  nthreads=20  map=2.$chr.genetic.map gt=$chr.vcf  out=$chr.input.beagle

##extract species of ref
vcftools --gzvcf $chr.input.beagle.vcf.gz   --keep  ref.txt  --recode --recode-INFO-all --out $chr.REF.recode.vcf

##extract species of tag species
vcftools --gzvcf  $chr.input.beagle.vcf.gz   --keep  tag.txt  --recode --recode-INFO-all --out $chr.TAG.recode.vcf

##rfmix this step should modify the ref.txt file by group
/data/01/user214/fsc/rfmix/rfmix  -f $chr.TAG.recode.vcf.recode.vcf  -r  $chr.REF.recode.vcf.recode.vcf  -g $chr.genetic.map -m ref.txt -o Ma  --chromosome=$chr
