library(tidyverse)
library(concordance)

# load data
df <- readxl::read_excel("data/derived/list_medical_products.xlsx")

# rename columns
df <- df %>% 
  filter(!is.na(Nr)) %>% 
  rename(
    no = Nr,
    hs6_2007 = `HS Code`,
    group = Group,
    description = Description,
    old = Old
  ) %>% 
  mutate(old = if_else(old == "*", TRUE, FALSE, missing = FALSE))

# make sure no entries are missing
setdiff(1:207, df$no)
setdiff(df$no, 1:207)

df <- df %>% 
  select(!no)

# convert from HS 3 (2007) to HS 5 (2017) 
df <- df %>% 
  mutate(hs6_2017 = concord(hs6_2007,
                       origin = "HS3", 
                       destination = "HS5",
                       dest.digit = 6)) %>% 
  relocate(starts_with("hs"))

# 23 HS codes cannot be matched, because not in HS3 (but earlier versions), 184 correctly converted

# iteratively look up NAs with earlier HS versions
# df <- df %>%
#   mutate(hs6_2017 = if_else(
#     is.na(hs6_2017),
#     concord(
#       hs6_2007,
#       origin = "HS2",
#       destination = "HS5",
#       dest.digit = 6
#     ),
#     hs6_2017)) %>% 
#   mutate(hs6_2017 = if_else(
#     is.na(hs6_2017),
#     concord(
#       hs6_2007,
#       origin = "HS1",
#       destination = "HS5",
#       dest.digit = 6
#     ),
#     hs6_2017)) %>% 
#   mutate(hs6_2017 = if_else(
#     is.na(hs6_2017),
#     concord(
#       hs6_2007,
#       origin = "HS0",
#       destination = "HS5",
#       dest.digit = 6
#     ),
#     hs6_2017))

# save
write_csv(df, "medical_products.csv")
