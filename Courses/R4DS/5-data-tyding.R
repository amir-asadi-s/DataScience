library(tidyverse)
library(ggthemes)

table1

table2

table3

# Compute rate per 10,000
table1 |> 
  mutate(
    rate = cases / (population /10000)
  )

# Compute total cases per year
table1 |> 
  group_by(year) |> 
  summarise(
    total_cases = sum(cases),
    n = n()
  )

# 5.2.1 Exercises ---------------------------------------------------------

# 1- For each of the sample tables, describe what each observation and each column represents.
# 2- Sketch out the process you’d use to calculate the rate for table2 and table3. You will need to perform four operations:

#Extract the number of TB cases per country per year.
#Extract the matching population per country per year.
#Divide cases by population, and multiply by 10000.
#Store back in the appropriate place.

table2 |> 
  group_by(country, year) |> 
  mutate(
    cases = count[type == 'cases'],
    population = count[type == 'population']
  ) |> 
  distinct(country, year, cases, population) |> 
  mutate(
    rate = cases / population * 10000
  )

table2 |> 
  pivot_wider(
    id_cols = c('country', 'year'),
    names_from = 'type',
    values_from = 'count'
  ) |> 
  mutate( 
    rate = cases / population * 10000
  )


# 5.3.1 Data in column names ----------------------------------------------

billboard
view(billboard) 
glimpse(billboard)

billboard |> 
  pivot_longer(
    cols = starts_with('wk'),
    names_to = 'week', 
    values_to = 'rank',
    values_drop_na = TRUE
    
  ) |> 
  mutate(
    week = readr::parse_number(week)
  ) |> 
  ggplot(aes(x = week, y = rank, group = track)) +
  geom_line(alpha = 0.25) + 
  scale_y_reverse()

vignette("pivot")

# 5.3.2 How does pivoting work? -------------------------------------------

df <- tribble(
  ~id,  ~bp1, ~bp2,
  "A",  100,  120,
  "B",  140,  115,
  "C",  120,  125
)

df |> 
  pivot_longer(
    cols = bp1:bp2,
    names_to = 'measurment',
    values_to = "value"
  )

# relig_income
relig_income
glimpse(relig_income)

income <-  relig_income |> 
  pivot_longer(
    cols = !religion,
    names_to = 'income_level',
    values_to = "count"
  )


#  5.3.3 Many variables in column names -----------------------------------

who2 |> 
  pivot_longer(
    cols = ! c(country, year),
    names_sep = '_',
    names_to = c("diagnosis", "gender", "age"),
    values_to = 'count'#,
    #values_drop_na = TRUE
  )


# 5.3.4 Data and variable names in the column headers ---------------------

household |> 
  pivot_longer(
    cols = !family,
    names_to = c('.value', 'object'),
    names_sep = '_',
    values_drop_na = TRUE
  )

df <- data.frame(
  'id' = c('A', 'B'),
  'x_1' = c(1, 5),
  'x_2' = c(2, 6),
  'y_1' = c(3, 7),
  'y_2' = c(4, 8)
)

df |> 
  pivot_longer(
    cols = !id,
    names_to = c('.value', 'num'),
    names_sep = '_'
  )


# 5.4 Widening data -------------------------------------------------------

cms_patient_experience

# 6 measure for each org.
cms_patient_experience |> 
  distinct(measure_cd, measure_title)

cms_patient_experience |> 
  pivot_wider(
    names_from = measure_cd, 
    values_from = prf_rate
  )

cms_patient_experience |> 
  pivot_wider(
    id_cols = starts_with('org'),
    names_from = measure_cd, 
    values_from = prf_rate
  )


#  5.4.1 How does pivot_wider() work? -------------------------------------

df <- tribble(
  ~id, ~measurement, ~value,
  "A",        "bp1",    100,
  "B",        "bp1",    140,
  "B",        "bp2",    115, 
  "A",        "bp2",    120,
  "A",        "bp3",    105
)
df

df |> 
  distinct(measurement) |> 
  pull()

df |> 
  pivot_wider(
    id_cols = id,
    names_from = measurement,
    values_from = value,
  )

df |> 
  select( - measurement, - value) |> 
  distinct()

df <- tribble(
  ~id, ~measurement, ~value,
  "A",        "bp1",    100,
  "A",        "bp1",    102,
  "A",        "bp2",    120,
  "B",        "bp1",    140, 
  "B",        "bp2",    115
)

df |> 
  pivot_wider(
    id_cols = id,
    names_from = measurement,
    values_from = value,
  )
