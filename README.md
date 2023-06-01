# SNPpipeline 分析流程

Update on 2023.6.1 v1.0

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


 #  Structure
 
 Download the admixture by typing
 
        wget https://github.com/stevemussmann/admixturePipeline/archive/master.zip
        unzip master.zip

for more information ,read https://github.com/NovembreLab/admixture

# RFmix

RFmix : https://github.com/slowkoni/rfmix

To install , type

        git clone https://github.com/slowkoni/rfmix.git;
        cd rfmix;
        autoreconf --force --install 
        ./configure           
        make
 
 and example files are in folder
 
 # Dsuite
 
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
 
 # SMC++
        
 SMC++:https://github.com/popgenmethods/smcpp
 
 The follow download is recommanded : 
        
        wget https://github.com/popgenmethods/smcpp/releases/download/v1.15.2/smcpp-1.15.2-Linux-x86_64.sh
        sh smcpp-1.15.2-Linux-x86_64.sh
  

# FastEPRR(重组率)
        
        Download from : https://www.picb.ac.cn/evolgen/softwares/
        R CMD INSTALL FastEPRR_2.0.tar.gz
        
        
        
