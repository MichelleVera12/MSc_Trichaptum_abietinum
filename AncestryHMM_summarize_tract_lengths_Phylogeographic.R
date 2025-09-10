library("tidyverse")
library("gtools")

##AdmC:
#Combine all samples in dataframe:
TA_1053_1_M4 <- read.table("TA_1053_1_M4.viterbi")
TA_1053_1_M4$sample <- "TA_1053_1_M4"
TA_1053_1_M4$tract.length <- TA_1053_1_M4$V3 - TA_1053_1_M4$V2
TA_1056_1_M2 <- read.table("TA_1056_1_M2.viterbi")
TA_1056_1_M2$sample <- "TA_1056_1_M2"
TA_1056_1_M2$tract.length <- TA_1056_1_M2$V3 - TA_1056_1_M2$V2
TA_1056_3_M3 <- read.table("TA_1056_3_M3.viterbi")
TA_1056_3_M3$sample <- "TA_1056_3_M3"
TA_1056_3_M3$tract.length <- TA_1056_3_M3$V3 - TA_1056_3_M3$V2
TA_1056_5_M2 <- read.table("TA_1056_5_M2.viterbi")
TA_1056_5_M2$sample <- "TA_1056_5_M2"
TA_1056_5_M2$tract.length <- TA_1056_5_M2$V3 - TA_1056_5_M2$V2
TA_1056_7_M2 <- read.table("TA_1056_7_M2.viterbi")
TA_1056_7_M2$sample <- "TA_1056_7_M2"
TA_1056_7_M2$tract.length <- TA_1056_7_M2$V3 - TA_1056_7_M2$V2
TA_1056_9_M2 <- read.table("TA_1056_9_M2.viterbi")
TA_1056_9_M2$sample <- "TA_1056_9_M2"
TA_1056_9_M2$tract.length <- TA_1056_9_M2$V3 - TA_1056_9_M2$V2
TA_1057_4_M3 <- read.table("TA_1057_4_M3.viterbi")
TA_1057_4_M3$sample <- "TA_1057_4_M3"
TA_1057_4_M3$tract.length <- TA_1057_4_M3$V3 - TA_1057_4_M3$V2
TA_1057_6_M3 <- read.table("TA_1057_6_M3.viterbi")
TA_1057_6_M3$sample <- "TA_1057_6_M3"
TA_1057_6_M3$tract.length <- TA_1057_6_M3$V3 - TA_1057_6_M3$V2
TA_1057_10_M2 <- read.table("TA_1057_10_M2.viterbi")
TA_1057_10_M2$sample <- "TA_1057_10_M2"
TA_1057_10_M2$tract.length <- TA_1057_10_M2$V3 - TA_1057_10_M2$V2
TA_1193_1_M1 <- read.table("TA_1193_1_M1.viterbi")
TA_1193_1_M1$sample <- "TA_1193_1_M1"
TA_1193_1_M1$tract.length <- TA_1193_1_M1$V3 - TA_1193_1_M1$V2
TA_1194_2_M1 <- read.table("TA_1194_2_M1.viterbi")
TA_1194_2_M1$sample <- "TA_1194_2_M1"
TA_1194_2_M1$tract.length <- TA_1194_2_M1$V3 - TA_1194_2_M1$V2
TA_1194_4_M1 <- read.table("TA_1194_4_M1.viterbi")
TA_1194_4_M1$sample <- "TA_1194_4_M1"
TA_1194_4_M1$tract.length <- TA_1194_4_M1$V3 - TA_1194_4_M1$V2

TA_1208_3_M6 <- read.table("TA_1208_3_M6.viterbi")
TA_1208_3_M6$sample <- "TA_1208_3_M6"
TA_1208_3_M6$tract.length <- TA_1208_3_M6$V3 - TA_1208_3_M6$V2
TA_1208_4_M6<- read.table("TA_1208_3_M6.viterbi")
TA_1208_4_M6$sample <- "TA_1208_4_M3"
TA_1208_4_M6$tract.length <- TA_1208_4_M6$V3 - TA_1208_4_M6$V2
TA_1253_1_M2 <-read.table("TA_1253_1_M2.viterbi")
TA_1253_1_M2$sample <- "TA_1253_1_M2"
TA_1253_1_M2$tract.length <- TA_1253_1_M2$V3 - TA_1253_1_M2$V2  
TA_1253_2_M1 <- read.table("TA_1253_2_M1.viterbi")
TA_1253_2_M1$sample <- "TA_1253_2_M1"
TA_1253_2_M1$tract.length <- TA_1253_2_M1$V3 - TA_1253_2_M1$V2
TA_1253_3_M2 <-read.table("TA_1253_3_M2.viterbi")   
TA_1253_3_M2$sample <- "TA_1253_3_M2"
TA_1253_3_M2$tract.length <- TA_1253_3_M2$V3 - TA_1253_3_M2$V2
TA_1253_4_M3 <- read.table("TA_1253_4_M3.viterbi")
TA_1253_4_M3$sample <- "TA_1253_4_M3"
TA_1253_4_M3$tract.length <- TA_1253_4_M3$V3 - TA_1253_4_M3$V2
TA_1253_6_M1 <- read.table("TA_1253_6_M1.viterbi")
TA_1253_6_M1$sample <- "TA_1253_6_M1"
TA_1253_6_M1$tract.length <- TA_1253_6_M1$V3 - TA_1253_6_M1$V2


admC <- rbind(TA_1053_1_M4, 
              TA_1056_1_M2, 
              TA_1056_3_M3, 
              TA_1056_5_M2, 
              TA_1056_7_M2, 
              TA_1056_9_M2, 
              TA_1057_4_M3, 
              TA_1057_6_M3, 
              TA_1057_10_M2, 
              TA_1193_1_M1,
              TA_1194_2_M1,
              TA_1194_4_M1,
              TA_1208_3_M6,
              TA_1208_4_M6,
              TA_1253_1_M2,
              TA_1253_2_M1,
              TA_1253_3_M2,
              TA_1253_4_M3,
              TA_1253_6_M1)

str(admC)
boxplot(admC$tract.length ~ admC$sample)
par(mfrow=c(1,1))
head(admC)



#script to plot local ancestry along chromosome:
ancestry_df <- admC
colnames(ancestry_df) <- c("chr", "start", "end", "prob1", "prob2", "ancestry", "sample", "length")
#Sort scaffolds naturally
scaffold_order <- mixedsort(unique(ancestry_df$chr))
ancestry_df$chr <- factor(ancestry_df$chr, levels = scaffold_order)

#Compute scaffold lengths
scaffold_lengths <- ancestry_df %>%
  group_by(chr) %>%
  summarise(length = max(end), .groups = "drop")

#Create cumulative scaffold start positions to "concatenate" scaffolds end-to-end
scaffold_lengths <- scaffold_lengths %>%
  arrange(factor(chr, levels = scaffold_order)) %>%
  mutate(cum_start = lag(cumsum(length), default = 0))

#Join cumulative starts back to ancestry_df
ancestry_df <- ancestry_df %>%
  left_join(scaffold_lengths %>% select(chr, cum_start), by = "chr") %>%
  mutate(
    plot_start = start + cum_start,
    plot_end = end + cum_start
  )

#Prepare vertical lines for scaffold boundaries
boundaries <- scaffold_lengths %>%
  mutate(boundary = cum_start) %>%
  select(boundary)

#Also add final scaffold end boundary:
total_length <- sum(scaffold_lengths$length)
boundaries <- bind_rows(boundaries, tibble(boundary = total_length))

#Plot with ggplot2
ggplot(ancestry_df, aes(y = sample)) +
  geom_segment(aes(x = plot_start, xend = plot_end, yend = sample, color = ancestry), size = 10) +
  geom_vline(data = boundaries, aes(xintercept = boundary), linetype = "dashed", color = "black") +
  scale_color_manual(values = c("1,0" = "#118AB2", "0,1" = "#FFD166", "1,1" = "red", "0,0" = "gray")) +
  scale_x_continuous(
    name = "Position along concatenated scaffolds",
    breaks = scaffold_lengths$cum_start + scaffold_lengths$length / 2,
    labels = scaffold_lengths$chr,
    expand = c(0,0)
  ) +
  ylab("Sample") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 12),
    axis.text.y = element_text(size = 12),
    panel.grid.major.x = element_blank()
  ) +
  ggtitle("Ancestry plot with multiple scaffolds in phylogeographic dataset")
