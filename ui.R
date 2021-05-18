source("helpers.R")

thematic_on(bg = "auto")


ui <- fluidPage(
  tags$head(
    tags$link(href = "https://fonts.googleapis.com/css?family=Roboto+Mono", rel = "stylesheet"),
    tags$style(HTML('
      * {
        font-family: Roboto Mono; font-size: 100%;
       }
        h1,h2,h3,h4 {
          font-family: Roboto Mono;
        }
      a {
      color: #B31098;
        }'
    ))),
  theme = shinytheme("slate"),
  h1("aRty face"),
  h4("Translates pixels into data visualisation"),
  sidebarLayout(
    position = "right",
    sidebarPanel(
      fileInput("upload", h4("Upload an image"),
                accept = c('image/png', 'image/jpeg', 'image/gif', 'image/jpg')),
      sliderInput("longest_dim", "Resolution (rough - more detailed)",
                  min = 40, max = 140, value = 80),
      selectInput(
        "rtype", "Choose a transformation", 
        c("point", "line", "rgb", "split bar", "b-spline", "ascii"),
        multiple = F),
      uiOutput("ui"),
      uiOutput("ui2"),
      uiOutput("uipoint"),
      width = 5),
    mainPanel(
      plotOutput("plot", height = "450px"),
      width = 7)
  ),
  p("Built with ", tags$a(href="https://shiny.rstudio.com", "Shiny"), "&",
    tags$a(href="https://www.rstudio.com", "R"), "by",
    tags$a(href="https://twitter.com/duc_qn", "Duc-Quang Nguyen."),
    "Shamelessly based on ", 
    tags$a(href="https://github.com/gkaramanis/aRtist", "Georgios Karamanis"),
    "R ggplot2 code. Original idea by", 
    tags$a(href="https://twitter.com/elanaEllesce", "Elana Levin Schtulberg:"),
    "check ", tags$a(href="https://blog.datawrapper.de/stacked-bar-chart-art/", 
                     "her datawrapper post"),  
    "and her", tags$a(href="http://www.elanalevinschtulberg.com/chartify/", "web tool.")
  ),
  
  p(icon("github"), tags$a(href="https://github.com/d-qn/aRrtify_heroku", "R code")  
  )
)

