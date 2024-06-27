rm(list=ls(all=T))
setwd("C:/Users/vazqu/1.COMPU/Posdoc/Expansion/Amaurochalinus/Presencias_reales")

#----Amaurochalinus
Amauro<-read.csv2("amauro_r4.csv", header=T, sep=",")

plot(Amauro$year, Amauro$latitude, col="#27408B", ylim = c(-70, 0), cex=0.5, cex.axis=0.95, ylab = "Latitude", col.lab="#27408B")
par(new=TRUE)
plot(Amauro$year, Amauro$longitude, axes=FALSE, col="#F2AD00", ylim = c(-70,0), cex=0.5, ylab = "Longitude", col.lab="#F2AD00")
Axis(side = 4, cex.axis=0.95)


