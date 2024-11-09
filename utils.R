# Create list of links from CourseWorks submissions
library(rvest)
library(purrr)
path_to_submissions <- "~/Downloads/submissions/"
files <- list.files(path_to_submissions)
a <- map(paste0(path_to_submissions, files), read_html)
links <- map_chr(a, ~.x |> html_element("a") |> html_attr("href"))

# Get titles
get_youtube_title <- function(url) {
  # Read the YouTube page HTML
  page <- read_html(url)
  # Extract the title from the HTML using CSS selectors
  page |>  html_element("meta[name='title']") |>  html_attr("content")
}

titles <- unname(sapply(links, get_youtube_title))

markdown_links <- paste0("[", titles, "](", links, ")\n")

writeLines(markdown_links, "~/Downloads/MonWed2024links.txt")
