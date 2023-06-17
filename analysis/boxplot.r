## 带显著性的箱线图,以dxy为例
##文件结构
##fusion 0.324144
##fusion 0.645413
##nofusion 0.31216

library("ggplot2")
library("ggsignif")
library(ggpubr)
library(RColorBrewer)
break1 <- read.table("C:/Users/11974/Desktop/dxymean ",header= FALSE,
                     col.names = c("group","dxy") )


p<- ggplot(data=break1)+ ylim(0,1)+
  geom_boxplot(mapping=aes(x=group,y=dxy,colour = group ), #箱线图
               alpha = 0.5,
               size=1.5,
               width = 0.6)+ 
  geom_jitter(mapping=aes(x=group,y=dxy,colour = group), #散点
              alpha = 0.3,size=0.5)+
  scale_color_manual(limits=c("fusion","nofusion"), 
                     values=c("#85B22E","#5F80B4"))+ #颜色
  geom_signif(mapping=aes(x=group,y=dxy), # 不同组别的显著性
              comparisons = list(c("fusion", "nofusion") # 哪些组进行比较
                                 ),
              map_signif_level=T, # T显示显著性，F显示p value
              tip_length=c(0,0,0,0,0,0,0,0,0,0,0,0), # 修改显著性线两端的长短
              y_position = c(0.9,1,1,1,1,1), # 设置显著性线的位置高度
              size=1, # 修改线的粗细
              textsize = 4, # 修改显著性标记的大小
              test = "t.test")+ # 检验的类型
  theme_classic(  # 主题设置，这个是无线条主题
    base_line_size = 1 # 坐标轴的粗细
  )+
  labs(title="cah_rus_dxy",x="",y="dxy")+ # 添加标题，x轴，y轴内容
  theme(plot.title = element_text(size = 15,
                                  colour = "black",
                                  hjust = 0.5),
        axis.title.y = element_text(size = 15, 
                                    # family = "myFont", 
                                    color = "black",
                                    face = "bold", 
                                    vjust = 1.9, 
                                    hjust = 0.5, 
                                    angle = 90),
        legend.title = element_text(color="black", # 修改图例的标题
                                    size=15, 
                                    face="bold"),
        legend.text = element_text(color="black", # 设置图例标签文字
                                   size = 10, 
                                   face = "bold"),
        axis.text.x = element_text(size = 13,  # 修改X轴上字体大小，
                                   color = "black", # 颜色
                                   face = "bold", #  face取值：plain普通，bold加粗，italic斜体，bold.italic斜体加粗
                                   vjust = 0.5, # 位置
                                   hjust = 0.5, 
                                   angle = 0), #角度
        axis.text.y = element_text(size = 13,  
                                   color = "black",
                                   face = "bold", 
                                   vjust = 0.5, 
                                   hjust = 0.5, 
                                   angle = 0) 
  )
p
