#clean script
library(mapdeck)
library(sf)
library(tidyverse)

#lecture data----
ARBO <- st_read('scripts/AgresteMap/data/ARBOvf.shp', stringsAsFactors = FALSE) 
CULTv2 <- st_read('scripts/AgresteMap/data/CULTvf.shp', stringsAsFactors = FALSE)
HORT <- st_read('scripts/AgresteMap/data/HORTvf.shp', stringsAsFactors = FALSE)
INTE <- st_read('scripts/AgresteMap/data/INTEvf.shp', stringsAsFactors = FALSE)
POEL <- st_read('scripts/AgresteMap/data/POELvf.shp', stringsAsFactors = FALSE) 
VITI <- st_read('scripts/AgresteMap/data/VITIvf.shp', stringsAsFactors = FALSE)

#Mapbox settings----
#set_token(Sys.getenv('MAPBOX'))
dark <- mapdeck_style('dark')
light <- mapdeck_style('light')
outdoors<- mapdeck_style('outdoors') #lignes topo
streets <- mapdeck_style('streets') #POI
sat <- mapdeck_style('satellite')
satstreets <- mapdeck_style('satellite-streets')

#map----
a <- mapdeck(token = "pk.eyJ1IjoidmNoYXJsZXMiLCJhIjoiY2ppeGt1em82MDBuNjNrcGMxNWE0b2NqbCJ9.UgKOb_aR2Cp6UGv3udAbXQ",
        style = outdoors, pitch = 45,
        location = c(0.58, 46.95),
        zoom = 5) %>%
  add_polygon(data = ARBO,
              layer_id = "ARBO_layer",
              fill_colour = '#e386c7',
              fill_opacity = 165,
              tooltip = 'CULT',
              elevation = 'Z_moyen') %>%
  add_polygon(data = CULTv2, 
              layer_id = "CULT_layer", 
              fill_colour = 'COULEUR',
              fill_opacity = 165,
              tooltip = 'CULT',
              elevation = 'Z_moyen') %>%
  add_polygon(data = HORT, 
              layer_id = "HORT_layer", 
              fill_colour = 'COULEUR',
              fill_opacity = 165,
              tooltip = 'CULT',
              elevation = 'Z_moyen') %>%
  add_polygon(data = INTE, 
              layer_id = "INTE_layer", 
              fill_colour = 'COULEUR',
              fill_opacity = 165,
              tooltip = 'CULT',
              elevation = 'Z_moyen') %>%
  add_polygon(data = POEL, 
              layer_id = "POEL_layer", 
              fill_colour = 'COULEUR',
              fill_opacity = 165,
              tooltip = 'CULT',
              elevation = 'Z_moyen')%>%
  add_polygon(data = VITI,
              layer_id = 'VITI_layer',
              fill_colour = '#943784',
              fill_opacity = 165,
              tooltip = 'CULT',
              elevation = 'Z_moyen')
a