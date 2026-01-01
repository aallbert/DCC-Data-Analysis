source("utils/map_data.r")

data.raw <- read.table(
  "./data/drug_consumption.csv",
  sep = ",",
  header = TRUE,
  stringsAsFactors = FALSE
)

data.mapped <- map_drug_data(data.raw)

library(skimr)

skimr::skim(data.mapped)

head(data.mapped)

usage.score <- c(
  'Never Used' = 0,
  'Used over a Decade Ago' = 1,
  'Used in Last Decade' = 2,
  'Used in Last Year' = 3,
  'Used in Last Month' = 4,
  'Used in Last Week' = 5,
  'Used in Last Day' = 6
)

data.scored <- data.mapped

data.scored[substance.cols] <- lapply(
  data.mapped[substance.cols],
  function(col) usage.score[col]
)

data.scored$total_consumption <- rowSums(
  data.scored[substance.cols],
  na.rm = TRUE
)


data.scored$Education <- factor(
  data.scored$Education,
  levels = c(
    'Left School Before 16 years',
    'Left School at 16 years',
    'Left School at 17 years',
    'Left School at 18 years',
    'Some College, No Certificate Or Degree',
    'Professional Certificate / Diploma',
    'University Degree',
    'Masters Degree',
    'Doctorate Degree'
  ),
  ordered = TRUE
)


library(dplyr)

education_summary <- data.scored %>%
  group_by(Education) %>%
  summarise(
    mean_consumption = mean(total_consumption, na.rm = TRUE),
    sd_consumption   = sd(total_consumption, na.rm = TRUE),
    n                = n()
  )

education_summary

library(ggplot2)

ggplot(education_summary, aes(x = Education, y = mean_consumption)) +
  geom_col() +
  coord_flip() +
  labs(
    x = "Education level",
    y = "Average total consumption score",
    title = "Average drug consumption by education level"
  )


# punktplot für wie gebildet wie oft was
library(tidyr)
library(dplyr)

data.long <- data.scored %>%
  pivot_longer(
    cols = all_of(substance.cols),
    names_to = "Substance",
    values_to = "UsageScore"
  )

data.long$Education_num <- as.numeric(data.long$Education)

ggplot(
  data.long,
  aes(
    x = UsageScore,
    y = Education_num,
    color = Substance
  )
) +
  geom_point(alpha = 0.3, size = 1) +
  scale_y_continuous(
    breaks = seq_along(levels(data.scored$Education)),
    labels = levels(data.scored$Education)
  ) +
  labs(
    x = "Recency of use (0 = never, 6 = last day)",
    y = "Education level",
    title = "Raw drug use observations by education level and substance"
  )

heatmap_data <- data.long %>%
  group_by(Education, UsageScore, Substance) %>%
  summarise(count = n(), .groups = "drop")

ggplot(heatmap_data,
       aes(
         x = UsageScore,
         y = Education,
         fill = count
       )) +
  geom_tile() +
  facet_wrap(~ Substance) +
  scale_fill_viridis_c() +
  labs(
    x = "Recency of use (0 = never, 6 = last day)",
    y = "Education level",
    fill = "Number of observations",
    title = "Distribution of drug use recency by education level and substance"
  )

prop_data <- data.long %>%
  group_by(Education, Substance, UsageScore) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(Education, Substance) %>%
  mutate(prop = n / sum(n))

ggplot(prop_data,
       aes(
         x = Education,
         y = prop,
         fill = factor(UsageScore)
       )) +
  geom_col() +
  facet_wrap(~ Substance) +
  labs(
    x = "Education level",
    y = "Proportion",
    fill = "Recency of use"
  ) +
  theme(
    axis.text.x = element_text(angle = 90, hjust = 1),
    legend.position = "right"
  )