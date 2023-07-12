# freebyes超快速度call snp
#software: fastp sambamba bwa sambamba freebyes vcflib(vcffilter) vcftools

ref=$1

#  step1 建立索引
bwa index $ref
samtools faidx $ref
