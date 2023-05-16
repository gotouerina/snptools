library(tidyverse) 
pca <- read_table2("try.eigenvec", col_names = FALSE)
eigenval <- scan("try.eigenval")

pca <- pca[,-1] #删除eigenvec文件中的一列，因为其第一列和第二列都是一样的(个体名)

names(pca)[1] <- "ind" #把第一列改名为ind
names(pca)[2:ncol(pca)] <- paste0("PC", 1:(ncol(pca)-1)) 


spp <- rep(NA, length(pca$ind)) #spp此处可以名字可以随意
spp[grep("ca", pca$ind)] <- "cahirinus" #将个体名中含有ca的归到cahirinus群体
spp[grep("kem", pca$ind)] <- "kempi" #将个体名中含有kem的归到kempi群体
spp[grep("per", pca$ind)] <- "percivali"
spp[grep("ru", pca$ind)] <- "russatus"
spp[grep("ung", pca$ind)] <- "ungculatus"

pca <- as.tibble(data.frame(pca, spp))


b <- ggplot(pca, aes(PC1, PC2, col = spp, shape = spp)) + geom_point(size = 3)
b + xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) + ylab(paste0("PC2 (", signif(pve$pve[2], 3), "%)"))
b

