library(rvest)
library(dplyr)

colors <- data.frame()

for (page_result in 1:89){
  
  link = paste0("https://www.color-name.com/search/blue/page/", page_result)
  
  page = read_html(link)
  
  name = page %>% html_nodes("h2 a") %>% html_text()
  hex = page %>% html_nodes(".hx") %>% html_text()
  
  colors <- rbind(colors, data.frame(name, hex, stringsAsFactors = FALSE))
  
  print(paste("Page:", page_result))
}

blues <- colors %>% filter(grepl('Blue', name))

write.csv(colors, "blues_dataset.csv")






