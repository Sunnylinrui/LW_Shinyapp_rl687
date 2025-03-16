Copy# Load packages ----
library(shiny)
library(leaflet)
library(sf)
library(raster)
library(ggplot2)
library(ggiraph)
library(RColorBrewer)
library(terra)
library(leafem)
options(shiny.maxRequestSize = 1000 * 1024^2)

# Run global script containing all data ----
source("Global.R")

# Import UI and server functions
source("UI.R")  # This creates a UI function
source("Server.R")  # This creates a server function

# Run the application ----
shinyApp(ui = ui, server = server)