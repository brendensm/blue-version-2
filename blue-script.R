library(httpuv)
library(rtweet)
library(dplyr)
library(ggplot2)

# import data 
blues <- read.csv("blues_dataset.csv")[,-1]



# Twitter token business
everywordisblue_token <-
  rtweet::rtweet_bot(
   api_key =   Sys.getenv("TWITTER_CONSUMER_API_KEY"),
    api_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
    access_token =    Sys.getenv("TWITTER_ACCESS_TOKEN"),
    access_secret =  Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
  )
  

random_blue <- sample_n(blues, 1)

temp <- as.character(random_blue[1])

blue_hex <- as.character(random_blue[2])

blue_square <- ggplot() + theme_void() +
              theme(plot.background = element_rect(fill = blue_hex),
              panel.background = element_rect(fill = blue_hex))

ggsave(paste0("blue_squares/", temp, ".png"), blue_square,
       width = 150, height = 150, units = "px")

alt_text <- "A random shade of blue, sourced from color-name.com."

image_path <- paste0("blue_squares/", temp, ".png")

# Sending our tweet!
rtweet::post_tweet(status = temp, 
                   media = image_path, 
                   media_alt_text = alt_text,
                   token = everywordisblue_token)



