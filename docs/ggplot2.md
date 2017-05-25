
# 보고용 차트를 위한 ggplot2 사용하기 {#ggplot}

## ggplot2


```r
# 패키지 불러오기
library(tidyverse)
#> Loading tidyverse: ggplot2
#> Loading tidyverse: tibble
#> Loading tidyverse: tidyr
#> Loading tidyverse: readr
#> Loading tidyverse: purrr
#> Loading tidyverse: dplyr
#> Conflicts with tidy packages ----------------------------------------------
#> filter(): dplyr, stats
#> lag():    dplyr, stats
options(stringsAsFactors = F)
```

```
# layers = data + mapping(aes) + geom + stat + position
# ggplot = layers + scales + coordinate system

# 데이터 설명 : https://github.com/jennybc/gapminder
# 시각화 예시 : http://www.gapminder.org/tools/#_locale_id=en;&chart-type=bubbles
if (!require("gapminder")){install.packages("gapminder")}
library(gapminder)

# ggplot 객체 만들기
p <-ggplot(gapminder, aes(x = gdpPercap, y = lifeExp))
p
# 객체의 구조와 정보 파악하기
summary(p)

#  geom 추가 하기 point
p_point <- p + geom_point()
p_point
# 객체 정보에서 geom이 추가된 것 확인하기
summary(p_point)

# x 축을 log 변환하여 출력하기
ggplot(gapminder, aes(x = log10(gdpPercap), y = lifeExp)) +
  geom_point()

# ggplot 문법에 맞게 log 변환하기
p_point_log10 <- p_point + scale_x_log10()
p_point_log10

# color 정보를 aes를 이용해서 mapping 하기
p_point_color <- p + geom_point(aes(color = continent))
p_point_color
# 색정보가 mapping 된 것 확인하기
summary(p_point_color)

# geom 특징 조절하기 alpha = 투명도, size = 크기 
p + geom_point(alpha = (1/3), size = 3)

# 추세선 추가하기
# method가 자동으로 지정되나 설정할 수 있음
p_point + stat_smooth()

# 추세선에 대해 geom으로도 취급함
# geom 특징인 선 두께(lwd)등 조절 가능
p_point + geom_smooth(lwd = 3, se = FALSE)

# method를 lm(선형회귀)로 변경
p_point + geom_smooth(lwd = 2, se = FALSE, method = "lm")

# 색정보를 전체에 반형하기
p_point_color + geom_smooth(lwd = 2, se = FALSE)
p + aes(color = continent) + geom_point() + geom_smooth(lwd = 1, se = FALSE)

# group 과 color
p + aes(color = continent) + geom_point() + geom_smooth(lwd = 2, se = FALSE)
p + aes(group = continent)+ geom_point() + geom_smooth(lwd = 2, se = FALSE)

# 그래프를 facet 기준으로 나눠 그리기
p + geom_point(alpha = (1/3), size = 3) +
  facet_wrap(~ continent)

p + geom_point(alpha = (1/3), size = 3) +
  facet_wrap(~ continent) +
  geom_smooth(lwd = 2, se = FALSE)

# jitter : 집중된 정보를 흩뿌려 보여주는 특별한 geom_point
ggplot(gapminder, aes(x = year, y = lifeExp,
                      color = continent)) +
  geom_jitter(alpha = 1/3, size = 3, width=1)

ggplot(gapminder, aes(x = year, y = lifeExp,
                      color = continent)) +
  geom_point(alpha = 1/3, size = 3)

# 대륙별로 차트 나눠 그리기
ggplot(gapminder, aes(x = year, y = lifeExp,
                      color = continent)) +
  facet_wrap(~ continent) +
  geom_jitter(alpha = 1/3, size = 3, width=1)

# 각 차트의 척도 기준 조절하기(default = "fixed")
ggplot(gapminder, aes(x = year, y = lifeExp,
                      color = continent)) +
  facet_wrap(~ continent, scales = "free_y") +
  geom_jitter(alpha = 1/3, size = 3)

# scale 함수로 색 조절하기
ggplot(gapminder, aes(x = year, y = lifeExp,
                      color = continent)) +
  facet_wrap(~ continent, scales = "free_x") +
  geom_jitter(alpha = 1/3, size = 3) +
  scale_color_manual(values = continent_colors)

# dplyr 과 섞어 사용하기
# %>% 와 + 주의
jc <- "Cambodia"
gapminder %>% 
  filter(country == jc) %>% 
  ggplot(aes(x = year, y = lifeExp)) +
  labs(title = jc) +
  geom_line()

# point + line
# 여러 기준의 point 출력하기
(lp <- ggplot(gapminder, aes(x = year, y = lifeExp)) + geom_point())

# 대륙 기준 차트 나누기
lp + facet_wrap(~ continent)

# 각 차트별 추세선 추가하기
lp + geom_smooth(se = FALSE, lwd = 2) +
  facet_wrap(~ continent)

# geom은 각 개별이 layer이므로 추가됨
lp + geom_smooth(se = FALSE, lwd = 2) +
  geom_smooth(se = FALSE, method ="lm", color = "orange", lwd = 2) +
  facet_wrap(~ continent)

# 객체 준비하기
lpf <- lp + facet_wrap(~ continent)
# geom_point 에 geom_line 추가하기
lpf + geom_line() 

# 각 line이 나라별 데이터이므로 group해야 함
lpf + geom_line(aes(group = country))

# 전체 데이터에 대해 추세선 추가
lpf + geom_line(aes(group = country)) +
  geom_smooth(se = FALSE, lwd = 2) 

# color가 group의 역할을 함.
jCountries <- c("Canada", "Rwanda", "Cambodia", "Mexico")
gapminder %>% filter(country %in% jCountries) %>%
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_line() + geom_point()

# 범례 순서를 데이터의 순서로 재조정
gapminder %>% filter(country %in% jCountries) %>%
  ggplot(aes(x = year, y = lifeExp, color = reorder(country, -1 * lifeExp, max))) +
  geom_line() + geom_point()

# bin2d 차트
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10() + geom_bin2d()

# 헥사 차트
if (!require("hexbin")){install.packages("hexbin")}
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  scale_x_log10() + geom_hex() + scale_fill_gradient(high = "#132B43", low = "#56B1F7")

# 대륙별 관측치 개수 구하기
table(gapminder$continent)

# histogram 그리기
ggplot(gapminder, aes(x = continent)) + geom_bar()

# 크기순으로 재정렬
# reorder(정렬하고자 하는 대상, 정렬 기준, 정렬 조건)
p <- ggplot(gapminder, aes(x = reorder(continent, continent, length)))
p + geom_bar()

# coordinate 함수 중 돌리기
p + geom_bar() + coord_flip()

# goem_bar 특징 조절하기
p + geom_bar(width = 0.1) + coord_flip()

# length 를 계산해서 그래프 그리기
(continent_freq <- gapminder %>% count(continent))
# bar plot이 마음대로 그려지지 않음
(freq_plot <- ggplot(continent_freq, aes(x = continent)) + geom_bar())
# stat이 count인 것을 확인(bar는 default가 count)
summary(freq_plot)
# 계산을 한 데이터로 bar plot 출력하는 법
(freq_ident<-ggplot(continent_freq, aes(x = continent, y = n)) + geom_bar(stat = "identity"))
summary(freq_ident)

# historam 옵션을 사용하기
ggplot(gapminder, aes(x = lifeExp)) +
  geom_histogram()

# geom 조절하기 bin은 나누는 구간의 크기를 의미
ggplot(gapminder, aes(x = lifeExp)) +
  geom_histogram(binwidth = 1)

# 각 대륙별로 나눠서 보기
(hist_fill<-ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_histogram())

# stack이 기본 옵션임(누적 그래프)
summary(hist_fill)

# 최대값이 독립적이 되게 작성
ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_histogram(position = "identity")

# 밀도함수 - 선색
ggplot(gapminder, aes(x = lifeExp, color = continent)) + geom_density()

# 밀도함수 - 면적 색
ggplot(gapminder, aes(x = lifeExp, fill = continent)) +
  geom_density(alpha = 0.2)

# point에서 정보가 충분히 보이지 않을 때
ggplot(gapminder, aes(x = continent, y = lifeExp)) + geom_point()

# jitter 흩뿌리기
ggplot(gapminder, aes(x = continent, y = lifeExp)) + geom_jitter()

# jitter geom 조절하기
ggplot(gapminder, aes(x = continent, y = lifeExp)) + 
  geom_jitter(position = position_jitter(width = 0.1, height = 0), alpha = 1/4)

# boxplot 평균 및 4분위 표시
ggplot(gapminder, aes(x = continent, y = lifeExp)) + geom_boxplot()

# layer 겹치게 그리기
ggplot(gapminder, aes(x = continent, y = lifeExp)) +
  geom_boxplot(outlier.colour = "hotpink") +
  geom_jitter(position = position_jitter(width = 0.1, height = 0), alpha = 1/4)

# stat 기능으로 layer 추가하기
ggplot(gapminder, aes(x = continent, y = lifeExp)) + 
  geom_jitter(position = position_jitter(width = 0.1), alpha = 1/4) +
  stat_summary(fun.y = median, colour = "red", geom = "point", size = 5)


## korean map

## UTM / UTM-K / GPS
## 좌표계에 대한 설명
# https://mrchypark.wordpress.com/2014/10/23/%EC%A2%8C%ED%91%9C%EA%B3%84-%EB%B3%80%ED%99%98-proj4-%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC/

# 패키지 세팅하기
if (!require("mapdata")){install.packages("mapdata")}
if (!require("mapproj")){install.packages("mapproj")}
library(mapdata)
library(mapproj)

# 내장된 지도 데이터 불러와서 한국만 가져오기
world<-map_data("worldHires")
korea<-world[grep("Korea$", world$region),]

# 한국 지도 그리기
p<-ggplot(korea,aes(x=long,y=lat,group=group))
p+geom_polygon(fill="white",color="black") + coord_map()

# Kormaps를 이용해 세부적인 한국 지도 그리기
# 패키지 세팅하기
if (!require("Kormaps")){devtools::install_github("cardiomoon/Kormaps")}
if (!require("tmap")){install.packages("tmap")}
if (!require("cartogram")){devtools::install_github("sjewo/cartogram")}
library(Kormaps)
library(tmap)
library(cartogram)

# 윈도우를 위한 폰트 설정하기
# for windows
windowsFonts()
if (!require("extrafont")){install.packages("extrafont")}
library(extrafont)
#font_import()
loadfonts()

# 내장 인구 데이터를 이용해 한국 지도 그리기
qtm(kormap1)
qtm(korpopmap1,"총인구_명")+tm_layout(fontfamily="NanumGothic")
qtm(korpopmap2,"총인구_명")+tm_layout(fontfamily="NanumGothic")

# 인코딩 문제 고치기
Encoding(names(korpopmap1))<-"UTF-8"
Encoding(names(korpopmap2))<-"UTF-8"
# ggplot 으로 한국 지도 그리기 위한 전처리
kor <- fortify(korpopmap1, region = "id")
kordf <- merge(kor, korpopmap1@data, by = "id")

# ggplot으로 한국 지도 그리기
ggplot(kordf, aes(x=long.x, y=lat.x, group=group.x, fill=`총인구_명`)) + 
  geom_polygon(color="black") + coord_map() +
  scale_fill_gradient(high = "#132B43", low = "#56B1F7") +
  theme(title=element_text(family="NanumGothic",face="bold"))

# ggplot facet 기능 적용해 보기
# 남녀 인구로 구분
kordfs <- kordf %>% select(id:여자_명) %>% gather(성별,인구,-(id:총인구_명))

# 남녀 인구 한국 지도 시각화
ggplot(kordfs, aes(x=long.x, y=lat.x, group=group.x, fill=`인구`)) + 
  geom_polygon(color="black") + coord_map() +
  scale_fill_gradient(high = "#132B43", low = "#56B1F7") +
  theme(text=element_text(family="NanumGothic",face="bold")) +
  facet_grid(.~ 성별)

# 2016년 총선 결과 cartogram 그리기
# https://www.facebook.com/groups/krstudy/permalink/785465478294393/기

# cartogram의 다른 예시(ggplot 아님)
# https://github.com/jjangkr/cartogram_4_anything

library(rgdal)
library(maptools)
korea <- readOGR(dsn = "./election", layer="DistResult2016", encoding = 'euc-kr')

# sp패키지의 SpatialPolygonsDataFrame 자료형을 사용합니다.
class(korea)
# 카토그램 모양을 계산합니다. 시간이 꽤 걸리니 5이하의 숫자를 사옹해 주세요.
# 지금은 미리 만든 객체를 불러올 것입니다.
# c_korea <- cartogram(korea, "Pop", 5)
# save(c_korea,file = "c_korea.RData")
load("c_korea.RData")
# data.frame으로 변환하기 위해 fortify 함수를 사용합니다.
c_korea.df <- fortify(c_korea)
# 변환된 상태
class(c_korea.df)
head(c_korea.df)
summary(c_korea.df)
str(c_korea.df)
# 데이터를 합치기 위한 키 생성
c_korea@data$id <- rownames(c_korea@data)
# 데이터 합치기 - 조인
c_korea.df <- c_korea.df %>% left_join(c_korea@data, by="id")
str(c_korea.df)
# 인코딩 수정
Encoding(c_korea.df$Dist)<-"UTF-8"
Encoding(c_korea.df$SD)<-"UTF-8"
Encoding(c_korea.df$SGG)<-"UTF-8"
str(c_korea.df)

# 빈 테마 미리 만들기
theme_clean <- function(base_size = 12) {
  require(grid)
  theme_grey(base_size) %+replace%
    theme(
      axis.title = element_blank(),
      axis.text = element_blank(),
      panel.background = element_blank(),
      panel.grid = element_blank(),
      axis.ticks.length = unit(0, "cm"),
      complete = TRUE
    )
}

# 카토그램 그리기 
election <- ggplot(c_korea.df, aes(x=long, y=lat, group=group)) + 
  geom_polygon(aes(alpha=RatioS), fill=rgb(1,0,0), colour="white", lwd = 0.01) +
  geom_polygon(aes(alpha=RatioP), fill=rgb(0,1,0), colour="white", lwd = 0.01) +
  geom_polygon(aes(alpha=RatioT), fill=rgb(0,0,1), colour="white", lwd = 0.01) +
  guides(fill=FALSE, alpha=FALSE) + theme_clean() + coord_map()

election


# ggmap
# https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/ggmap/ggmapCheatsheet.pdf
devtools::install_github("dkahle/ggmap")
library(ggmap)
# for mac
loc<-"서울"
tar<-"서울시청"
# for windows
loc<-URLencode(enc2utf8("서울"))
tar<-URLencode(enc2utf8("서울시청"))
# output = c("latlon", "latlona", "more", "all")
# 위경도만 / +주소 / +나라,우편번호등 추가 / + api 정보 전체
geocityhall<-geocode(tar)
get_googlemap(loc,maptype = "roadmap",markers = geocityhall) %>% ggmap()


## extra
## https://www.ggplot2-exts.org/
## ggplot을 더 풍부하게 만들어 주는 추가 패키지 소개

# ggsci
# https://cran.r-project.org/web/packages/ggsci/vignettes/ggsci.html
# 유명 색조합이 미리 준비되어 있는 패키지 
devtools::install_github("road2stat/ggsci")
library(ggsci)
library(gridExtra)
data("diamonds")
# 그래프 객체 저장하기
p1 = ggplot(subset(diamonds, carat >= 2.2),
            aes(x = table, y = price, colour = cut)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "loess", alpha = 0.05, size = 1, span = 1) +
  theme_bw()

p2 = ggplot(subset(diamonds, carat > 2.2 & depth > 55 & depth < 70),
            aes(x = depth, fill = cut)) +
  geom_histogram(colour = "black", binwidth = 1, position = "dodge") +
  theme_bw()

# aaas 테마 적용하기
p1_aaas = p1 + scale_color_aaas()
p2_aaas = p2 + scale_fill_aaas()
# grid.arrange는 gridExtra 패키지내 함수입니다.
grid.arrange(p1_aaas, p2_aaas, ncol = 2)

p1_aaas
p1 + theme_hc() +
  scale_colour_hc()

# ggthemes
# 테마 추가
devtools::install_github("jrnold/ggthemes")
library("ggthemes")

p1_th1<-p1 + theme_hc() +
  scale_colour_hc()
p2_th2<-p2 + theme_hc(bgcolor = "darkunica") +
  scale_fill_hc("darkunica")
grid.arrange(p1_th1, p2_th2, ncol = 2)


# ggrepel
# https://github.com/slowkow/ggrepel/blob/master/vignettes/ggrepel.md
# 글자를 겹치지 않게 그려주는 패키지
devtools::install_github("slowkow/ggrepel")
library(ggrepel)
# 차트에 글자 추가하기
ggplot(mtcars) +
  geom_point(aes(wt, mpg), color = 'red') +
  geom_text(aes(wt, mpg, label = rownames(mtcars))) +
  theme_classic(base_size = 16)
# 차트에 글자가 겹치지 않게 추가하기
ggplot(mtcars) +
  geom_point(aes(wt, mpg), color = 'red') +
  geom_text_repel(aes(wt, mpg, label = rownames(mtcars))) +
  theme_classic(base_size = 16)

# ggExtra
# https://github.com/daattali/ggExtra
# 3면 차트를 그리게 도와주는 패키지
devtools::install_github("daattali/ggExtra")
library(ggExtra)
df1 <- data.frame(x = rnorm(500, 50, 10), y = runif(500, 0, 50))
(p1 <- ggplot(df1, aes(x, y)) + geom_point() + theme_bw())
ggMarginal(p1, type = "histogram")

# ggfortify
# https://github.com/sinhrks/ggfortify
# 분석 결과 보고용 출력 수준 차트 생성 패키지 1
devtools::install_github('sinhrks/ggfortify')
library(ggfortify)
# 자동으로 분석 결과에 맞는 그림 출력하기 
# k-means 클러스터링
res <- lapply(c(3, 4, 5), function(x) kmeans(iris[-5], x))
autoplot(res, data = iris[-5], ncol = 3)

# 회귀 분석
autoplot(lm(Petal.Width ~ Petal.Length, data = iris), data = iris,
         colour = 'Species', label.size = 3)

if (!require("dlm")){install.packages("dlm")}
library(dlm)
form <- function(theta){
  dlmModPoly(order = 1, dV = exp(theta[1]), dW = exp(theta[2]))
}
# 동적선형분석
model <- form(dlmMLE(Nile, parm = c(1, 1), form)$par)
filtered <- dlmFilter(Nile, model)
autoplot(filtered)

# ggally
# http://ggobi.github.io/ggally/index.html
# 분석 결과 보고용 출력 수준 차트 생성 패키지 2
devtools::install_github("ggobi/ggally")
if (!require("network")){install.packages("network")}
if (!require("sna")){install.packages("sna")}
library(network)
library(sna)
library(GGally)
airports <- read.csv("http://datasets.flowingdata.com/tuts/maparcs/airports.csv", header = TRUE)
rownames(airports) <- airports$iata

# 무작위로 일부 비행기만 선택
flights <- data.frame(
  origin = sample(airports[200:400, ]$iata, 200, replace = TRUE),
  destination = sample(airports[200:400, ]$iata, 200, replace = TRUE)
)

# network 자료형으로 변환
flights <- network(flights, directed = TRUE)

# 위경도 정보 추가 %v%는 각 노드 정보라는 뜻의 연산자
flights %v% "lat" <- airports[ network.vertex.names(flights), "lat" ]
flights %v% "lon" <- airports[ network.vertex.names(flights), "long" ]
flights

# 혼자 있는 노드 제거
delete.vertices(flights, which(degree(flights) < 2))

# 중심성 계산
flights %v% "degree" <- degree(flights, gmode = "digraph")

# 랜덤으로 4개의 집단으로 구분
flights %v% "mygroup" <- sample(letters[1:4], network.size(flights), replace = TRUE)

# 미국지도만 생성
usa <- ggplot(map_data("usa"), aes(x = long, y = lat)) +
  geom_polygon(aes(group = group), color = "grey65",
               fill = "#f9f9f9", size = 0.2)

# 미국내 정보 이외에 제거
delete.vertices(flights, which(flights %v% "lon" < min(usa$data$long)))
delete.vertices(flights, which(flights %v% "lon" > max(usa$data$long)))
delete.vertices(flights, which(flights %v% "lat" < min(usa$data$lat)))
delete.vertices(flights, which(flights %v% "lat" > max(usa$data$lat)))

# 미국 지도 위에 비행기 layer 추가하기
ggnetworkmap(usa, flights, size = 4, great.circles = TRUE,
             node.group = mygroup, segment.color = "steelblue",
             ring.group = degree, weight = degree)


# gganimate
# http://www.gapminder.org/world/
# 움직이는 차트 그리기
devtools::install_github("dgrtwo/gganimate")
if (!require("magick")){install.packages("magick")}
library(magick)
library(gganimate)

# for mac
# brew install ghostscript imagemagick
# for ubuntu
# sudo apt-get install ghostscript imagemagick
# for windows
# http://www.imagemagick.org/script/binary-releases.php
# https://www.ghostscript.com/download/gsdnld.html

p <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, color = continent, frame = year)) +
  geom_point() +
  scale_x_log10()
p

# for windows
magickPath <- shortPathName("C:\\Program Files\\ImageMagick-7.0.5-Q16\\magick.exe")
animation::ani.options(convert=magickPath)
gganimate(p,interval = .2)

dir.create("./animate",showWarnings = F)
gganimate(p, "./animate/output.gif")
gganimate(p, "./animate/output.mp4")
gganimate(p, "./animate/output.html")

# ggiraph
# http://davidgohel.github.io/ggiraph/
# javescript 기반 동적 차트 생성 패키지
devtools::install_github("davidgohel/ggiraph")
library(ggiraph)
# 기본 그래프 그리기
g <- ggplot(mpg, aes( x = displ, y = cty, color = hwy) ) + theme_minimal()
g + geom_point(size = 2) 

# 폰트가 여기서 나오지 않으면 ggiraph가 출력되지 않습니다.
gdtools::sys_fonts()
# if data NUll try below for mac
# brew install cairo
# tooltip 기능을 활용한 동적 차트 예
my_gg <- g + geom_point_interactive(aes(tooltip = model), size = 2) 
ggiraph(code = print(my_gg), width = .7)

# ggedit
# gui 클릭으로 ggplot 컨트롤할 수 있게 해주는 add-on
install.packages("ggedit")
library(ggedit)
p <- ggplot(mtcars, aes(x = hp, y = wt)) + 
  geom_point() + geom_smooth(method = 'loess')
p
ggedit(p)



## extrafont

한글 깨짐 + 폰트 변경을 위한 패키지
```
