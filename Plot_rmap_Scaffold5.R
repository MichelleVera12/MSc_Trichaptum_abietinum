list.files()

#Load the data

rmap_TA1208_3_Scaffold05_bp10_ws25 <- read.table("TA_1208_3_Scaffold05_pyrho_optimize.rmap", col.names = c("start","end","rate"))
rmap_TA1253_3_Scaffold05_bp20_ws30 <- read.table("TA_1253_3_Scaffold05_pyrho_optimize.rmap", col.names = c("start","end","rate"))
rmap_TA1253_7_Scaffold05_bp15_ws30 <- read.table("TA_1253_7_Scaffold05_pyrho_optimize.rmap", col.names = c("start","end","rate"))


#par(mfrow=c(2,1))

##y_lim_max per spore family

y_lim_max_05_TA_1208_3 <- max(rmap_TA1208_3_Scaffold05_bp10_ws25$rate, na.rm = TRUE)
y_lim_max_05_TA_1253_3 <- max(rmap_TA1253_3_Scaffold05_bp20_ws30$rate, na.rm = TRUE)
y_lim_max_05_TA_1253_7 <- max(rmap_TA1253_7_Scaffold05_bp15_ws30$rate, na.rm = TRUE)


##bp10_ws50

par(mfrow = c(3,1))

plot(y=rmap_TA1208_3_Scaffold05_bp10_ws25$rate,x=(rmap_TA1208_3_Scaffold05_bp10_ws25$start+rmap_TA1208_3_Scaffold05_bp10_ws25$end)/2,type="l",lwd=2,col="lightgreen",xlab="Genomic position",ylab="r",ylim=c(0,y_lim_max_05_TA_1208_3),main="TA_1208_3_Scaffold05, bp 10, ws 25", cex.axis = 1.5, cex.lab = 1.5, cex.main = 1.5)
plot(y=rmap_TA1253_3_Scaffold05_bp20_ws30$rate,x=(rmap_TA1253_3_Scaffold05_bp20_ws30$start+rmap_TA1253_3_Scaffold05_bp20_ws30$end)/2,type="l",lwd=2,col="mediumorchid2",xlab="Genomic position",ylab="r",ylim=c(0,y_lim_max_05_TA_1253_3),main="TA_1253_3_Scaffold05, bp 20, ws 30", cex.axis = 1.5, cex.lab = 1.5, cex.main = 1.5)
plot(y=rmap_TA1253_7_Scaffold05_bp15_ws30$rate,x=(rmap_TA1253_7_Scaffold05_bp15_ws30$start+rmap_TA1253_7_Scaffold05_bp15_ws30$end)/2,type="l",lwd=2,col="violet",xlab="Genomic position",ylab="r",ylim=c(0,y_lim_max_05_TA_1253_7),main="TA_1253_7_Scaffold05, bp 15, ws 30", cex.axis = 1.5, cex.lab = 1.5, cex.main = 1.5)

