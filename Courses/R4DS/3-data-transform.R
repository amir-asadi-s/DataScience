library(tidyverse)
library(nycflights13)
glimpse(flights)

flights |> 
  filter(dest == 'IAH') |> 
  group_by(year, month, day) |> 
  summarise(
    mean_arr_delay = mean(arr_delay, na.rm = TRUE)
  )


# 3.2 Rows ----------------------------------------------------------------

flights |> 
  filter(dep_delay > 120)

# Flights that departed on January 1
flights |> 
  filter(month %in% c(1, 2)

# arrange()
flights |> 
  arrange(year, month, dep_time)

# desc()
flights |> 
  arrange(desc(dep_delay))

# distinct
dim(flights)
# Remove duplicate rows, if any
flights |> 
  distinct()

# Find all unique origin and destination pairs
flights |> 
  distinct(origin, dest)

flights |> 
  distinct(origin, dest, .keep_all = TRUE)

# find the number of occurrences
flights |> 
  count(origin, dest, sort = TRUE)


# 3.25 Excercise  ---------------------------------------------------------

# 1
## Had an arrival delay of two or more hours
flights |> 
  filter(arr_delay >= 120) |> 
  
  # Flew to Houston (IAH or HOU)
  filter(dest %in% c('IAH', 'HOU')) |> 
  # Were operated by United, American, or Delta
  filter(carrier %in% c('UA', 'DL')) |> 
  # Departed in summer (July, August, and September)
  filter(month %in% c(7, 8, 9)) 
  # Arrived more than two hours late, but didn’t leave late
flights |> 
  filter(dep_delay <= 0 & arr_delay >= 120)

# Were delayed by at least an hour, but made up over 30 minutes in flight
flights |> 
  filter(dep_delay >= 60 & arr_time > 30 )

# 2- Sort flights to find the flights with longest departure delays.
##find the flights that left earliest in the morning.
flights |> 
  arrange(desc(dep_delay)) |>
  filter(dep_time > 500 & dep_time < 1200) |> 
  arrange(dep_time)

 # 3- Sort flights to find the fastest flights. 
##(Hint: Try including a math calculation inside of your function.) 
flights |> 
  arrange(
    desc(distance / air_time)
  )

# 4 - Was there a flight on every day of 2013?
flights |> 
  distinct(month, day) |> 
  count(month) |> 
  summarise( sum(n))

# 5 -Which flights traveled the farthest distance? Which traveled the least distance?
flights |> 
  arrange(desc(distance))

flights |> 
  arrange(distance)


# 3.3 Columns -------------------------------------------------------------

flights |> 
  mutate(
    gain    = dep_delay - arr_delay,
    speed   = distance / air_time * 60,
    .after = day
  ) 

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  )

# select()
flights |> 
  select(year, month, day)

flights |> 
  select(year:day)

flights |> 
  select(!year:day)

# character columns
flights |> 
  select(where(is.character))

flights |> 
  select(where(is.integer))

flights |> 
  select(where(is.double))

flights |> 
  select(where(is.Date))

# rename
flights |> 
  select(tail_num = tailnum)

flights |> 
  rename(tail_num = tailnum)

flights |> 
  janitor::clean_names()

# relocate
flights |> 
  relocate(air_time, time_hour)

flights |> 
  relocate(year:dep_time, .after = time_hour)

flights |> 
  relocate(starts_with('arr'), .before = dep_time)

# 3.3.5 Exercises ---------------------------------------------------------

# 1 - Compare dep_time, sched_dep_time, and dep_delay. 
## How would you expect those three numbers to be related?
flights |> 
  mutate(
    test_dep_delay = dep_time - sched_dep_time,
    dep_delay, 
    .keep = 'used'
    
  )

# 2 - Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.
flights |> 
  select(dep_time, dep_delay, arr_time, arr_delay)

flights |> 
  select(
    starts_with(c('dep', 'arr'))
  )

flights |> 
  select(
    ends_with(c('delay', 'time')) & !starts_with(c('sched'))
  )
# 3- What happens if you specify the name of the same variable multiple times in a select() call?
flights |> 
  select(air_time, arr_time,air_time, air_time)

# 4- What does the any_of() function do? Why might it be helpful in conjunction with this vector?
variables <- c("year", "month", "day", "dep_delay", "arr_delay")

flights |> 
  select(any_of(variables))
?any_of

flights |> 
  select(variables)
# encounter error

# 5 -Does the result of running the following code surprise you? 
##How do the select helpers deal with upper and lower case by default? How can you change that default?
flights |> 
  select(contains("TIME"))
?contains

flights |> 
  select(contains("TIME", ignore.case = TRUE))


# Rename air_time to air_time_min to indicate units of measurement and move it to the beginning of the data frame.
flights |> 
  rename(
    air_time_min = air_time,
  ) |> 
  relocate(air_time_min)

# 7 - Why doesn’t the following work, and what does the error mean?
flights |> 
  select(tailnum) |> 
  arrange(arr_delay)
#> Error in `arrange()`:
#> ℹ In argument: `..1 = arr_delay`.
#> Caused by error:
#> ! object 'arr_delay' not found
flights |> 
  arrange(arr_delay) |> 
  select(tail_num = tailnum)


# 3.4 The pipe ------------------------------------------------------------

# find the fast flights to Houston’s IAH airport: you need to combine filter(), mutate(), select(), and arrange():
flights |> 
  filter(dest == 'IAH') |> 
  mutate(
    speed = distance / air_time * 60,
  )                     |> 
  select(carrier ,flight, tailnum, origin, distance, air_time,speed) |> 
  arrange(desc(speed))

# 3.5 Groups --------------------------------------------------------------

# group_by()
flights |> 
  group_by(month) |> 
  summarise(
    avg_delay = mean(dep_delay, na.rm = TRUE), 
    n = n()
  )

#  finds the flights that are most delayed upon arrival at each destination:
flights |> 
  group_by(dest) |> 
  slice_max(arr_delay, n = 1) |> 
  relocate(dest)

flights |> 
  group_by(dest) |> 
  slice_max(arr_delay, n = 1, with_ties = FALSE) |> 
  relocate(dest)


# 3.5.4 Grouping by multiple variables ------------------------------------

daily_flights <- flights |> 
  group_by(year, month, day)

daily_flights |>  
  summarise(n = n())

daily_flights |> 
  summarise(n = n(),
            .groups = 'keep')
rm(daily)
daily_flights |> 
  ungroup()

# 3.5.6 .by

flights |> 
  summarise(
    delay = mean(dep_delay, na.rm = T),
    n = n(),
    .by = month
  ) |> 
  arrange(month)

flights |> 
  summarise(
    delay = mean(dep_delay, na.rm = T),
    n = n(),
    .by = c(origin, dest)
  ) |> 
  arrange(desc(delay))


# 3.5.7 Exercises ---------------------------------------------------------

# 1- Which carrier has the worst average delays? 
##Challenge: can you disentangle the effects of bad airports vs. bad carriers? 
##Why/why not? (Hint: think about flights |> group_by(carrier, dest) |> summarize(n()))

flights |> 
  group_by(carrier, dest) |> 
  summarise( 
    n = n(),
    delay = mean(dep_delay, na.rm = TRUE)
    ) |> 
  arrange(desc(n))

flights |> 
  group_by(dest) |> 
  summarise( 
    n = n(),
    delay = mean(dep_delay, na.rm = TRUE)
  ) |> 
  arrange(desc(delay))
# 2 - Find the flights that are most delayed upon departure from each destination.
flights |> 
  group_by(dest) |> 
  slice_max(dep_delay, with_ties = FALSE) |> 
  relocate(dest, dep_delay) |> 
  arrange(desc(dep_delay))

# 3- How do delays vary over the course of the day. Illustrate your answer with a plot.
flights |> 
  filter(dep_delay > 0) |> 
  group_by(hour) |>
  summarise(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n()
    ) |> 
  ggplot( aes(x = hour, y = delay)) +
  geom_point() + 
  geom_smooth(method = 'loess')

# 4 - What happens if you supply a negative n to slice_min() and friends?
flights |> 
  group_by(origin) |> 
  slice_min(distance,n = -3) |> 
  relocate(origin, dest, distance)

# 5- Explain what count() does in terms of the dplyr verbs you just learned. 
## What does the sort argument to count() do?
flights |> 
  count(origin, dest, sort = TRUE)

# 6 -Suppose we have the following tiny data frame:
df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)
glimpse(df)

df |> 
  group_by(y)

df |> 
  arrange(y)

df |> 
  group_by(y) |> 
  summarise(
    mean_x = mean(x)
  )

df |> 
  group_by(y, z) |> 
  summarise(
    mean_x = mean(x)
  )

df |> 
  group_by(y, z) |> 
  summarise(
    mean_x = mean(x) ,
    .groups = 'drop'
  )
# f
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))


#  3.6 Case study: aggregates and sample size -----------------------------

batters <- Lahman::Batting |> 
  group_by(playerID) |> 
  summarize(
    performance = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    n = sum(AB, na.rm = TRUE)
  )
batters

batters |> 
  filter(n > 100) |> 
  ggplot(aes(x = n, y = performance)) +
  geom_point(alpha = 1 / 10) + 
  geom_smooth(se = FALSE)

batters |> 
  arrange(desc(performance))
