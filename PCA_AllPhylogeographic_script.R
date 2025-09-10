library(ggplot2)

list.files()
# Import the eigenvalue (eval) and eigenvector (evec) file 
eval <- read.table("pca_HybridsSF.eval") 
evec <- read.table("pca_HybridsSF.evec")

# Have a look at the files
head(eval)
head(evec)
levels(evec[,12])
as.factor(evec[,12])
as.factor(evec$V12)
levels(evec$PC11)
str(evec)
str(eval)

# Calculate the contribution to axis 1 and 2
evec1.pc <- round(eval[1,1]/sum(eval)*100,digits=2) #take eigenvalue 1, divide by sum of all eigenvalues, multiply by 100 for %.
evec2.pc <- round(eval[2,1]/sum(eval)*100,digits=2)
evec3.pc <- round(eval[3,1]/sum(eval)*100,digits =2)

# find how much genetic variation is explained by the first two eigenvectors
names(evec) <- c("sample","PC1","PC2","PC3","PC4","PC5","PC6","PC7","PC8","PC9","PC10","Genetic group")

#add column group 
evec$`Data group` <- "previous data"
evec$`Data group`[134:171] <- "new data"

#Modify the names of the new data to include the location and name of sample
evec$`Genetic group`[134:143] <-"Austria TA_1208_3"
evec$`Genetic group`[144] <-"Austria TA_1208"
evec$`Genetic group`[148:150]<- "Czech Republic TA_1253"
evec$`Genetic group`[151:159] <-"Czech Republic TA_1253_3"
evec$`Genetic group`[160:161]<- "Czech Republic TA_1253"
evec$`Genetic group`[162:170] <-"Czech Republic TA_1253_7"
                              
# Define the colors.
mycolors <- c("darkcyan", "olivedrab2","lightgreen","#118AB2","darkorange","mediumorchid4","mediumorchid2","violet","lightskyblue","#FFD166","slateblue2")

#Plot the second and third column (eigenvector 1 and 2)

#pdf("sample_labels_PCA.pdf", height=20, width = 20)

p_1 <-ggplot(evec, aes(x = PC1, y = PC2, shape = `Data group`)) + labs (
  x = paste("eigenvector1\n", evec1.pc, "% of observed genetic variation", sep = ""),
  y = paste("eigenvector2\n", evec2.pc, "% of observed genetic variation", sep = ""),
) + geom_point(aes(col =`Genetic group`), size = 3) + scale_color_manual(values=mycolors) + scale_shape_manual(values = c("previous data" = 16, "new data" = 17))
p_1
p_1 + geom_text(label = evec$sample)

dev.off()

p_2 <- ggplot(evec, aes(x = PC1, y = PC3, shape = `Data group`)) + labs (
  x = paste("eigenvector1\n", evec1.pc, "% of observed genetic variation", sep = ""),
  y = paste("eigenvector3\n", evec3.pc, "% of observed genetic variation", sep = ""),
) + geom_point(aes(col = `Genetic group`), size = 3) + scale_color_manual(values=mycolors) + scale_shape_manual(values = c("previous data" = 16, "new data" = 17))

p_2
