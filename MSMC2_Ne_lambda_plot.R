library(ggplot2)
library(dplyr)
library(scales)

# Read MSMC2 output
# austria individual
data_austria <- read.delim("TA_1208_3_low_res_all_scaffolds_idtab.txt")
# czechia individuals
data_czechia  <- read.delim("TA_1253_7_low_res_all_scaffold_id.tab.txt")
data_czechia_2 <- read.delim("TA_1253_3_low_res_all_scaffolds_id.tab.txt")


# Add scaled time and Ne using mutation rate and generation time
mutation_rate <- 8.08e-8  # Mutations per site per generation
generation_time <- 1    # Years per generation

# calcuate Ne and time in each pop

data_austria$time <- data_austria$left_time_boundary/(mutation_rate*generation_time)
data_czechia$time <- data_czechia$left_time_boundary/(mutation_rate*generation_time)
data_czechia_2$time <- data_czechia_2$left_time_boundary/(mutation_rate*generation_time)
data_austria$Ne <- (1 / data_austria$lambda) / (2*mutation_rate)
data_czechia$Ne <- (1 / data_czechia$lambda) / (2*mutation_rate)
data_czechia_2$Ne <- (1 / data_czechia_2$lambda) / (2*mutation_rate)


data <- rbind(data_austria,data_czechia, data_czechia_2)

###Plot effective population size
ggplot(data, aes(time, Ne, colour = ID)) +
  geom_step(size = 1.2) +
  scale_x_log10(labels=comma) +
  scale_y_log10(labels=comma) +
  scale_color_manual(values = c(
    "TA_1208_3" = "lightgreen",
    "TA_1253_3" = "mediumorchid2",
    "TA_1253_7" = "violet")) +
  labs(x = "Generations ago", y = "Effective population size (Ne)") +
  theme(
    plot.background = element_rect(fill = "white", colour =  NA),
    panel.background = element_rect(fill = "white", colour = NA),
    panel.grid  = element_line(colour = "grey90"), 
    axis.title.x = element_text(size = 12),
    axis.title.y = element_text(size = 12)
  )
  theme_minimal()
