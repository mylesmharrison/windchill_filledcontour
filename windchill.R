# windchill.R

# Create a temperature (deg F) and wind velocity (mph) vectors
t <- 1:17*5 - 45 # -40 to +40 by 5
v <- t(1:12*5) # 5 to 60 by 5

# old system
# WC = 91.4 - (0.474677 - 0.020425*V + 0.303107*sqrt(V)))*(91.4 - T)
wco <- 91.4 - (91.4 - t)%*%(0.476477 - 0.020425*v + 0.303107*sqrt(v))

# new system
# WC = 35.74 + 0.6215T - 35.75V^0.16 + 0.4275T*(V^0.16) 
wcn <- 35.74 + 0.6215*replicate(12,t)+(0.4275*t-35.75)%*%(v^0.16)

# Visualize with filled contour plot
library("RColorBrewer")
c <- rev(colorRampPalette(brewer.pal(9, "RdYlBu"))(32))

# old system
filled.contour(t, v, wco, col=c, main="Windchill, US Old System", 
               nlevels=31, xlab="Temperature (˚F)", ylab="Windspeed (mph)",
               key.title=title("˚F"), key.axes=axis(4, seq(-120, 40, by=20)),
               zlim=c(-120,40))



# new system
filled.contour(t, v, wcn, col=c, main="Windchill, US New System", 
               nlevels=31, xlab="Temperature (˚F)", ylab="Windspeed (mph)",
               key.title=title("˚F"), key.axes=axis(4, seq(-120, 40, by=20)),
               zlim=c(-120,40))

# difference (delta)
filled.contour(t, v, wcn-wco, col=c, main="Difference, New - Old", 
               nlevels=31, xlab="Temperature (˚F)", ylab="Windspeed (mph)",
               key.title=title("˚F"), key.axes=axis(4, seq(-10, 40, by=10)),
               zlim=c(-10,40))
