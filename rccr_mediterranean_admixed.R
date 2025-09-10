
library(ggplot2)
library(dplyr)
library(scales)
library(patchwork)  # for combining ggplots

# Load your data
msmc <- read.table("cross3_combined_mediterranean_admixed_default_s.msmc2.final.txt", header=TRUE)


# Parameters
mu <- 8.08e-8         # mutation rate
gen_time <- 1         # generation time in years (adjust if needed)

# Convert time
msmc$time <- msmc$left_time_boundary/(mu*gen_time)

# Calculate Ne = 1/lambda/2*mu for each pop
msmc$Ne_Mediterranean <- (1 / msmc$lambda_00) / (2*mu)
msmc$Ne_admixed <- (1 / msmc$lambda_11) / (2*mu)

# Calculate RCCR - RCCR = (2*lambda01/(lambda00+lambda11))
msmc$rccr <- (2*msmc$lambda_01/(msmc$lambda_00+msmc$lambda_11))

# Ne plot
ne_plot <- ggplot(msmc, aes(x = time)) +
  geom_step(aes(y = Ne_Mediterranean, color = "mediterranean"), size = 1.5) +
  geom_step(aes(y = Ne_admixed, color = "admixed"), size = 1.5) +
  scale_x_log10(labels = comma) +
  scale_y_log10(labels = scales::comma_format(accuracy = 1)) +
  scale_color_manual(values = c(
    "mediterranean" = "#FFD166", 
    "admixed" = "darkorange"
  )) +
  labs(x = NULL, y = "Ne (log10)", color = "Population") +
  theme_minimal() +
  theme(
    legend.position = "top",
    axis.text = element_text(size = 12),
    axis.title = element_text(size = 12),
    legend.text = element_text(size = 12),
    legend.title = element_text(size = 12))

# RCCR plot
rccr_plot <- ggplot(msmc, aes(x = time, y = rccr)) +
  geom_step(color = "darkgreen", size = 1.5) +
  scale_x_log10(labels = comma) +
  coord_cartesian(ylim = c(0, 1.2)) +
  labs(x = "log10 Generations ago (g = 1 year, μ = 8.08e-8)", y = "Relative cross-coalescence rate") +
  theme_minimal() + 
  theme(
   axis.title.x =  element_text(size = 12),
   axis.title.y = element_text(size = 12)
  )

# Combine using patchwork
combined_plot <- ne_plot / rccr_plot + plot_layout(heights = c(2, 1))
print(combined_plot)
