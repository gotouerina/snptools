#  软件下载
推荐使用conda下载 

    conda install bwa
    conda install samtools
    conda install -c bioconda vcflib
    conda install -c bioconda sambamba

freebyes推荐使用编译好的包

    https://github.com/freebayes/freebayes/releases/download/v1.3.6/freebayes-1.3.6-linux-amd64-static.gz
    gzip -d freebayes-1.3.6-linux-amd64-static.gz
    mv freebayes-1.3.6-linux-amd64-static freebayes
    ./freebayes

#  建立索引

ref为参考基因组

    sh freebayes.step1.sh $ref

#   数据过滤和比对

    sh freebayes.step2.sh $fq1 $fq2 $samplename

#    CALL SNP 与 过滤
