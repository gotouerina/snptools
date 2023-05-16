## arg shell
## sh callSNP_step3.sh rus0 cahirinus.fasta
samplename=$1
ref=$2
##标记重复序列
gatk MarkDuplicates -I ${samplename}.sort.bam -O ${sampelname}.sort.markdup.bam -M ${samplename}.sort.markdup_metrics.txt
##建立索引
samtools index ${samplename}.sort.markdup.bam
##GVCF caller
gatk HaplotypeCaller --java-options -Xmx30G -R $ref  --emit-ref-confidence GVCF -I ${samplename}.sort.markdup.bam -O ${samplename}.gvcf
