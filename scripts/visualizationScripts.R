# libraries used throughout project
library(ggplot2)
library(waffle)
library(tidyverse)
library(ggrepel)
library(RColorBrewer)

# Code for visualizations starts below this comment.
# Continually clicking "Run" in RStudio will display each plot in the script one by one


# Most common ways of winning
ggplot(combined, aes(fill = Var1, values = Freq)) +
  geom_waffle(n_rows = 100,
              size = 0.33,
              colour = "#bbbbbb") +
  scale_fill_manual(
    name = NULL,
    values = c("#b3de69", "#fdb462", "#80b1d3"),
    labels = c("DEC (1722)", "KO/TKO (1116)", "SUB (621)")
  ) +
  coord_equal() +
  theme_void()


# Wins by stance
ggplot(stance, aes(x = stance, y = win_percentage, fill = stance)) +
  geom_col(position = position_dodge()) +
  labs(title = "Win Percentage Per Stance",
       x = "Stance",
       y = "Win Percentage")


# Win percentage by reach
ggplot(reach_combined,
       aes(x = source, y = win_percentage * 100, fill = source)) +
  geom_col(position = position_dodge()) +
  labs(title = "Win Percentage by Reach",
       x = "",
       y = "Win Percentage") +
  theme_minimal()


# Win percentage for fighters above/below division's average reach
ggplot(avg_reach_combined,
       aes(x = source, y = win_percentage * 100, fill = source)) +
  geom_col(position = position_dodge()) +
  labs(title = "Win Percentage for Fighters Above/Below Division's Average Reach",
       x = "",
       y = "Win Percentage",
       fill = "Reach") +
  theme_minimal() +
  scale_fill_brewer(palette = "Dark2")


# Title win percentage for fighters above/below divison's average reach
ggplot(championship_avg_reach_combined,
       aes(x = source, y = win_percentage * 100, fill = source)) +
  geom_col(position = position_dodge()) +
  labs(title = "Championship Win Percentage for Fighters Above/Below Division's Average Reach",
       x = "",
       y = "Win Percentage",
       fill = "Reach") +
  scale_y_continuous(limits = c(0, 60)) +
  scale_fill_brewer(palette = "Dark2")


# Total wins by fighter age
ggplot(wins_by_age, aes(
  x = age,
  y = wins,
  color = age > mean(age)
)) +
  geom_point(size = 3) +
  scale_color_manual(values = c("blue", "red"), guide = "none") +
  labs(title = "Total Wins by Fighter Age",
       x = "Fighter Age",
       y = "Total Wins") +
  theme_minimal() +
  scale_x_continuous(breaks = pretty(wins_by_age$age, n = 27)) +
  scale_y_continuous(limits = c(0, 400)) +
  theme(plot.title = element_text(face = "bold"))


# Win percentage by fighter age
ggplot(age_group_percent, aes(x = age, y = win_percentage * 100)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Win Percentage by Fighter Age",
       x = "Fighter Age",
       y = "Win Percentage") +
  theme_minimal() +
  scale_x_continuous(breaks = pretty(age_group_percent$age, n = 29)) +
  theme(plot.title = element_text(face = "bold"))


# Wins by days since last fight
ggplot(last_fight_table,
       aes(x = days_since_last_comp, y = win_percentage * 100)) +
  geom_point(alpha = 0.6) + 
  geom_smooth(method = "lm",
              se = FALSE,
              color = "blue") +
  labs(title = "Win Percentage by Days Since Last Fight",
       x = "Days Since Last Fight",
       y = "Win Percentage") +
  theme(panel.border = element_rect(
    color = "darkblue",
    fill = NA,
    linewidth = 10
  ))


# Avg punches per knockout
ggplot(knockout_table_ranking[1:10,],
       aes(x = fighter, y = knockout_efficiency)) +
  geom_bar(stat = "identity", fill = "#001F3F") +
  labs(title = "Fighter Ranking Based on Average Punches per Knockout",
       x = "Fighter",
       y = "Avg Punches per Knockout") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Resilience/strength of chin
ggplot(resilience[1:10,], aes(x = reorder(
  paste(
    fighter,
    "\nHead Strikes:",
    total_head_strikes,
    "\nKO Losses:",
    ko_losses
  ),
  rank_score
), y = rank_score)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Fighter Rankings based on Head Strikes and KO Losses",
       x = "Fighter",
       y = "Rank Score") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  coord_flip() 