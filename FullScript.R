#Carte 3D cultures Agreste
library(mapdeck)
library(sf)
library(tidyverse)

#lecture data----
ARBOv2 <- st_read('scripts/AgresteMap/data/COMMUNE_ARBOv2.shp')
CULTv2 <- st_read('scripts/AgresteMap/data/COMMUNE_CULTv2.shp')
HORTv2 <- st_read('scripts/AgresteMap/data/COMMUNE_HORTv2.shp')
INTEv2 <- st_read('scripts/AgresteMap/data/COMMUNE_INTEv2.shp')
POELv2 <- st_read('scripts/AgresteMap/data/COMMUNE_POELv2.shp')
VITIv2 <- st_read('scripts/AgresteMap/data/COMMUNE_VITIv2.shp')

#retirer accents----
Unaccent <- function(text) {
  text <- gsub("['`^~\"]", " ", text)
  text <- iconv(text, to = "ASCII//TRANSLIT//IGNORE")
  text <- gsub("['`^~\"]", "", text)
  return(text)
}
Unaccent(ARBOv2$DataArboFr)
Unaccent(CULTv2$CULTOccupS)
Unaccent(HORTv2$HORTOccupS)
Unaccent(INTEv2$INTEOccupS)
Unaccent(POELv2$POELOccupS)
Unaccent(VITIv2$VITIOccupS)

#reprojection----
st_crs(ARBOv2) = 2154
ARBO <- st_transform(ARBOv2, 4326)
st_crs(CULTv2) = 2154
CULT <- st_transform(CULTv2, 4326)
st_crs(HORTv2) = 2154
HORT <- st_transform(HORTv2, 4326)
st_crs(INTEv2) = 2154
INTE <- st_transform(INTEv2, 4326)
st_crs(POELv2) = 2154
POEL <- st_transform(POELv2, 4326)
st_crs(VITIv2) = 2154
VITI <- st_transform(VITIv2, 4326)

#nettoyage data----
ARBOt <- ARBO %>% drop_na(DataArboFr)
CULTt <- CULT %>% drop_na(CULTOccupS)
HORTt <- HORT %>% drop_na(HORTOccupS)
INTEt <- INTE %>% drop_na(INTEOccupS)
POELt <- POEL %>% drop_na(POELOccupS)
VITIt <- VITI %>% drop_na(VITIOccupS)

ARBOv <- filter(ARBOt, !CR %in% '820')#suppression de la Corse
CULTv <- filter(CULTt, !CR %in% '820')
HORTv <- filter(HORTt, !CR %in% '820')
INTEv <- filter(INTEt, !CR %in% '820')
POELv <- filter(POELt, !CR %in% '820')
VITIv <- filter(VITIt, !CR %in% '820')

#traitement donnees v2(page externe)----

#st_write(CULTv, 'CULTvt.xlsx')
CULTvtest2 <- st_read('CULTvt.xlsx')
testCULT <- left_join(CULTv, CULTvtest2, by = 'Insee_com')
st_write(testCULT, 'scripts/AgresteMap/data/CULT.shp')

#st_write(HORTv, 'HORTv.xlsx')
HORTvtest <- st_read('HORTv.xlsx')
testHORT <- left_join(HORTv, HORTvtest, by = 'Insee_com')
st_write(testHORT, 'scripts/AgresteMap/data/HORT.shp')

#st_write(INTEv, 'INTEv.xlsx')
INTEvtest <- st_read('INTEv.xlsx')
testINTE <- left_join(INTEv, INTEvtest, by = 'Insee_com')
st_write(testINTE, 'scripts/AgresteMap/data/INTE.shp')


#st_write(POELv, 'POELv.xlsx')
POELvtest <- st_read('POELv.xlsx')
testPOEL <- left_join(POELv, POELvtest, by = 'Insee_com')
st_write(testPOEL, 'scripts/AgresteMap/data/POEL.shp')

st_write(ARBOv, 'scripts/AgresteMap/data/ARBO.shp')
st_write(VITIv, 'scripts/AgresteMap/data/VITI.shp')

#lecture data----
oldARBO <-
  st_read('scripts/AgresteMap/data/ARBO.shp', stringsAsFactors = FALSE)
oldCULTv2 <-
  st_read('scripts/AgresteMap/data/CULT.shp', stringsAsFactors = FALSE)
oldHORT <-
  st_read('scripts/AgresteMap/data/HORT.shp', stringsAsFactors = FALSE)
oldINTE <-
  st_read('scripts/AgresteMap/data/INTE.shp', stringsAsFactors = FALSE)
oldPOEL <-
  st_read('scripts/AgresteMap/data/POEL.shp', stringsAsFactors = FALSE)
oldVITI <-
  st_read('scripts/AgresteMap/data/VITI.shp', stringsAsFactors = FALSE)

st_write(iARBO, 'scripts/AgresteMap/data/ARBOvf.shp')
st_write(iCULT, 'scripts/AgresteMap/data/CULTvf.shp')
st_write(iHORT, 'scripts/AgresteMap/data/HORTvf.shp')
st_write(iINTE, 'scripts/AgresteMap/data/INTEvf.shp')
st_write(iPOEL, 'scripts/AgresteMap/data/POELvf.shp')
st_write(iVITI, 'scripts/AgresteMap/data/VITIvf.shp')

#epurement data
iARBO <-
  dplyr::select(
    oldARBO,
    Insee_com,
    Nom_com,
    Superficie,
    Population,
    DPT = Code_dept,
    CR,
    CULT = DataArboFr,
    geometry
  )
iCULT <-
  dplyr::select(
    oldCULTv2,
    Insee_com = Inse_cm,
    Nom_com = Nm_cm_x,
    Superficie = Sprfc_x,
    Population = Ppltn_x,
    DPT = Cd_dpt_x,
    CR = CR_x,
    CULT,
    COULEUR,
    geometry
  )
iHORT <-
  dplyr::select(
    oldHORT,
    Insee_com = Ins_c,
    Nom_com = Nm_cm_x,
    Superficie = Sprfc_x,
    Population = Ppltn_x,
    DPT = Cd_dpt_x,
    CR = CR_x,
    CULT = HORTOccp_1,
    COULEUR = COULE,
    geometry
  )
iINTE <-
  dplyr::select(
    oldINTE,
    Insee_com = Inse_cm,
    Nom_com = Nm_cm_x,
    Superficie = Sprfc_x,
    Population = Ppltn_x,
    DPT = Cd_dpt_x,
    CR = CR_x,
    CULT,
    COULEUR,
    geometry
  )
iPOEL <-
  dplyr::select(
    oldPOEL,
    Insee_com = Inse_cm,
    Nom_com = Nm_cm_x,
    Superficie = Sprfc_x,
    Population = Ppltn_x,
    DPT = Cd_dpt_x,
    CR = CR_x,
    CULT,
    COULEUR,
    geometry
  )
iVITI <-
  dplyr::select(
    oldVITI,
    Insee_com,
    Nom_com,
    Superficie,
    Population,
    DPT = Code_dept,
    CR,
    CULT = VITIOccupS,
    geometry
  )

#Mapbox settings----
set_token(Sys.getenv('MAPBOX'))
dark <- mapdeck_style('dark')
light <- mapdeck_style('light')
outdoors <- mapdeck_style('outdoors') #lignes topo
streets <- mapdeck_style('streets') #POI
sat <- mapdeck_style('satellite')
satstreets <- mapdeck_style('satellite-streets')


#map Agreste----
mapdeck(
  style = outdoors,
  pitch = 45,
  location = c(0.58, 46.95),
  zoom = 5
) %>%
  add_polygon(
    data = ARBOv,
    layer_id = "ARBO",
    fill_colour = '#e386c7',
    fill_opacity = 165,
    tooltip = 'DataArboFr'
  ) %>%
  add_polygon(
    data = testCULT,
    layer_id = "CULT_layer",
    fill_colour = 'COULEURS',
    fill_opacity = 165,
    tooltip = 'CULT'
  ) %>%
  add_polygon(
    data = testHORT,
    layer_id = "HORT_layer",
    fill_colour = 'COULEURS',
    fill_opacity = 165,
    tooltip = 'HORTOccupS.y'
  ) %>%
  add_polygon(
    data = testINTE,
    layer_id = "INTE_layer",
    fill_colour = 'COULEURS',
    fill_opacity = 165,
    tooltip = 'CULT'
  ) %>%
  add_polygon(
    data = testPOEL,
    layer_id = "POEL_layer",
    fill_colour = 'COULEURS',
    fill_opacity = 165,
    tooltip = 'CULT'
  ) %>%
  add_polygon(
    data = VITIv,
    layer_id = 'VITI_layer',
    fill_colour = '#943784',
    fill_opacity = 165,
    tooltip = 'CULT'
  )


#map Agreste 3d elv----
mapdeck(
  style = light,
  pitch = 45,
  location = c(0.58, 46.95),
  zoom = 5
) %>%
  add_polygon(
    data = ARBOv,
    layer_id = "ARBO",
    fill_colour = '#e386c7',
    fill_opacity = 165,
    tooltip = 'DataArboFr',
    elevation = 'Z_moyen'
  ) %>%
  add_polygon(
    data = testCULT,
    layer_id = "CULT_layer",
    fill_colour = 'COULEURS',
    fill_opacity = 165,
    tooltip = 'CULT',
    elevation = 'Z_moyen.x'
  ) %>%
  add_polygon(
    data = testHORT,
    layer_id = "HORT_layer",
    fill_colour = 'COULEURS',
    fill_opacity = 165,
    tooltip = 'HORTOccupS.y',
    elevation = 'Z_moyen.x'
  ) %>%
  add_polygon(
    data = testINTE,
    layer_id = "INTE_layer",
    fill_colour = 'COULEURS',
    fill_opacity = 165,
    tooltip = 'CULT',
    elevation = 'Z_moyen.x'
  ) %>%
  add_polygon(
    data = testPOEL,
    layer_id = "POEL_layer",
    fill_colour = 'COULEURS',
    fill_opacity = 165,
    tooltip = 'CULT'
  ) %>%
  add_polygon(
    data = VITIv,
    layer_id = 'VITI_layer',
    fill_colour = '#943784',
    fill_opacity = 165,
    tooltip = 'CULT'
  )
