##外部传参shell
##example sh callSNP_step2.sh rus0_1.fastq.gz rus0_2.fastq.gz rus0
ref=ca.fa
fq1=$1
fq2=$2
samplename=$3
##过滤测序数据
fastp -l 45 -q 20 -w 15 -i $fq1 -I $fq2 -o ${samplename}_clean_1.fq.gz -O ${samplename}_clean_2.fq.gz
##比对
bwa mem -t 30 -R "@RG\tID:${samplename}\tPL:illumina\tLB:${samplename}\tSM:${samplename}" $ref ${samplename}_clean_1.fq.gz ${samplename}_clean_2.fq.gz
##sam2bam
samtools view -b -S ${samplename}.sam > ${samplename}.bam
samtools sort ${samplename}.bam  -@ 2 -m 10G -o ${samplename}.sort.bam
##stat count
samtools flagstat ${samplename}.sort.bam > ${samplename}.flagstat
samtools coverage ${samplename}.sort.bam > ${samplename}.coverage
