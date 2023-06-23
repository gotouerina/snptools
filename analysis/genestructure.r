library(ggplot2)
library(ggbio)
library(ggh4x)
library(GenomicRanges)
df <- read.csv("C:/Users/11974/Desktop/lg10.gtf",sep = "\t",header = F)
waxy<-GRanges("LG10",IRanges(df$V4,end=df$V5,group=df$V3))

autoplot(waxy,aes(fill=group),geom="alignment")+
  theme_bw()+
  scale_x_continuous(limits = c(46590033,46611307),
                     breaks = c(seq(46590033,46611307,by=1000)),
                     position = "top")+
  theme(panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.line.x = element_line(),
        axis.ticks.length = unit(0.2,'cm'))+
  guides(x=guide_axis_truncated(trunc_lower = 46592333,
                                trunc_upper = 46611307))+
  scale_fill_manual(values = c("#92d050","#a6a6a6","#a6a6a6"))+
  theme(aspect.ratio = 0.1)+
  scale_y_continuous(limits = c(0,3))+
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank())+
  annotate(geom = "text",x=46590500,y=1,
           label="cahirinus\n(ZFX:evm.TU.LG10.376)")+
  coord_cartesian(clip="off")
