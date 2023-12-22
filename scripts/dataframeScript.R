# This code splits the data set in half, in case you want to experiment with it yourself

# Use data.table library when reading csv since every other method is too slow
library(data.table)
data <- fread("masterMLpublic.csv")

# Count rows in data set, then write the second half of the rows to a new csv file
num_rows <- nrow(data)
mid <- num_rows %/% 2
second_half <- data[(midpoint + 1):num_rows, ]
fwrite(second_half, "second_half.csv", row.names = FALSE)

# Clean up data that isn't needed anymore
rm(data)
rm(num_rows)
rm(mid)
rm(second_half)

# Read new file into data frame for use in rest of project
df <- fread("second_half.csv")