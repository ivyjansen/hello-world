library(rgdal)
library(raster)
library(ggplot2)
# library(xlsx)
# library(dplyr)
# source("Watina_Source.R", encoding = "UTF-8")

### Edit in ArcGIS
# Vervang in de file "Concordantiepolders_DeVos_et al_v1_5.xlsx" OV door OU 
# Verwijder alle kolommen behalve CODEIN en hoofdtextuur, en bewaar als "Bodemtypes_JoinTableGIS.xlsx"
# Laad deze tabel in in ArcGIS en join met Bodemserie
# "Select by attributes" alle records waarvoor Textuurkla = "" of Textuukla == " "
# Maak een nieuwe variabele BodemCode 
# Stel deze met "Field Calculate" voor de selectie gelijk aan hoofdtextuur
# "Switch selection" en "Field Calcultae" gelijk aan Textuurkla
# Laad tabel "BodemGroepen_JoinTableGIS.xlsx" en join met BodemCode
# "Geoprocessing -> Dissolve" op variabele Bodemcode
# "Stop editing" en "Export Data" van deze nieuwe layer

BodemGroepen2 <- readOGR(dsn = "Shapes", layer = "BodemGroepen")
save(BodemGroepen2, file = "BodemGroepenSP_v20170124.Rdata")


## Kaartje Vlaanderen - opsplitsen over provincies
Provincie <- readOGR(dsn = "Shapes", layer = "Provincies_2003_RB")

### Limburg
Limburg <- subset(Provincie, NAAM == "Limburg")
ggplot(Limburg, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
  geom_polygon(aes(group = group), fill = NA, colour = "black")
outLimburg <- crop(BodemGroepen2, Limburg)
tmpLimburg <- fortify(outLimburg)
BodemLimburg <- merge(tmpLimburg, cbind(id = rownames(outLimburg@data), outLimburg@data))
ggplot(BodemLimburg, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
  geom_polygon(aes(group = group, fill = Blad1__Bod), colour = "black")

### Antwerpen
Antwerpen <- subset(Provincie, NAAM == "Antwerpen")
ggplot(Antwerpen, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
  geom_polygon(aes(group = group), fill = NA, colour = "black")
outAntwerpen <- crop(BodemGroepen2, Antwerpen)
tmpAntwerpen <- fortify(outAntwerpen)
BodemAntwerpen <- merge(tmpAntwerpen, cbind(id = rownames(outAntwerpen@data), outAntwerpen@data))
ggplot(BodemAntwerpen, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
  geom_polygon(aes(group = group, fill = Blad1__Bod), colour = "black")

### Oost-Vlaanderen
OostVlaanderen <- subset(Provincie, NAAM == "Oost-Vlaanderen")
ggplot(OostVlaanderen, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
  geom_polygon(aes(group = group), fill = NA, colour = "black")
outOostVlaanderen <- crop(BodemGroepen2, OostVlaanderen)
tmpOostVlaanderen <- fortify(outOostVlaanderen)
BodemOostVlaanderen <- merge(tmpOostVlaanderen, cbind(id = rownames(outOostVlaanderen@data), outOostVlaanderen@data))
ggplot(BodemOostVlaanderen, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
  geom_polygon(aes(group = group, fill = Blad1__Bod), colour = "black")

### West-Vlaanderen
WestVlaanderen <- subset(Provincie, NAAM == "West-Vlaanderen")
ggplot(WestVlaanderen, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
  geom_polygon(aes(group = group), fill = NA, colour = "black")
outWestVlaanderen <- crop(BodemGroepen2, WestVlaanderen)
tmpWestVlaanderen <- fortify(outWestVlaanderen)
BodemWestVlaanderen <- merge(tmpWestVlaanderen, cbind(id = rownames(outWestVlaanderen@data), outWestVlaanderen@data))
ggplot(BodemWestVlaanderen, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
  geom_polygon(aes(group = group, fill = Blad1__Bod), colour = "black")

### Vlaams-Brabant
VlaamsBrabant <- subset(Provincie, NAAM == "Vlaams Brabant")
ggplot(VlaamsBrabant, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
  geom_polygon(aes(group = group), fill = NA, colour = "black")
outVlaamsBrabant <- crop(BodemGroepen2, VlaamsBrabant)
tmpVlaamsBrabant <- fortify(outVlaamsBrabant)
BodemVlaamsBrabant <- merge(tmpVlaamsBrabant, cbind(id = rownames(outVlaamsBrabant@data), outVlaamsBrabant@data))
ggplot(BodemVlaamsBrabant, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
  geom_polygon(aes(group = group, fill = Blad1__Bod), colour = "black")

### Kaartlagen provincies bewaren
save(BodemLimburg, file = "BodemLimburg_v20170126.Rdata")
save(BodemAntwerpen, file = "BodemAntwerpen_v20170126.Rdata")
save(BodemOostVlaanderen, file = "BodemOostVlaanderen_v20170126.Rdata")
save(BodemWestVlaanderen, file = "BodemWestVlaanderen_v20170126.Rdata")
save(BodemVlaamsBrabant, file = "BodemVlaamsBrabant_v20170126.Rdata")

### Combineren in 1 figuur
p <- ggplot(Provincie, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
  geom_polygon(aes(group = group), fill = NA, colour = "black") +
  geom_polygon(data = BodemLimburg, aes(group = group, fill = Blad1__Bod), colour = "black") +
  geom_polygon(data = BodemAntwerpen, aes(group = group, fill = Blad1__Bod), colour = "black") +
  geom_polygon(data = BodemOostVlaanderen, aes(group = group, fill = Blad1__Bod), colour = "black") +
  geom_polygon(data = BodemWestVlaanderen, aes(group = group, fill = Blad1__Bod), colour = "black") +
  geom_polygon(data = BodemVlaamsBrabant, aes(group = group, fill = Blad1__Bod), colour = "black")

ggsave(p, file = "BodemVlaanderenVolledigVertaald_v20170126.png")









## Laad bodemkaart en vertaal naar 3 bodemtypes
## NIET UITVOERBAAR !!!
# load("Shapes/bodemkaart.rdata")
#load("BodemOverlayMeetpunten_v20160421.Rdata")

# coordinates(Limburg) <- c("long", "lat")
# proj4string(Limburg) <- CRS(proj4string(bodemkaart))

# out <- crop(bodemkaart, Limburg)
# Bodem <- VertalingBodemtextuur(out)
# Bodem$Bodem <- factor(Bodem$Bodem_code)
# levels(Bodem$Bodem) <- list("Zwaar" = c("A", "E", "U", "G"), "Licht" = c("Z", "S", "S-Z", "P", "L", "A-L", "X"), "Veen" = "V")
# out$Bodem <- Bodem$Bodem
# 
# ggplot(out, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
#   geom_polygon(aes(fill = Bodem), colour = "black")

# BodemLimburg <- over(bodemkaart, Limburg)
#    # lukt niet om attributen bodemkaart mee te geven, en niet die van Limburg
# BodemLimburg <- cbind(BodemLimburg, bodemkaart@data)
# BodemLimburg2 <- BodemLimburg[!is.na(BodemLimburg$NAAM),]
# str(BodemLimburg)
# 
# Bodem <- VertalingBodemtextuur(BodemLimburg)
# Bodem$Bodem <- factor(Bodem$Bodem_code)
# levels(Bodem$Bodem) <- list("Zwaar" = c("A", "E", "U", "G"), "Licht" = c("Z", "S", "S-Z", "P", "L", "A-L", "X"), "Veen" = "V")
# BodemLimburg$Bodem <- Bodem$Bodem
# 
# ggplot(BodemLimburg, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
#   geom_polygon(aes(fill = Bodem), colour = "black")

## Laad habitatkaart en vertaal naar 3 habitatgroepen
# load("Shapes/habkaart.rdata")
#load("HabitatOverlayMeetpunten_v20160421.Rdata")
 
# Habitat <- HabitatVL
# Habitat$HAB1 <- VertalingHabitattypes(as.character(Habitat$HAB1))
# Habitat$HAB2 <- VertalingHabitattypes(as.character(Habitat$HAB2))
# Habitat$HAB3 <- VertalingHabitattypes(as.character(Habitat$HAB3))
# Habitat$HAB4 <- VertalingHabitattypes(as.character(Habitat$HAB4))
# Habitat$HAB5 <- VertalingHabitattypes(as.character(Habitat$HAB5))

# HabitatVL$HAB <- Habitat$HAB1
# 
# ggplot(HabitatVL, aes(x = long, y = lat)) + coord_equal() + xlab("") + ylab("") +
#   geom_polygon(aes(group = group, fill = HAB), colour = "black")
# 
# ggplot(Habitat1, aes(x = MeetpuntXCoordinaat, y = MeetpuntYCoordinaat)) +   
#   geom_point() + coord_equal() + xlab("") + ylab("") +
#   geom_polygon(data = Provincie, aes(x = long, y = lat, group = group), fill = NA, colour = "black")
# 
# load("FinaleMeetpunten_v20160428.Rdata")
# 
# ggplot(test, aes(x = MeetpuntXCoordinaat, y = MeetpuntYCoordinaat, colour = log(aantalGHG_maai))) +   
#   geom_point() + coord_equal() + xlab("") + ylab("") +
#   ggtitle("Aantal waarden voor GHG_maai") + 
#   geom_polygon(data = Provincie, aes(x = long, y = lat, group = group), fill = NA, colour = "black")
# str(Habitat1)
