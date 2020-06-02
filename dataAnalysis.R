## load packages
library(tidyverse)#for loading data, visualization, ...
library(lmerTest)#load package for repeated measures ANOVA
library(emmeans)
library(RColorBrewer)

## load data
setwd("C:/Users/ahren/Documents/repos/Intro-R-Psychoacoustics")
dataframe <- read_csv("dataForR.csv",
                      col_types = cols(
                        Subject = col_factor(),
                        Condition = col_factor(c("reference","processing1","processing2","processing3")),
                        ListenerType = col_factor(),
                        SRT = col_double()
                      )
)

## make sure that all datatypes are correct
dataframe


## make a plot
f <- ggplot(dataframe,aes(x=Condition,y=SRT,fill=ListenerType))

f+geom_col(position=position_dodge())

f+geom_boxplot()

f+geom_boxplot()+geom_jitter(width=.1,shape=4)

f+geom_boxplot()+geom_jitter(aes(colour=ListenerType),width=.1,shape=4)

f+geom_boxplot()+geom_jitter(aes(colour=ListenerType),width=.1,shape=4)+theme_bw

f+geom_boxplot()+geom_jitter(aes(colour=ListenerType),width=.1,shape=4)+theme_bw()+labs(y="SRT [dB]",x="")

f+geom_boxplot()+geom_jitter(aes(colour=ListenerType),width=.1,shape=4)+
  theme_bw()+labs(y="SRT [dB]",x="")+theme(text = element_text(size=16))

ggsave("plot.png")

## stats

model1 <- lmer(SRT ~ Condition*ListenerType  + (1 | Subject), data = dataframe)
step_result <- step(model1)
step_result
model2 <- get_model(step_result)
anova(model2)
ranova(model2)

# multiple comparisons
emm <- emmeans(model1, ~ Condition,lmer.df = "satterthwaite")
test(emm)
rbind(pairs(emm), adjust="bonferroni")
