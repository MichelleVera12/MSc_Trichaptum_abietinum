library(vcfR)
library(dplyr)


# Read your VCF
vcf <- read.vcfR("TA_1208_3_SporeFamilyFB_miss50.vcf")
# Extract genotype field
gt <- extract.gt(vcf, element = "GT")  # matrix of genotype strings

str(gt)
head(gt)

# Change gt to data frame format
df_gt <- as.data.frame(gt)
head(df_gt)
str(df_gt)

##Remove all NA's from FB column

df_FBnoNA <- df_gt %>% 
  filter(!is.na(TA_1208_3_FB))

head(df_FBnoNA)

##Add columns for the columns of FB (diploid)


df_FBnoNA$TA_1208_3_FB1 <- substr(df_FBnoNA$TA_1208_3_FB,1,1)

head(df_FBnoNA)

df_FBnoNA$TA_1208_3_FB2 <- substr(df_FBnoNA$TA_1208_3_FB,3,3)

write.table(df_FBnoNA, file = "TA_1253_3_Sporefamily_NoNa.txt") 


##Different version with the TA_1253_FB, TA_1253_FB1 and TA_1253_3_FB2 columns removed

df_NoFBcolumn <- subset(df_FBnoNA,select = -c(TA_1208_3_FB,TA_1208_3_FB1,TA_1208_3_FB2))
head(df_NoFBcolumn)


###Singleton rows on df_NoFBcolumn

singleton_rows <- apply(df_NoFBcolumn, 1, function(x) {
  tab <- table(x)
  length(tab) == 2 && any(tab == 1)
})

singleton_snps <- df_NoFBcolumn[singleton_rows, ]

head(singleton_snps)


singleton_rows_tab1 <- apply(df_NoFBcolumn, 1, function(x) {
  tab <- table(x) 
  any(tab == 1)
})

singleton_snps_tab1 <-df_NoFBcolumn[singleton_rows_tab1, ]

head(singleton_snps_tab1)


##Subset the data frame df_FBnoNa to only get the values TA_1253_FB1 and TA_1253_FB2

df_FB1_2 <- df_FBnoNA[ ,11:12]


head(df_FB1_2)

##Select the matching rows between NOFB_singleton_rows and TA_1253_FB1, TA_1253_FB2

df_FB1_2_snps <- df_FB1_2[rownames(singleton_snps), ]
head(df_FB1_2_snps)
head(singletons_snps_NoFB)


df_FB1_2_snps_tab1 <- df_FB1_2[rownames(singleton_snps_tab1) ,]
head(df_FB1_2_snps_tab1)


# Apply the function on the Allele column (individual)

singleton_snps_tab1$Allele <- apply(singleton_snps_tab1[, 1:9], 1, function(x) {
  x <- as.character(x)         # makes sure that is a character vector 
  tbl <- table(x)              # counts how many times the allele appears
  singleton <- names(tbl[tbl == 1])  # extracts the allele that appears only once, singleton
  
  if (length(singleton) == 1) {
    return(singleton) 
    
  } else if (length(singleton) == 2) {
    return("two alleles")
  } else {
    return(NA)                 # if there's more than one, returns NA
  }
})

str(singleton_snps_tab1)

str(singleton_snps_tab1)

table(singleton_snps_tab1$Allele)
nchar(singleton_snps_tab1$Allele)


###Multiallelic information

singleton_snps_twoAlleles <-which(singleton_snps_tab1$Allele == "two alleles")

singleton_snps_twoAlleles <-singleton_snps_tab1[singleton_snps_twoAlleles, ]


############mismatch

Singleton_snps_ <-subset(singleton_snps_tab1,select = -c(Allele))


#Vector to save the index with only one mismatch
one_mismatch_rows <- c()

#Loop to check row per row
for (i in 1:nrow(Singleton_snps_)) {
  # Extract the rows without NAs
  row_values <- na.omit(as.vector(as.matrix(Singleton_snps_[i, ])))
  
  #Values of reference from the Fruitbody dataframe (two columns)
  ref_values <- as.vector(as.matrix(df_FB1_2_snps_tab1[i, ]))
  
  #Count how many values on the row are not present in the reference values from the fruitbody
  mismatches <- sum(!row_values %in% ref_values)
  
  # Save if there is exactly only one mismatch
  if (mismatches == 1) {
    one_mismatch_rows <- c(one_mismatch_rows, i)
  }
}

# Show the rows where the criteria works
Singleton_snps_with_1_mismatch <- Singleton_snps_[one_mismatch_rows, ]

Singleton_snps_with_1_mismatch_NoNas <- na.omit(Singleton_snps_with_1_mismatch)

unique(one_mismatch_rows)

Singleton_snps_[998, ]
df_FB1_2_snps_tab1[998, ]


###############

singleton_snps_twoAlleles_ <- subset(singleton_snps_twoAlleles,select = -c(Allele))

df_FB1_2_snps_Multiallelic <- df_FB1_2_snps_tab1[rownames(singleton_snps_twoAlleles_), ]

# Vector to save the sites with only one mismatch
one_mismatch_rows_Multiallelic <- c()

# Run in each row
for (i in 1:nrow(singleton_snps_twoAlleles_)) {
  # Extract rows without NAs
  row_values_Multiallelic <- na.omit(as.vector(as.matrix(singleton_snps_twoAlleles_[i, ])))
  
  #Values of reference from the Fruitbody dataframe (two columns)
  ref_values_Multiallelic <- as.vector(as.matrix(df_FB1_2_snps_Multiallelic[i, ]))
  
  #Count how many values on the row are not present in the reference values from the fruitbody
  mismatches_Multiallelic <- sum(!row_values_Multiallelic %in% ref_values_Multiallelic)
  
  # Save if there is exactly only one mismatch
  if (mismatches_Multiallelic == 1) {
    one_mismatch_rows_Multiallelic <- c(one_mismatch_rows_Multiallelic, i)
  }
}

singleton_snps_twoAlleles_1missmatch_ <- singleton_snps_twoAlleles_[one_mismatch_rows_Multiallelic, ]
singleton_snps_twoAlleles_1missmatch_NoNas <- na.omit(singleton_snps_twoAlleles_1missmatch_NoNas)

##Check if the filtering was correct on a defined site

unique(one_mismatch_rows_Multiallelic)
singleton_snps_twoAlleles_[97, ]
df_FB1_2_snps_Multiallelic[97, ]


##########################################################################################
