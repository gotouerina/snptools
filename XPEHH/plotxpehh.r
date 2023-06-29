library(ggplot2)
library(ggrastr)

a <- read.table("C:/Users/11974/Desktop/LG13.out.xpehh.out.norm",sep='\t',header = T)
avg <- mean(a$normxpehh)
p1 = ggplot(data = a, mapping = aes(x = pos, y = normxpehh)) +
  geom_point_rast(colour ="#C1CDCD")+ theme_bw()+
  theme(panel.grid = element_blank())+
  geom_vline(aes(xintercept= 57173487),linetype=2,col="blue")+
  geom_vline(aes(xintercept= 59752803),linetype=2,col="blue")+
  geom_hline(aes(yintercept= avg ),linetype=2,col="red")
