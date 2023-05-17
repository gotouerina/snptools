# SNP_call

Software: bwa , samtools , gatk

Bwa   https://github.com/lh3/bwa

Samtools https://github.com/lh3/bwa

Gatk https://github.com/broadinstitute/gatk

To install bwa , type

    conda install bwa
To install samtools , type

    conda install samtools

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
