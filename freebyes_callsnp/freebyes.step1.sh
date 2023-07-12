# freebyes超快速度call snp
#software: fastp sambamba bwa sambamba freebyes vcflib(vcffilter) vcftools

ref=$1
fq1=$2
fq2=$3
samplename=$4

#  step1 建立索引
bwa index $ref
samtools faidx $ref

#  step2 过滤重测序数据
fastp -l 45 -q 20 -w 15 -i $fq1 -I $fq2 -o ${samplename}_clean_1.fq.gz -O ${samplename}_clean_2.fq.gz

#  step3 比对
bwa mem -t 30 -R "@RG\tID:${samplename}\tPL:illumina\tLB:${samplename}\tSM:${samplename}" $ref ${samplename}_1.fq.gz ${samplename}_2.fq.gz | samtools sort -@ 2 -m 10G -o ${samplename}.sort.ba
m

#  step4 信息统计
samtools flagstat ${samplename}.sort.bam > ${samplename}.flagstat
samtools coverage ${samplename}.sort.bam > ${samplename}.coverage

# step5 去除重复序列
sambamba markdup ${samplename}.sort.bam  ${samplename}.markdup.bam
