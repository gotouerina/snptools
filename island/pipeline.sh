##提取5% fst vcf,bash
##vcf文件使用bgzip 压缩并tabix建立索引
##使用批处理提取高fst位点
perl -F'\s+' -alne  'print "bcftools filter acomys.vcf.gz --regions $F[0]:$F[1]-$F[2] > $F[0]:$F[1]-$F[2].vcf" ' > split.sh
##sh split.sh
##合并
perl merge.pl > island
##rm *.vcf
