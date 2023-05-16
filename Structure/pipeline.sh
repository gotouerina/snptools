#! /bin/bash
vcf=$1
##将vcf文件转为ped文件
vcftools --vcf $vcf --plink --out try.plink 
##数据格式转换
plink --noweb --file try.plink  --geno 0.05 --maf 0.05 --hwe 0.0001 --make-bed --out try.plink 
##admixture
for k in 1 2 3 4 5 6 7 8 9 10; do admixture --cv try.plink.bed $k | tee log${k}.out; done
##CV值提取，最低的为最优模型，选较低的四个画图
grep -h CV log*.out
