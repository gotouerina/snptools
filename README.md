# SNPpipeline 分析流程

Update on 2023.7.18 v3.05

#   Software Install (软件安装)

Software: bwa , samtools , gatk

Bwa   https://github.com/lh3/bwa

Samtools https://github.com/lh3/bwa

Gatk https://github.com/broadinstitute/gatk

To install bwa , type

    conda install bwa

To install samtools , type

    conda install samtools

Instead of combineGVCF, you can use GenomicDBI for large number of samples.

Outgroup must be combined independently , or you will filter a lot of sites and the PCA will fail.

Beagle : To phase vcf. Website : http://faculty.washington.edu/browning/beagle/beagle.html

#   PCA （主成分分析）

To install plink, type 

    conda install -c bioconda plink

#   Tree (进化树)

To install VCF2dis , type

        wget https://github.com/hewm2008/VCF2Dis/archive/v1.47.tar.gz
        tar -zxvf  VCF2DisXXX.tar.gz
        cd VCF2DisXXX;
        make
        ./bin/VCF2Dis
 
 and then put the mat file into website :  (http://emboss.toulouse.inra.fr/cgi-bin/emboss/fneighbor?_pref_hide_optional=1)  to construct the tree

to operate the tree, Newick Utilities is recommaded.

To download  Newick Utilities

        conda install newick_utils

or from https://github.com/tjunier/newick_utils


 #  Structure（群体结构）
 
 Download the admixture by typing
 
        wget https://github.com/stevemussmann/admixturePipeline/archive/master.zip
        unzip master.zip

for more information ,read https://github.com/NovembreLab/admixture

# RFmix（基因流）

Using beagle phased vcf. 
RFmix : https://github.com/slowkoni/rfmix

To install , type

        git clone https://github.com/slowkoni/rfmix.git;
        cd rfmix;
        autoreconf --force --install 
        ./configure           
        make
 
 and example files are in folder
 
 # Dsuite（基因流）
 
 Dsuite : https://github.com/millanek/Dsuite
 
 Chromosome is recommand to split for Dsuiate and merge all by "DtriosCombine" command
 To install , follow
 
        git clone https://github.com/millanek/Dsuite.git
        cd Dsuite
        make
        cd utils
        python3 setup.py install --user --prefix=
        
 And you can read https://yanzhongsino.github.io/2022/04/10/bioinfo_geneflow_Dsuite/ for more detail. Here I only supply some useful command. You can read example sets.txt in the folder.
 
        Dsuite Dtrios sample.snp.vcf.gz sets.txt -t species.newick -o sample
        Dsuite Fbranch species.newick sample_tree.txt >fbranch.out
        Dsuite/utils/dtools.py fbranch.out species.newick --outgroup Outgroup --use_distances --dpi 1200 --tree-label-size 3
 
  #  Treemix (基因流)
 
 Ref : https://yanzhongsino.github.io/2022/03/20/bioinfo_geneflow_TreeMix/
 
 Install, type :
         
         conda install -c bioconda treemix
         conda install vcftools
         conda install bcftools
         conda install plink
 
 Or download source code from Official Website(recommand) : https://bitbucket.org/nygcresearch/treemix/downloads/
 
        wget https://bitbucket.org/nygcresearch/treemix/downloads/treemix-1.13.tar.gz
        tar -xvf treemix-1.0.tar.gz
        cd treemix-1.0
        ./configure
        make
        make install
If you do not have root permission, try 

        ./configure --prefix=`pwd`
        
The script plink2treemix.py you can download by typing ,

        wget https://bitbucket.org/nygcresearch/treemix/downloads/plink2treemix.py

Warning : It need python2 environment. 
       
 #  gIMble(基因流)
    
    The author is still updating it.
 
 # SMC++（群体历史）
        
 SMC++:https://github.com/popgenmethods/smcpp
 
 The follow download is recommanded : 
        
        wget https://github.com/popgenmethods/smcpp/releases/download/v1.15.2/smcpp-1.15.2-Linux-x86_64.sh
        sh smcpp-1.15.2-Linux-x86_64.sh

Convert your VCF(s) to the SMC++ input format with vcf2smc:

        smc++ vcf2smc my.data.vcf.gz out/chr1.smc.gz chr1 Pop1:S1,S2

每条染色体/contig跑一次，S1 S2是POP1的个体名
        
        smc++ estimate -o analysis/ 1.25e-8 out/example.chr*.smc.gz

1.25e-8是每代的突变率，可以用近缘物种代替. 模型以JSON格式存储在  analysis/model.final.json 中.

画图

        smc++ plot plot.pdf analysis/model.final.json

# PSMC(群体历史)

Git : https://github.com/lh3/psmc

        git clone https://github.com/lh3/psmc.git
        make; (cd utils; make)
        x=depth/3
        y=depth*2
        bcftools mpileup -C50 -u -f $ref.fasta $ref.sort.rmdup.bam  | bcftools call -c | vcfutils.pl vcf2fq -d $x -D $y | gzip > $ref.fq.gz
        $psmcPATH/utils/fq2psmcfa -q20 $ref.fq.gz > $ref.psmcfa
        $psmcPATH/psmc -N25 -t15 -r5 -p  “4+25*2+4+6” -o $ref.psmc $ref.psmcfa

# FastEPRR (重组率)
Using beagle phased vcf.    
        
        Download from : https://www.picb.ac.cn/evolgen/softwares/
        R CMD INSTALL FastEPRR_2.0.tar.gz
        
Make sure in step2.sh, The chromsome name is like 01 02 03, but not chr1 chr2 chr3, or it will run wrong.

# PopLDdecay (连锁不平衡)

Git : https://github.com/BGI-shenzhen/PopLDdecay

        git clone https://github.com/hewm2008/PopLDdecay.git 
        cd PopLDdecay; chmod 755 configure; ./configure;
        make;
        mv PopLDdecay  bin/;    #     [rm *.o]

If SNP file derived from GATK, run

         # calculate ld
         ./bin/PopLDdecay    -InVCF  SNP.vcf.gz  -OutStat LDdecay  
         #plot one population
         perl  bin/Plot_OnePop.pl  -inFile   LDdecay.stat.gz  -output  Fig 
         #plot multi population  example of inList see fold PopLDdecay
         perl  bin/Plot_MutiPop.pl  -inList  Pop.ResultPath.list  -output Fig


# LDBlockShow （连锁不平衡）
Git : https://github.com/BGI-shenzhen/LDBlockShow
        
        tar -zxvf  LDBlockShowXXX.tar.gz
        cd LDBlockShowXXX;  cd src;
        sh  make.sh                         ## Linux :  [ make ; make clean ]
        ../bin/LDBlockShow

# Pixy (分化参数计算)

Warnings : PIXY denpend on python version <=3.5 but > 3

        conda install pixy -c conda-forge

If your python version >= 3.0

        conda created -n Pixy -c conda-forge pixy
        conda activate Pixy

You can use this software calculate fst dxy pi one time !

        pixy --stats pi fst dxy   --vcf $vcf --window_size 10000 --n_cores 8  --populations poplist

过滤大于0小于1的值, 注意$F[5]是第六列，根据需求更改数字

        perl -F'\s+' -alne 'print if $F[5]>=0 && $F[5]<=1' dxy.txt  > dxy.filter.txt

# VCFtools (分化参数计算)
      
        vcftools --vcf $vcf --TajimaD 20000 --out $name.D ##TajimaD

# Gene Island
First, seclect the top 5% Fst region in $fst_region_file using bash command.

        perl -F'\s+' -alne  'print "bcftools filter $vcf --regions $F[0]:$F[1]-$F[2] > $F[0]:$F[1]-$F[2].vcf" '  $fst_region_file  > split.sh
and run

        sh split.sh

merge by

        perl merge.pl > island.vcf
        
To count gene island number, try bash command.

#    XPEHH signal （受选择信号）

Git : https://github.com/szpiech/selscan

To download ,type

        wget https://github.com/szpiech/selscan/releases/download/1.2.0a/linux.tar.gz
        tar -xf linux.tar.gz

Run instruction, see pipeline.sh

# Analysis Lab

Some scripts might be useful for analysis.
        
## Boxplot(箱线图)

<div align = center>
    
![boxplot](https://github.com/gotouerina/snptools/blob/main/analysis/image/boxplot.png)

Ref: DOI: 10.1016/j.cell.2020.05.032

<div align = left>
    
## Linear (线性回归)

<div align = center>
    
![boxplot](https://github.com/gotouerina/snptools/blob/main/analysis/image/linear.png)

<div align = left>

## Distribution 分布图

<div align = center>

![boxplot](https://github.com/gotouerina/snptools/blob/main/analysis/image/distribution.png)

<div align = left>
