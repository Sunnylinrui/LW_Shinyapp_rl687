# Define server function
server <- function(input, output, session) {
  # Render leaflet map
  output$map <- renderLeaflet({
    leaflet() %>%
      setView(lng = 13.533545, lat = 45.850065, zoom = 11.3) %>%
      addProviderTiles(providers$OpenStreetMap, group = "Colour") %>%
      addPolylines(data = river, color = "blue", weight = 2, opacity = 0.8, group = "River") %>%
      addCircles(data = bridges, color = "black", fillColor = "purple", fillOpacity = 0.8, 
                 weight = 2, radius = 50, group = "Bridges") %>%
      
      
      # Add Nearest_distance line
      addPolylines(data = nearest_distance, color = "black", weight = 1.5, opacity = 0.9, group = "Nearest_distance") %>%
      
      
      # Add Large_Wood as point data
      addCircleMarkers(data = lw_points, 
                       lng = ~st_coordinates(lw_points)[,1], 
                       lat = ~st_coordinates(lw_points)[,2], 
                       color = ~pal_lw_points(LW_Type),
                       fillColor = ~pal_lw_points(LW_Type),
                       fillOpacity = 0.8,
                       weight = 1,
                       radius = 6,
                       group = "Large_Wood",
                       popup = ~paste("<b>LW_Type:</b>", LW_Type)) %>%
      
      # Add clustered data as points (instead of polygons)
      addCircleMarkers(data = clusters, 
                       color = ~pal_clusters(CLUSTER_ID),
                       fillColor = ~pal_clusters(CLUSTER_ID),
                       fillOpacity = 0.8,
                       weight = 1,
                       radius = 6,
                       group = "Clusters",
                       popup = ~paste("<b>Cluster ID:</b>", CLUSTER_ID)) %>%
      
      addRasterImage(heatmap, colors = pal_heatmap, opacity = 0.7, group = "Heatmap") %>%
      addLayersControl(
        baseGroups = c("Colour"),
        overlayGroups = c("River", "Bridges", "Nearest_distance", "Large_Wood", "Heatmap", "Clusters"),
        options = layersControlOptions(collapsed = FALSE)
      ) %>%
    
      # Add Large_Wood type legend
      addLegend(position = "bottomleft",
                pal = pal_lw_points,
                values = lw_points$LW_Type,
                title = "Large Wood Types",
                opacity = 0.7,
                group = "Large_Wood") %>%
    
      # Add Clustering Legend
      addLegend(position = "bottomright",
              pal = pal_clusters,
              values = clusters$CLUSTER_ID,
              title = "Clusters",
              opacity = 0.7,
              group = "Clusters")
    
  })
}