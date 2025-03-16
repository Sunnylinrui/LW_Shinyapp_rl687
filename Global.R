# Global.R - Processing data and loading data
library(sf)
library(raster)
library(terra)
library(RColorBrewer)  
library(leaflet)  

# Load data
lw_points <- st_read("lw_points.shp")
river <- st_read("RiverIsonzo.shp")
bridges <- st_read("BridgesIsonzo.shp")
nearest_distance <- st_read("NearestDistance.shp")  

# Projection conversion
lw_points <- st_transform(lw_points, crs = 4326)
river <- st_transform(river, crs = 4326)
bridges <- st_transform(bridges, crs = 4326)
nearest_distance <- st_transform(nearest_distance, crs = 4326)

# Dynamically generated color palettes
num_lw_points <- length(unique(lw_points$LW_Type))
pal_lw_points <- colorFactor(palette = colorRampPalette(brewer.pal(12, "Paired"))(num_clusters), 
                            domain = lw_points$LW_Type)

# Load clustered data
clusters <- st_read("IsonzoClusters.shp")
clusters <- st_transform(clusters, crs = 4326)
# Dynamically generated color palettes
num_clusters <- length(unique(clusters$CLUSTER_ID))
pal_clusters <- colorFactor(palette = colorRampPalette(brewer.pal(12, "Paired"))(num_clusters), 
                            domain = clusters$CLUSTER_ID)

# Reads heat map data and ensures projection matches
heatmap <- rast("Heatmap.tif")  # load SpatRaster
heatmap <- project(heatmap, crs(river))  # reprojection
heatmap <- raster(heatmap)  # **Converted to RasterLayer**

# Defining the color palette
pal_heatmap <- colorNumeric(palette = "inferno", domain = values(heatmap), na.color = "transparent")

