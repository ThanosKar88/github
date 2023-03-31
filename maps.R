#libraries
library(reshape2)
library(broom)
library(zoo)
library(raster)
library(chron)
library(RColorBrewer)
library(lattice)
library(ncdf4)
library(lubridate)
library(hydroGOF)
library(xts)
library(e1071)
library(sp)
library(dplyr)
library(EnvStats)
library(extRemes)
library(RCurl)
library(fExtremes)
library(ismev)
library(PerformanceAnalytics)
library(ggplot2)
library(eesim)
library(bayesdfa)
library(rstan)
library(spatstat)
library(climdex.pcic)
library(PCICt)
library(rgdal)
library(sf)
library(raster)
library(dplyr)
library(spData)
library(tmap)    
library(leaflet) 
library(mapview) 
library(ggplot2)
library(cartogram)
library(tmaptools)
library(mapproj)
library(rworldmap)
library(rworldxtra)
library(maps)
library(colormap)
library(rnaturalearthdata)
library(rnaturalearth)
library(googleway)
library(cowplot)
library(ggrepel)
library(ggspatial)
library(timeSeries)

#=================MAP===================
#First I create the dataframe with lat and long 42-34 and 34-19 with step 0.125
##We can adjust the lat and long and the loop according to which area we examine
lat1<-seq(42, 34, -0.125)
lon1<-seq(19,30,0.125)

lon<-0
lat<-0
for (i in 1:89) {
  lat[(89*i-88):(89*i)]<-lat1[i]
}
for (i in 1:89) {
  lon[(89*i-88):(89*i)]<-lon1[1:89]
}


map_coord<-data.frame(lat,lon)
map_coord<-map_coord[1:5785,]

lat<-map_coord[,1]
lon<-map_coord[,2]

#I combine in one dataframe the lat/long with the corresponfing values ( one value for each pair of lat/long)
r10mm_79<-cbind(x_79,map_coord)

#I print the map
my_year <- theme_bw() + theme(panel.ontop=TRUE, panel.background=element_blank())
my_fill <- scale_fill_distiller('',palette='Spectral',
                                limits =  c(0,70))

fig = ggplot(r10mm_79, aes(y=lat, x=lon, fill=x_79)) + geom_tile() + my_year + my_fill+
  coord_quickmap(xlim=c(19, 30), ylim=c(34, 42))+
  borders('world', xlim=c(19, 30), ylim=c(34, 42), colour='black')+
  xlab('Longitude (?E)')+ ylab('Latitude (?N)')+
  theme(panel.grid=element_blank(),
        panel.border = element_rect(colour = "black", fill=NA,size=.7))+
  theme(plot.title = element_text(hjust = 0.5))+ ggtitle("Mean R10mm in period 1979-1984")
print(fig)

