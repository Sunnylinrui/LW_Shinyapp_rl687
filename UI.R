# Define UI
ui <- navbarPage("Instream large wood on the River Isonzo", id = 'nav',
                 tabPanel("Map",  
                          div(class="outer",  
                              leafletOutput("map", height = "calc(100vh - 70px)")  
                          )  
                 )
)