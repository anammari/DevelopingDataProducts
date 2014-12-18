library(shiny)
load(url("http://www.openintro.org/stat/data/mlb11.RData"))
shinyServer(
  function(input, output) {
    output$text_var <- renderText({ 
      paste("You have selected", input$var)
    })
    datasetInput <- reactive({
      switch(input$var,
             "at_bats" = mlb11$at_bats,
             "hits" = mlb11$hits,
             "strikeouts" = mlb11$strikeouts,
             "bat_avg" = mlb11$bat_avg,
             "homeruns" = mlb11$homeruns,
             "stolen_bases" = mlb11$stolen_bases,
             "wins" = mlb11$wins)
    })
    lmodel <- reactive({lm(runs ~ datasetInput(), data = mlb11)}) 
    out_summary <- reactive({input$summary})
    out_scatter <- reactive({input$scatter})
    out_corr <- reactive({input$corr})
    out_resid <- reactive({input$res})
    out_leastSq <- reactive({input$leastSq})
    output$summaryTable <- renderPrint({
      if (out_summary()) {
        var <- datasetInput()
        summary(var)
      }
    })
    output$scatterPlot <- renderPlot({
      if (out_scatter()) {
        var <- datasetInput()
        varName <- input$var
        plot(var, mlb11$runs, main="Scatter Plot", xlab=paste("Explanatory Variable:",as.character(varName)), 
             ylab="Scored Runs", pch=19)
      }
    })
    output$correlation <- renderText({
      if (out_corr()) {
        var <- datasetInput()
        corr <- cor(mlb11$runs, var)
        paste("Correlation = ", as.character(round(corr,3)))
      }
    })
    output$prediction <- renderText({
      input$goButton
      intercept <- lmodel()$coefficients[1]
      slope <- lmodel()$coefficients[2]
      x = isolate(as.numeric(input$exp))
      pred = intercept + (slope * x)
      if (as.numeric(input$goButton) > 0) {
        paste("Predicted Scored Run = ", as.character(round(pred,3)))
      }
    })
    output$summaryResiduals <- renderPrint({
      if (out_resid()) {
        summary(lmodel()$residuals)
      }
    })
    output$leastSqPlot <- renderPlot({
      if (out_leastSq()) {
        var <- datasetInput()
        varName <- input$var
        plot(var, mlb11$runs, main="Least Squares Line", xlab=paste("Explanatory Variable:",as.character(varName)), 
             ylab="Scored Runs", pch=19)
        abline(lmodel())
      }
    })
  }
)