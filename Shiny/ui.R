library(shiny)
shinyUI(fluidPage(
  fluidRow(
    column(12,
           style = "background-color:Cornsilk;",
           h3('Predicting Scored Runs for Baseball Teams', align = "center"),
           p("In this App, you will be looking at data from all 30 Major League Baseball teams 
              in the US for the 2011 season and 
             examining the",tags$strong("linear relationship"), "between", 
             span("runs scored in a season", style = "color:blue"), 
             "and a number of", span("other team statistics.", style = "color:brown"), 
             "The aim will be to summarize these relationships both graphically and numerically in order 
              to find which variable, if any, helps us best predict a team’s runs scored in a season. ", 
             style = "font-family: 'times'; font-size: 14pt")
    ))
  ,tags$hr(),
  fluidRow(
    column(6,
           style = "background-color:Wheat;",
           h4('Data Variables', align = "center"),
           p('The response variable that you will try to predict is the ', 
             span("runs scored", style = "color:blue"),
             ', which is the number of times a player crosses home plate', 
             style = "font-family: 'times'; font-size: 12pt"),
           p('In addition to runs scored, there are seven traditionally used 
                      variables in the data set:', style = "font-family: 'times'; font-size: 12pt"),
           tags$ul(
             tags$li(tags$strong("at_bats:"), "Plate appearances, not including bases on balls, 
                              being hit by pitch, sacrifices, interference, or obstruction"), 
             tags$li(tags$strong("hits:"), "times reached base because of a batted, 
                              fair ball without error by the defense"), 
             tags$li(tags$strong("homeruns:"),"hits on which the batter successfully touched all four bases"),
             tags$li(tags$strong("strikeouts:"),"number of times that a third strike is taken or swung at and missed, 
                              or bunted foul"),
             tags$li(tags$strong("bat_avg:"),"batting average"),
             tags$li(tags$strong("stolen_bases:"),"number of bases advanced by the runner while the ball is 
                              in the possession of the defense"),
             tags$li(tags$strong("wins:"),"number of games where pitcher was pitching while his team took the lead and went on to win")
           ),
           p('You may want to read a refresher in the ', 
             tags$a(href="http://en.wikipedia.org/wiki/Baseball_rules", "rules of baseball"), ' and a ', 
             tags$a(href="http://en.wikipedia.org/wiki/Baseball_statistics#Batting_statistics", "description of these statistics"), 
             style = "font-family: 'times'; font-size: 12pt")
    ),
    column(6,
           style = "background-color:Pink;",
           h4('How to use the App', align = "center"),
           h5('Exploratory Analysis Part'),
           tags$ol(
             tags$li("Select one of the seven explanatory variables to study 
                              its correlation with the scored runs from the Select Box"),  
             tags$li("Tick the",tags$strong("Show Summary Statistics"), "checkbox to display Summary Statistics for the 
                              variable selected"),
             tags$li("Tick the",tags$strong("Show Scatter Plot"), "checkbox to display a Scatter Plot of the 
                              variable selected and the scored runs"),
             tags$li("Tick the",tags$strong("Compute Correlation"), "checkbox to display the computed correlation 
                              between the variable selected and the scored runs")
           ),
           h5('Predicting Scored Runs Part'),
           tags$ol(
             tags$li("Enter a value for the explanatory variable in the Numeric Input Field to use for  
                              predicting a Scored Run value based on",tags$strong("Linear Regression")),  
             tags$li("Tick the",tags$strong("Show Least Squares Line"), "checkbox to display a Scatter Plot with  
                              the Least Squares Line based on",tags$strong("Linear Regression")),
             tags$li("Tick the",tags$strong("Show Residuals Summary"), "checkbox to display a Summary of the Residuals for the 
                              variable selected based on",tags$strong("Linear Regression"))
           )
    )
  ),tags$hr(),
  fluidRow(
    column(4, titlePanel("Exploratory Analysis"),
           style = "background-color:Beige;",
           selectInput("var", 
                       label = "Choose an exploratory variable to explore",
                       choices = list("at_bats", "hits", "strikeouts", "bat_avg", 
                                      "homeruns", "stolen_bases", "wins"),
                       selected = "at_bats"),
           checkboxInput("summary", label = "Show Summary Statistics", value = FALSE),
           checkboxInput("scatter", label = "Show Scatter Plot", value = FALSE),
           checkboxInput("corr", label = "Compute Correlation", value = FALSE)
    ),
    column(8,
           style = "background-color:Azure;",
           h3(textOutput("text_var")),
           verbatimTextOutput("summaryTable"),
           h4(textOutput("correlation")),
           plotOutput("scatterPlot")
    )
  ),tags$hr(),
  fluidRow(
    column(4, titlePanel("Predicting Scored Runs"),
           style = "background-color:MistyRose;",
           numericInput('exp', 'Explanatory Variable Value', 1, step = 1),
           actionButton("goButton", "Predict Scored Run!"),
           br(),
           br(),
           checkboxInput("leastSq", label = "Show Least Squares Line", value = FALSE),
           checkboxInput("res", label = "Show Residuals Summary", value = FALSE)
    ),
    column(8,
           style = "background-color:Azure;",
           h4(textOutput("prediction")),
           verbatimTextOutput("summaryResiduals"),
           plotOutput("leastSqPlot")
    )
  )
)
)