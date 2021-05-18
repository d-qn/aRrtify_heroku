source("helpers.R")

server <- function(input, output, session) {
  
  img <- reactive({
    inFile <- input$upload
    if (is.null(inFile)) {
      loadImageResize("audrey.jpg", input$longest_dim)
    } else {
      loadImageResize(inFile$datapath, input$longest_dim)
    }
  })
  
  artype <- reactive(input$rtype)
  
  shape <- reactive({
    if(!is.null(input$shape) ) {
      switch(input$shape,
             "point" = 16, 
             "triangle" = 17, 
             "diamond" = 18, 
             "square" = 15, 
             "smaller point" = 20,
             "$" = 36,
             stop("Invalid input shape")
      )
    }
  })
  
  output$ui <- renderUI({
    if (is.null(img()))
      return()
    else {
      # Depending on input$artype, we'll generate a different
      # UI component and send it to the client.
      switch(artype(),
             "point" = ,
             "line" = ,
             "split bar" =,
             "b-spline" = colourInput(
               "bgcol", "Select a background colour", value = input$bgcol %||% "#EDEDC2")
      )
    }
  })
  output$ui2 <- renderUI({
    if (is.null(img()))
      return()
    else {
      # Depending on input$artype, we'll generate a different
      # UI component and send it to the client.
      switch(artype(),
             "point" = ,
             "line" = ,
             "split bar" =,
             "b-spline" = colourInput(
               "fgcol", "Select a foreground colour", 
               value = input$fgcol %||% "#6B0F5C"
             )
      )
    }
  })
  
  output$uipoint <- renderUI({
    # Depending on input$artype, we'll generate a different
    # UI component and send it to the client.
    switch(artype(),
           "point" = selectInput(
             "shape", "Select a shape", 
             c("point", "triangle", "diamond", "square", "smaller point", 
               "$"),
             multiple = F,
             selected = input$shape %||% "point"
           )
    )
  })
  
  output$plot <- renderPlot({
    if(!is.null(img())) {
      ff <- switch(artype(),
                   "point" = portraitPoint,
                   "line"  = portraitLine,
                   "rgb"   = portraitRgb,
                   "split bar" = portraitSplitbar,
                   "b-spline"  = portraitBspline,
                   "ascii"     = portaitAscii,
                   stop("Invalid transformation input value")
      )
      
      if(is.function(ff)) {
        switch(artype(),
               "line"  = ,
               "split bar" = ff(img()[[1]], col_fill = ifelse(is.null(input$fgcol), "black", input$fgcol) , col_bg = input$bgcol),
               "b-spline" = ff(img()[[1]], image_ratio = img()[[2]], col_fill = ifelse(is.null(input$fgcol), "black", input$fgcol), col_bg = input$bgcol),
               "rgb" = ff(img()[[1]], image_ratio = img()[[2]]),
               "ascii" = ff(img()[[1]]),
               "point" = ff(img()[[1]], shape = shape() %||% 16, col_fill = ifelse(is.null(input$fgcol), "black", input$fgcol) , col_bg = input$bgcol),
               stop("invalid ff")
        )
      }   
    } 
  })
}
