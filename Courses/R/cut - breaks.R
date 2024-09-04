weight_st <- rnorm(100, mean = 75, sd = 5)
summary(weight_st)
w_breaks <- seq(60, 100, 10)
x <- cut(weight_st, w_breaks)
x
table(x)
str(x)
x_df <- as.data.frame(table(x))
x_df
x_df$percentage <-  round(x_df$Freq / sum(x_df$Freq) * 100)
x_df$cumul <- cumsum(x_df$Freq)
?cut
