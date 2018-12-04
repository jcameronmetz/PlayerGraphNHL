library(ggplot2)
library(gghighlight)
library(tidyverse)
library(stringr)
library(dplyr)
library(tibble)
library(tidyr)
library(ggrepel)
library(lattice)
library(psych)
library(reshape2)


thres<-read.csv(file="/Users/cmetz.GTSCPA/Desktop/Perfect Hockey Files/threeyearmean.csv", header = TRUE)


thres


summary(thres)


tres <- mutate(thres, Gpg = round(G/GP,2),
               Apg = round(A/GP,2),
               Ppg = round(P/GP,2),
               SOGpg = round(G/(iSh./100)/GP,2),
               iSh.)


yellow<- select(tres, c(Player, Gpg, Apg, Ppg))

yellow


jeep<- merge(yellow,right, by = "Player")


describe(jeep)

bayonne<-t(jeep)
bayonne

plant<-melt(jeep, id.vars= "Player")
plant



tallyman<-data.frame(unique(plant$variable, incomparables = FALSE))
tallyman

colnames(tallyman)[1] <- "variable"
tallyman

stat<- c("Goals", "Assists", "Points","NA","NA","NA","NA","Points","Assists","Goals")
series<-c("Mean","Mean","Mean","NA","NA","NA","NA","Current","Current","Current")

cats<-data.frame(tallyman,stat,series)
cats
plant


str(plant)
str(cats)

graphdf<- left_join(plant,cats, by="variable", all.x = TRUE)

graphdf

M= "STEVEN.STAMKOS"

pgraph <-filter(graphdf, Player == M, series != "NA")
pgraph

pgraph$value=as.numeric(pgraph$value)


plod <- ggplot(data=pgraph, aes(x=stat, y=value, fill=series))+
  geom_bar(stat="identity", position = position_dodge2(preserve = "single")) +
  scale_y_continuous(breaks=seq(0,8,by=.25))+
  geom_text(aes(label= value),position=position_dodge(width=0.9), vjust=-0.25, size =4)+
  geom_text(aes(label=round(value*82,0)),position=position_dodge(width=0.9), vjust=3, size =5, color = "blue", fontface=4)+
  ggtitle(M) +
  labs(caption="All data from Corsica", size =.2)



plod

qplot(series, value, data = pgraph) + facet_wrap(~stat)
