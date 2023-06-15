#!/bin/bash

#usage:
#      ref = $sra #放在Indexref文件夹中
#if [ ! -d "IndexRef" ];then
#        mkdir IndexRef
#fi

ref=E
minicondaPATH=
psmcPATH=

####为参考组建立索引###
bwa index IndexRef/$ref.fna
###fastp过滤###
fastp -l 45 -q 20 -w 15 -i IndexRef/$ref.1.fq.gz -I IndexRef/$ref.2.fq.gz -o IndexRef/$ref.1.out.fq.gz -O IndexRef/$ref.2.out.fq.gz
###比对###
bwa mem -t 30 -R '@RG\tID:$ref\tPL:illumina\tLB:$ref\tSM:$ref' IndexRef/$ref.fna  IndexRef/$ref.1.out.fq.gz  IndexRef/$ref.2.out.fq.gz | samtools view -Sb - > IndexRef/$ref.bam
###排序###
samtools sort -@ 4 -m 4G -O bam -o IndexRef/$ref.sort.bam IndexRef/$ref.bam
###标记重复序列###
gatk MarkDuplicates -I IndexRef/$ref.sort.bam -O IndexRef/$ref.sort.markdup.bam -M IndexRef/$ref.sort.markdup_metrics.txt
###去除重复序列###
samtools rmdup IndexRef/$ref.sort.markdup.bam IndexRef/$ref.sort.rmdup.bam
###计算测序深度###
samtools depth IndexRef/$ref.sort.markdup.bam -a > IndexRef/$ref.test.depth
###计算平均深度###
cat IndexRef/$ref.test.depth|awk '{sum+=$3} END {print "", sum/NR}' > IndexRef/depth
###将bam文件转换为fastq格式的一致性序列###
cat IndexRef/depth | awk -F "." '{print$1}' > value
declare -i d
d=`cat value`
x=$((d/3))
y=$((d*2))
bcftools mpileup -C50 -u -f IndexRef/$ref.fna IndexRef/$ref.sort.rmdup.bam  | bcftools call -c | vcfutils.pl vcf2fq -d $x -D $y | gzip > IndexRef/$ref.fq.gz
###将fastq文件转换为psmcfa格式###
$psmcPATH/utils/fq2psmcfa -q20 IndexRef/$ref.fq.gz > IndexRef/$ref.psmcfa
$psmcPATH/utils/splitfa IndexRef/$ref.psmcfa > IndexRef/$ref.split.psmcfa
###使用psmc对每个个体进行1+100次bootstrap重复估算###
$psmcPATH/psmc -N25 -t15 -r5 -p  “4+25*2+4+6” -o IndexRef/$ref.psmc IndexRef/$ref.psmcfa  # 这是1次
seq 100 | xargs -i echo $psmcPATH/psmc -N25 -t15 -r5 -b -p “4+25*2+4+6” -o IndexRef/round-{}.$ref.psmc IndexRef/$ref.split.psmcfa | sh #这是100次
###cat101次结果###
cat IndexRef/$ref.psmc IndexRef/round-*.$ref.psmc > IndexRef/$ref.combined.psmc
###绘图###
$psmcPATH/utils/psmc_plot.pl -u 3.0e-9 -g 0.25 combined IndexRef/$ref.combined.psmc
