library(tidyverse)
library(palmerpenguins) # penguins dataset
library(ggthemes) # colorblind color pallet
palmerpenguins::penguins
penguins
dplyr::glimpse(penguins)
glimpse(penguins)
?penguins
# Creating a ggplot
ggplot(data = penguins, # first argument ---> an empty plot
       mapping = aes(x = bill_length_mm,
                     y = body_mass_g)) + # defines how variables in your dataset are mapped to visual properties (aesthetics) 
        geom_point(mapping = aes(color = species, shape = species)) +  #Scatterplot
        geom_smooth(method = "lm") + 
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)" , y = "Body mass (g)",
    color = "Species", shape = "Species") + 
  scale_color_colorblind()
# Exercises
## 1- How many rows are in penguins? How many columns?
dim(penguins)
nrow(penguins)
ncol(penguins)

## 2 - What does the bill_depth_mm variable in the penguins data frame describe? 
###Read the help for ?penguins to find out.
?penguins
#### a number denoting bill depth (millimeters)

## 3- Make a scatterplot of bill_depth_mm vs. bill_length_mm. 
###That is, make a scatterplot with bill_depth_mm on the y-axis and bill_length_mm on the x-axis.
###Describe the relationship between these two variables.
ggplot(data = penguins, 
       mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point()
#### It seems that there is no linear relateion between x and y

## 4- What happens if you make a scatterplot of species vs. bill_depth_mm? What might be a better choice of geom?
ggplot(data = penguins, 
       mapping = aes(y = bill_depth_mm, x = species)) +
  geom_boxplot() # categorical vs. numerical

## 5 - Why does the following give an error and how would you fix it?
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = body_mass_g)) + 
  geom_point()

## 6- What does the na.rm argument do in geom_point()? 
###What is the default value of the argument? 
###Create a scatterplot where you successfully use this argument set to TRUE.
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = body_mass_g)) + 
  geom_point(na.rm = TRUE)

## 7- Add the following caption to the plot you made in the previous exercise:
###“Data come from the palmerpenguins package.” Hint: Take a look at the documentation for labs().
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = body_mass_g)) + 
  geom_point(na.rm = TRUE) +
  labs(
    caption = "Data come from the palmerpenguins package."
  )

## 8 - Recreate the following visualization. 
###What aesthetic should bill_depth_mm be mapped to?
###And should it be mapped at the global level or at the geom level?
ggplot(data = penguins, 
       mapping = aes(x = flipper_length_mm, y = body_mass_g )) +
  geom_point(mapping = aes(color = bill_depth_mm)) + 
  geom_smooth()

## 9 *Run this code in your head and predict what the output will look like. Then,
### run the code in R and check your predictions?
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)

# 10 - Will these two graphs look different? Why/why not?
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )

# Rewrite codes
penguins |> 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

# distribution of a categorical variable
ggplot(penguins, aes(x = fct_infreq(species))) +
  geom_bar()

# distribution of a numerical variable
ggplot(penguins, aes(x = body_mass_g))+
  #geom_histogram(binwidth = 200) +
  geom_density()
# 1.4.3 Exercises
## 1- Make a bar plot of species of penguins, where you assign species to the y aesthetic. How is this plot different?
ggplot(penguins, 
       aes(y = fct_infreq(species) )) +
  geom_bar()
## 2- How are the following two plots different? Which aesthetic, color or fill, is more useful for changing the color of bars?

ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")
## 3- What does the bins argument in geom_histogram() do?
?geom_histogram
### Number of bins. Overridden by binwidth. Defaults to 30.

## 4 - Make a histogram of the carat variable in the diamonds dataset 
###that is available when you load the tidyverse package.
### Experiment with different binwidths. What binwidth reveals the most interesting patterns?
ggplot(data = diamonds, mapping = aes(x = carat))+
    geom_histogram(binwidth = 0.2)

# categorical vs. numerical
ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()
## alternate a geom_density
ggplot(data = penguins,
       mapping = aes(x = body_mass_g, color = species, fill = species))+
  geom_density(alpha = 0.5)

## Two categorical variable relation
ggplot(data = penguins,
       mapping = aes(x = island, fill = species)) + 
  geom_bar()

penguins |> ggplot(mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = species, shape = island)) +
  facet_wrap(~ island)

#Exercises
## 1- The mpg data frame that is bundled with the ggplot2 package contains 234 observations 
###collected by the US Environmental Protection Agency on 38 car models. 
###Which variables in mpg are categorical? Which variables are numerical? 
###How can you see this information when you run mpg?
glimpse(mpg)
?mpg

## 2- Make a scatterplot of hwy vs. displ using the mpg data frame.
###Next, map a third, numerical variable to color, then size, then both color and size, then shape.
###How do these aesthetics behave differently for categorical vs. numerical variables?
ggplot(data = mpg, 
       mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(shape = trans))

## 3- n the scatterplot of hwy vs. displ, what happens if you map a third variable to linewidth?
ggplot(data = mpg, 
       mapping = aes(x = displ, y = hwy, linewidth = cty)) +
  geom_point()

## 4- What happens if you map the same variable to multiple aesthetics?
ggplot(data = mpg, 
       mapping = aes(x = displ, y = hwy, color = hwy)) +
  geom_point()

## 5- Make a scatterplot of bill_depth_mm vs. bill_length_mm and color the points by species. 
### What does adding coloring by species reveal about the relationship between these two variables? 
### What about faceting by species?
ggplot(data = penguins, 
       mapping = aes(x = bill_length_mm, y = bill_depth_mm , color = species)) + 
  geom_point()+
  scale_color_colorblind()

ggplot(data = penguins, 
       mapping = aes(x = bill_length_mm, y = bill_depth_mm , color = species)) + 
  geom_point()+
  facet_wrap(~species)+
  scale_color_colorblind()

## 6- Why does the following yield two separate legends? How would you fix it to combine the two legends?
ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm, 
    color = species, shape = species
  )
) +
  geom_point() +
  labs()
## 7- Create the two following stacked bar plots. 
### Which question can you answer with the first one?
### Which question can you answer with the second one?
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")
ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")

ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-plot.png")
