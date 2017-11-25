library(ggplot2)

street_light = read.csv('main.csv')
car_stolen = read.csv('carstolenXY.csv')
house_stolen = read.csv('house_stolen.csv')
CCTV = read.csv('CCTV.csv')
bike_stolen = read.csv('bikestolen.csv')
bike_stolen_area = read.csv("bikestolen-area.csv")
store = read.csv('store.csv')
store_for_bike_stolen = read.csv('store_for_bike_stolen.csv')
bike_stolen_store = read.csv('bikestolen-store.csv')


# 路燈密集度跟汽車竊盜關係
tw = c(lon=121.550, lat=25.055000)
tw.map = get_map(location = tw, zoom = 12, language="zh-TW", maptype = "toner-lite")
street_light_car <- ggmap(tw.map, extent = "device", legend = "topleft") +
  geom_point(data=car_stolen, aes(x=lng,y=lat),colour = 'red', size = 2) +
  stat_density2d(aes(x = lng, 
                     y = lat, 
                     fill = ..level.., 
                     alpha = ..level..), 
                 size = .5, 
                 bins= 15, 
                 data = street_light,
                 geom = "polygon") +
  scale_fill_gradient(low = "black", high = "yellow") +
  scale_alpha(range = c(.01, 0.4), guide = FALSE) +
  guides(fill = guide_colorbar(barwidth = 0.5, barheight = 5)) +
  theme(text = element_text(family = "蘋方-繁 中黑體")) +
  ggtitle('路燈密集度跟汽車竊盜關係')
street_light_car

# 路燈密集度跟自行車竊盜關係
street_light_bikestolen <- ggmap(tw.map, extent = "device", legend = "topleft") +
  geom_point(data=bike_stolen, aes(x=lng,y=lat),colour = 'red', size = 2) +
  stat_density2d(aes(x = lng, 
                     y = lat, 
                     fill = ..level.., 
                     alpha = ..level..), 
                 size = .5, 
                 bins= 15, 
                 data = street_light,
                 geom = "polygon") +
  scale_fill_gradient(low = "black", high = "yellow") +
  scale_alpha(range = c(.01, 0.4), guide = FALSE) +
  guides(fill = guide_colorbar(barwidth = 0.5, barheight = 5)) +
  theme(text = element_text(family = "蘋方-繁 中黑體")) +
  ggtitle('路燈密集度跟自行車竊盜關係')
street_light_bikestolen



# CCTV和房屋竊盜關係
tw_cctv = c(lon=121.535, lat=25.053000)
tw_cctv.map = get_map(location = tw_cctv, zoom = 13, language="zh-TW", maptype = "toner-lite")
CCTV_map <- ggmap(tw_cctv.map, extent = "device", legend = "topleft") +
  geom_point(data=house_stolen, aes(x=lng,y=lat),colour = 'red', size = 3) +
  stat_density2d(aes(x = lng, 
                     y = lat, 
                     fill = ..level.., 
                     alpha = ..level..), 
                 size = .5, 
                 bins= 15, 
                 data = CCTV,
                 geom = "polygon") +
  scale_fill_gradient(low = "black", high = "#778899") +
  scale_alpha(range = c(.01, 0.4), guide = FALSE) +
  guides(fill = guide_colorbar(barwidth = 0.5, barheight = 5)) +
  theme(text = element_text(family = "蘋方-繁 中黑體")) +
  ggtitle('CCTV密度和房屋竊盜關係')
  # facet_wrap(~ area)
CCTV_map

# CCTV和自行車竊盜關係
tw_cctv = c(lon=121.535, lat=25.053000)
tw_cctv.map = get_map(location = tw_cctv, zoom = 13, language="zh-TW", maptype = "toner-lite")
CCTV_bike <- ggmap(tw_cctv.map, extent = "device", legend = "topright") +
  geom_point(data=bike_stolen_area, aes(x=lng,y=lat),colour = 'red', size = 3) +
  stat_density2d(aes(x = lng, 
                     y = lat, 
                     fill = ..level.., 
                     alpha = ..level..), 
                 size = .5, 
                 bins= 15, 
                 data = CCTV,
                 geom = "polygon") +
  scale_fill_gradient(low = "black", high = "#778899") +
  scale_alpha(range = c(.01, 0.4), guide = FALSE) +
  guides(fill = guide_colorbar(barwidth = 0.5, barheight = 5)) +
  theme(text = element_text(family = "蘋方-繁 中黑體")) +
  ggtitle('CCTV和自行車竊盜關係')
# facet_wrap(~ area)
CCTV_bike

# 便利超商(大安、萬華、信義)和自行車竊盜(大安、萬華、信義)關係
store_bike <- ggmap(tw_cctv.map, extent = "device", legend = "topleft") +
  geom_point(data=bike_stolen_area, aes(x=lng, y=lat), colour = 'red', size=3) +
  stat_density2d(aes(x = lng,
                     y = lat,
                     fill = ..level..,
                     alpha = ..level..),
                 size = .5,
                 bins= 15,
                 data = store_for_bike_stolen,
                 geom = "polygon") +
  scale_fill_gradient(low = "black", high = "#20B2AA") +
  scale_alpha(range = c(.1, 0.3), guide = FALSE) +
  guides(fill = guide_colorbar(barwidth = 0.5, barheight = 5)) +
  theme(text = element_text(family = "蘋方-繁 中黑體")) +
  ggtitle('便利超商密集度和自行車竊盜關係')
# facet_wrap(~ area)
store_bike

# 便利超商和自行車竊盜關係
tw_cctv = c(lon=121.535, lat=25.053000)
tw_cctv.map = get_map(location = tw_cctv, zoom = 12, language="zh-TW", maptype = "toner-lite")
store_bike <- ggmap(tw_cctv.map, extent = "device", legend = "topleft") +
  geom_point(data=bike_stolen, aes(x=lng, y=lat), colour = 'red', size=3) +
  stat_density2d(aes(x = lng,
                     y = lat,
                     fill = ..level..,
                     alpha = ..level..),
                 size = .5,
                 bins= 15,
                 data = store,
                 geom = "polygon") +
  scale_fill_gradient(low = "black", high = "#20B2AA") +
  scale_alpha(range = c(.1, 0.3), guide = FALSE) +
  guides(fill = guide_colorbar(barwidth = 0.5, barheight = 5)) +
  theme(text = element_text(family = "蘋方-繁 中黑體")) +
  ggtitle('便利超商密集度和自行車竊盜關係')
# facet_wrap(~ area)
store_bike

# 便利超商和自行車竊盜分佈
ggmap(tw_cctv.map, extent = "device", legend = "topleft") +
  geom_point(data = bike_stolen_store, aes(x=lng, y=lat, colour = label), size=2) +
  theme(text = element_text(family = "蘋方-繁 中黑體")) +
  ggtitle('便利超商和自行車竊盜分佈')


# 便利超商和汽車竊盜關係
store_car <- ggmap(tw_cctv.map, extent = "device", legend = "topleft") +
  geom_point(data=car_stolen, aes(x=lng, y=lat), colour = 'red', size=3) +
  stat_density2d(aes(x = lng,
                     y = lat,
                     fill = ..level..,
                     alpha = ..level..),
                 size = .5,
                 bins= 15,
                 data = store,
                 geom = "polygon") +
  scale_fill_gradient(low = "black", high = "#20B2AA") +
  scale_alpha(range = c(.1, 0.3), guide = FALSE) +
  guides(fill = guide_colorbar(barwidth = 0.5, barheight = 5)) +
  theme(text = element_text(family = "蘋方-繁 中黑體")) +
  ggtitle('便利超商密集度和汽車竊盜關係')
store_car



################################################

# DBSCAN

bike_stolen_dbscan = read.csv('bike_stolen_dbscan_for_graph.csv')
bike_stolen_dbscan$class = as.factor(bike_stolen_dbscan$class)

tw = c(lon=121.535, lat=25.053000)
tw.map = get_map(location = tw_cctv, zoom = 12, language="zh-TW", maptype = "toner-lite")
bike_dbscan <- ggmap(tw.map, extent = "device", legend = "topleft") +
  geom_point(data=bike_stolen_dbscan, aes(x=lng,y=lat,colour=class),size=2) +
  theme(text = element_text(family = "蘋方-繁 中黑體")) +
  ggtitle('路燈密集度跟汽車竊盜關係')
bike_dbscan
  
str(bike_stolen_dbscan)



