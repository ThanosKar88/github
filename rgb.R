# Load required package
library(jpeg)

# Read in image
img <- readJPEG("photo.jpg")

# Get dimensions of image
dims <- dim(img)

# Create empty arrays for red, green, and blue values
red_values <- array(0, dim = c(dims[1], dims[2]))
green_values <- array(0, dim = c(dims[1], dims[2]))
blue_values <- array(0, dim = c(dims[1], dims[2]))

# Loop through each pixel and store RGB values
for(i in 1:dims[1]) {
  for(j in 1:dims[2]) {
    red_values[i, j] <- img[i, j, 1]
    green_values[i, j] <- img[i, j, 2]
    blue_values[i, j] <- img[i, j, 3]
  }
}

# Plot the RGB values as an image
rgb_image <- array(0, dim = c(dims[1], dims[2], 3))
rgb_image[, , 1] <- red_values
rgb_image[, , 2] <- green_values
rgb_image[, , 3] <- blue_values
jpeg("rgb_image.jpg")
plot(as.raster(rgb_image))
dev.off()
