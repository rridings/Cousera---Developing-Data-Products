library(shiny)
library(fields)
library(gdata)
library(sp)
library(rworldmap)

station <- read.fwf("allstations.txt", width=c(12,9,10))
colnames(station) <- c("station","latitude","longitude")
station$station = trim(station$station)

snow <- read.fwf("mly-snow-normal.txt", width=c(19,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2))
snow <- snow[c(1,2,5,8,11,14,17,20,23,26,29,32,35)]
colnames(snow) <- c("station", "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")
snow[snow == 7777] <- NA
snow$station = trim(snow$station)
snow <- merge(snow, station)
snow <- snow[c(15,14,1,2,3,4,5,6,7,8,9,10,11,12,13)]

tmax <- read.fwf("mly-tmax-normal.txt", width=c(19,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2))
tmax <- tmax[c(1,2,5,8,11,14,17,20,23,26,29,32,35)]
colnames(tmax) <- c("station", "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")
tmax[tmax == 7777] <- NA
tmax$station = trim(tmax$station)
tmax <- merge(tmax, station)
tmax <- tmax[c(15,14,1,2,3,4,5,6,7,8,9,10,11,12,13)]

tmin <- read.fwf("mly-tmin-normal.txt", width=c(19,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2,4,1,2))
tmin <- tmin[c(1,2,5,8,11,14,17,20,23,26,29,32,35)]
colnames(tmin) <- c("station", "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")
tmin[tmin == 7777] <- NA
tmin$station = trim(tmin$station)
tmin <- merge(tmin, station)
tmin <- tmin[c(15,14,1,2,3,4,5,6,7,8,9,10,11,12,13)]

# The single argument to this function, points, is a data.frame in which:
#   - column 1 contains the longitude in degrees
#   - column 2 contains the latitude in degrees
coords2country = function(points)
{  
  countriesSP <- getMap(resolution='low')
  pointsSP = SpatialPoints(points, proj4string=CRS(proj4string(countriesSP)))  
  indices = over(pointsSP, countriesSP)
  indices$ADMIN  
}
weather <- function(df) {
  x <- data.matrix(df[, c("longitude", "latitude")])
  r <- df$radius
  
  c <- coords2country(x)
  
  d <- rdist.earth(snow, x)
  use <- lapply(seq_len(ncol(d)), function(i) {
    which(d[,i] < r[i])
  })
  s <- mean(snow[unlist(use),c(df$month)],na.rm=TRUE)/10
  
  d <- rdist.earth(tmin, x)
  use <- lapply(seq_len(ncol(d)), function(i) {
    which(d[,i] < r[i])
  })
  t1 <- mean(tmin[unlist(use),c(df$month)],na.rm=TRUE)/10
  
  d <- rdist.earth(tmax, x)
  use <- lapply(seq_len(ncol(d)), function(i) {
    which(d[,i] < r[i])
  })
  t2 <- mean(tmax[unlist(use),c(df$month)],na.rm=TRUE)/10
  
  data.frame(tmax=t2, tmin=t1, snow=s, country=c)
}