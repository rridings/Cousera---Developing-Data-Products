---
title       : Weather Monthly
subtitle    : 30 year monthly averages accross the US
author      : Rob Ridings
job         : Cousera - Developing Data Products
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---


## What to pack

Every had trouble packing for trip with an extended stay?  
<br>
<div style='text-align: center;'>
    <img src='assets/img/luggage.jpg' />
</div>
<br>
Current weather sites are great for giving current forcecasts.  But what if you needed to know how to pack, for an entire month or six months.  
<br>
That is where <b>Weather Monthly</b> fits in.

--- .class #id 

## Weather Monthly

Using 1981-2010 U.S. Climate Normals from the National Oceanic and Atmospheric Administration, <b>Weather Monthly</b> can tell you the average minumum and maximun temperature for a specfic location in a given month.  Additionally, <b>Weather Monthly</b> will provide the average snowfall, in case you want to pack your skis. 
<br>
<br>
<img src='assets/img/logo_noaa.png' /> 
<br>
[1981-2010 U.S. Climate Normals](https://www.ncdc.noaa.gov/data-access/land-based-station-data/land-based-datasets/climate-normals/1981-2010-normals-data)

--- .class #id 

## How to use

1. Identify a location by its longitude and latitude coordinates.
2. Select a radius in miles to identify a circle around that point.
3. Select the month you are interest in.
<br>
<br>
For example<br>
<br>
<b>John Hopkins Univeristy</b> is located at 39.3289 N, 76.6203 W.
Let's draw a 50 mile circle around that point and see what we can expect in January.

--- .class #id 

## Results

<b>John Hopkins University</b> in January<br>


```r
longitude <- -76.6203
latitude <- 39.3289
month <- 'jan'
radius <- 50
df <- data.frame(longitude, latitude, month, radius, stringsAsFactors=FALSE)

w <- weather(df)
```
<br>
Maximum Temperature: 41 F<br>
Minimum Temperature: 24 F<br>
Snowfall: 7.07 inches<br>


[Try it now](https://rridings.shinyapps.io/weathermonthly)
