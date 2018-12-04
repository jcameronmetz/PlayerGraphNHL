library(ggplot2)
library(gghighlight)
library(tidyverse)
library(stringr)
library(dplyr)
library(tibble)
library(tidyr)

DMX <- experts.csv
X<-total19.csv

DMX
X

dmx<-mutate(X, 
            CurrentPointperGame = round(P/GP,2),
            CurrentGoalperGame = round(G/GP,2),
            CurrentSOGperGame = round(G/(iSh/100)/GP,2),
            CurrentAssistperGame =  round(A/GP,2),
            CurrentShooting = iSh)
dmx


right <- select(dmx,Player,Team,G,A,P,CurrentPointperGame, CurrentAssistperGame,  CurrentGoalperGame)
right              


WU <- mutate(DMX, ExpertPointperGame = Points/GP)


left <- select(WU,Player,ExpertPointperGame,Points)


WUTANG <- left_join(right, left, by = "Player")

WUTANG

toFwith <- mutate(WUTANG, 
                  DeltaPoints = round(ExpertPointperGame - CurrentPointperGame,2),
                  Player1 = paste(Player," ", DeltaPoints))

toFwith

wutangaint <- na.omit(toFwith)

wutangaint

beastie <- arrange(wutangaint, -Points)
beastie

boys<- beastie %>%
  filter(str_detect(Team, "BOS") | str_detect(Team, "TOR")| str_detect(Team, "T.B") | str_detect(Team, "FLA") | str_detect(Team, "OTT") | str_detect(Team, "BUF")| str_detect(Team, "DET")| str_detect(Team, "MTL") | str_detect(Team, "WSH") | str_detect(Team, "PHI")| str_detect(Team, "CAR") | str_detect(Team, "PIT") | str_detect(Team, "NYR") | str_detect(Team, "NYI")| str_detect(Team, "N.J")| str_detect(Team, "CBJ"))
boys

low <-filter(boys, DeltaPoints < -.3)
high <-filter(boys, DeltaPoints > .15)

q<-gghighlight_point(low, aes(CurrentPointperGame, ExpertPointperGame), CurrentPointperGame >.5,  label_key = Player1, colour = "green", size = 1) +
  ggtitle("OverPerforming Expectations?")

q





q<-gghighlight_point(high, aes(CurrentPointperGame, ExpertPointperGame), ExpertPointperGame >.6,  label_key = Player1, colour = "red", size = 3) +
  ggtitle("Underperforming Expectations?")

q

write.csv(boys, file="pointspergame.csv")



filt


