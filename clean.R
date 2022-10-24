library(tidyverse)
library(concordance)

# load data
df <- readxl::read_excel("data/derived/list_medical_products.xlsx",
                         col_types = c("numeric", "text", "text", "text", "text"))

# rename columns
df <- df %>% 
  select(!Nr) %>% 
  rename(
    hs3 = `HS Code  6 digit`,
    group = Group,
    description = Description,
    old = Old
  ) %>% 
  mutate(old = if_else(old == "*", TRUE, FALSE, missing = FALSE))

# convert from HS 3 (2007) to HS 5 (2017) 
df <- df %>% 
  mutate(hs5 = concord(hs3,
                       origin = "HS3", 
                       destination = "HS5",
                       dest.digit = 6)) %>% 
  relocate(starts_with("hs"))

# save
write_csv(df, "output/medical_products.csv")