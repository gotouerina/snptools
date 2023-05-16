#! /bin/bash
plink --vcf final.vcf --allow-extra-chr --double-id --indep-pairwise 50 10 0.1 --out try    
plink --vcf final.vcf --allow-extra-chr --double-id --extract try.prune.in --make-bed --pca  --out try
##生成try.eigenvec/try.eigenval 用R画图
