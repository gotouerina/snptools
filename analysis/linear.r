##线性回归
##df structure
##Chr length sd_counts
library("ggplot2")
df <- read.table("C:/Users/11974/Desktop/example.txt",sep = " ",header = F)

##线性回归计算拟合显著性
#modle <- lm(formula = V2 ~ V3,data = df)
#summary(modle)

ggplot(df,aes(x=V2,y=V3))+geom_point(size=7, color = "red" )+geom_smooth(method='lm') + theme_bw()+ 
theme(panel.grid.major=element_blank(),panel.grid.minor=element_blank())+
  xlab("Chr Length")+ylab("SD counts")+ ggtitle("Title1")+geom_text(aes(label=V1), size = 2)+
  theme(plot.title = element_text(hjust = 0.5))
