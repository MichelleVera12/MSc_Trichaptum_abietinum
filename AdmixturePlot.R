
##CV errors

cv<-read.table("CV_newplot.txt")
k <- seq(1,6,1)
cv <- cbind(cv,k)
plot(k, cv$V4, xlab="K" ,ylab="CV error", col="red", pch=16, cex=2)
axis(1,seq(1,6,1))
#save as pdf:
pdf("admixture_cv_newplot.pdf")
plot(k, cv$V4, xlab="K" ,ylab="CV error", col="red", pch=16, cex=2)
axis(1,seq(1,6,1))
dev.off()


##Admixture plot 

individuals <- read.table("Hybrids_Europe_NewPlot.pedind")

Sample_coordinates <- read.csv2("AllSamples_coordinates.csv")

Sample_coordinates$lat <- as.numeric(Sample_coordinates$lat)
Sample_coordinates$long <- as.numeric(Sample_coordinates$long)
str(Sample_coordinates)

pedind_map <- cbind(individuals,Sample_coordinates) 

str(pedind_map)

##select colors for the plot

mycolors <- c("#118AB2","#FFD166", "#06D6A0","#EF476F")



#k=1

K_one_incl <- read.table("Hybrids_Europe_definitivesamples_newplot.1.Q")
mergedAdmixtureTable_k1 = cbind(K_one_incl, individuals)
ordered_k1 = mergedAdmixtureTable_k1[order(mergedAdmixtureTable_k1$V6),]
colnames(ordered_k1) <- c("k1","ind", "fam", "father","mother","sex","pop")
rownames(ordered_k1) <- ordered_k1$ind
par(mgp =c(3,0.5,0))
barplot(t(as.matrix(subset(ordered_k1, select=k1))), col=mycolors, border=NA, las=2, names.arg = (ordered_k1$V1), cex.names = 0.7)


#k=2 and k=3

# Load Q files
K2 <- read.table("Hybrids_Europe_definitivesamples_newplot.2.Q")
K3 <- read.table("Hybrids_Europe_definitivesamples_newplot.3.Q")

#Combine the files with the metadata
data_k2 <- cbind(K2, individuals)
data_k3 <- cbind(K3, individuals)

#Rename columns
colnames(data_k2) <- c("k1", "k2","ind", "fam", "father","mother","sex","pop")
colnames(data_k3) <- c("k1", "k2", "k3","ind", "fam", "father","mother","sex","pop")

# Order per population
data_k2$pop <- factor(data_k2$pop, levels = sort(unique(data_k2$pop)))
data_k3$pop <- factor(data_k3$pop, levels = sort(unique(data_k3$pop)))
data_k2 <- data_k2[order(data_k2$pop), ]
data_k3 <- data_k3[order(data_k3$pop), ]

#Create matrix per barplot
admix_matrix_k2 <- t(as.matrix(data_k2[, c("k1", "k2")]))
admix_matrix_k3 <- t(as.matrix(data_k3[, c("k1", "k2", "k3")]))

#Count samples per population
pop_counts <- table(data_k2$pop)
pop_names <- names(pop_counts)
space_vals <- rep(0, length(pop_counts))
space_vals_full <- rep(0, ncol(admix_matrix_k2))
pop_ends <- cumsum(pop_counts)
space_vals_full[pop_ends[-length(pop_ends)]] <- 1

#Labels axis X
label_positions <- sapply(pop_names, function(p) {
  inds <- which(data_k2$pop == p)
  mean(inds)
})

#Colors
mycolors_k2 <- c("#118AB2", "#FFD166")
mycolors_k3 <- c("#FFD166","#118AB2","#8E44AD")

par(mfrow = c(2, 1), mar = c(3, 4, 2, 1), mgp = c(3, 0.5, 0))

#Plot k=2
bar_positions_k2 <- barplot(
  admix_matrix_k2,
  col = mycolors_k2,
  border = NA,
  names.arg = rep("", ncol(admix_matrix_k2)),
  las = 1,
  space = space_vals_full,
  yaxt = "s"
)

#Plot k=3
bar_positions_k3 <- barplot(
  admix_matrix_k3,
  col = mycolors_k3,
  border = NA,
  names.arg = rep("", ncol(admix_matrix_k3)),
  las = 1,
  space = space_vals_full,
  yaxt = "s"
)

#labels axis X
axis(
  side = 1,
  at = sapply(pop_names, function(p) mean(bar_positions_k3[data_k3$pop == p])),
  labels = pop_names,
  tick = FALSE,
  line = 0.5,
  cex.axis = 0.8,
  las = 1
)
