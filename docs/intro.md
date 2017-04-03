
# 시작하기 전에 {#before-start}

수업에서 사용하는 자료와 기반하는 생각들을 작성하고자 합니다. 

## 데이터를 다루는 것 {#content-intro}

데이터 과학을 진행하는데에는 아래의 과정을 따릅니다. 
###### 공부를 위해 작성하는 자료니 만큼 자료를 생산하는 모든 코드는 숨기지 않고 같이 출력할 것입니다.


```r
library("visNetwork")
nodes <- data.frame(id = 1:7,label=c("1. 데이터 확보","2. 데이터 정제",
                                     "3. 분석","데이터 핸들링","분석","결과 검증","4. 시각화"),
                    shape="box", font.size=25)
edges <- data.frame(from = c(1,2,3,4,5,3,6), 
                    to = c(2,3,7,5,6,4,4),
                    dashes = c(F,F,F,F,F,T,F),
                    length=100)
visNetwork(nodes, edges, width = "100%") %>% 
  visEdges(arrows =list(to = list(enabled = TRUE, scaleFactor = 1))) %>% 
  visLayout(randomSeed = -0.9261698*10000)
```

<!--html_preserve--><div id="htmlwidget-14d5992801777f4abbc5" style="width:100%;height:355.968px;" class="visNetwork html-widget"></div>
<script type="application/json" data-for="htmlwidget-14d5992801777f4abbc5">{"x":{"nodes":{"id":[1,2,3,4,5,6,7],"label":["1. 데이터 확보","2. 데이터 정제","3. 분석","데이터 핸들링","분석","결과 검증","4. 시각화"],"shape":["box","box","box","box","box","box","box"],"font.size":[25,25,25,25,25,25,25]},"edges":{"from":[1,2,3,4,5,3,6],"to":[2,3,7,5,6,4,4],"dashes":[false,false,false,false,false,true,false],"length":[100,100,100,100,100,100,100]},"nodesToDataframe":true,"edgesToDataframe":true,"options":{"width":"100%","height":"100%","nodes":{"shape":"dot"},"manipulation":{"enabled":false},"edges":{"arrows":{"to":{"enabled":true,"scaleFactor":1}}},"layout":{"randomSeed":-9261.698}},"groups":null,"width":"100%","height":null,"idselection":{"enabled":false},"byselection":{"enabled":false},"main":null,"submain":null,"footer":null},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

위 표는 [해들리 위컴][101]의 [R for Data Science](http://r4ds.had.co.nz/)에 소개에 작성된 표이기도 합니다. 각각 Import, Tidy, Transform, Visualise, Model, Communicate라고 되어 있는 것을 제 상황에 맞게 각색하였습니다.

**데이터 확보**는 분석 목적에 맞는 데이터를 확보하는 것입니다. 보통 기업인의 입장에서 기업 내부에서 생산, 관리되고 있는 데이터, 외부에서 찾아야 하는 데이터, 없기 때문에 실험등을 통해 생산해야 하는 데이터 정도로 데이터를 나눌 수 있습니다. 이 때 내부 데이터를 사용하기 위해서는 두 가지 진입장벽이 있는데, 정책적인 접근 권한과 데이터를 다룰 줄 아는 능력입니다. 이 후 과정에서 데이터를 다루고, 그것으로 통계적 분석을 거쳐 필요한 결과물을 만드는 것에서 가장 보편적인 도구는 엑셀입니다. 데부분은 엑셀을 잘 사용하는 것으로 해결할 수 있습니다. 하지만 데이터가 커지고, 통계적 분석에 대한 수요가 높아지면서 R에 대한 관심으로 이어지고 있는 상황입니다.

**데이터 정제**는 [해들리 위컴][101]이 이야기한 Tidy data를 만드는 과정에 해당합니다. 이것을 위해서 Tidy data에 대해서 이야기 해야 하는데 그건 6장에서 다루려고 합니다. 간단하게는 컴퓨터에게 일을 시키기 좋은 상태로 데이터를 정리하는 것을 뜻합니다. 시간이 많이 드는 과정입니다.

**분석**은 데이터 핸들링, 분석, 결과 검증의 사이클을 따라 반복합니다. EDA나 데이터 이해를 위한 시각화 등이 이루어지고, 분석을 진행하며 얻는 결과물들을 만드는 과정이 진행됩니다. 이 때 개발에서 재현성의 개념을 가져오면 일을 좀 수월하게 할 수 있습니다. 여기서 말하는 재현성이란 [연구 재현성][102]보다는 실행 재현성을 뜻합니다. 실행 재현성은 어떤 결과물을 만드는 작업을 실행했을 때 다시 그것을 그대로 실행할 수 있는 것을 뜻합니다. 코드로 분석을 진행하는 것은 실행 재현성과 자동화에 매우 도움이 됩니다.

**시각화**는 앞서 반복적인 연구를 통해 알게된 사실을 다른 사람들에게 전달하는 과정 전체를 뜻합니다. 본 자료에서는 그래서 차트그리기 뿐만 아니라 Rmd를 활용한 문서화와 shiny를 활용한 앱 또한 시각화의 일부로써 다루고 있습니다.

위 4개 과정을 모두 다룰 줄 알면, 이제 도구를 다룰줄 알게 되는 것입니다. 연구나 분석 능력은 또 별개이지 않나 싶습니다. 이 책을 지속적으로 업데이트해서 연구와 분석, 데이터 과학에 대해 모두 다루는 책이 되기를 희망합니다.

## 준비된 데이터 {#data-for-class}

수업을 위해 준비한 데이터는 [고위 공직자 재산][103], [세종기업데이터][104]를 크롤링한 [깃헙 저장소][105], outbrain이 [캐글][106]에 공개한 [사용자 웹 클릭 데이터][107] 입니다. [웹 클릭 데이터][107]는 특별히 sql로 데이터 핸들링을 하는 것에 대한 경험을 확보하기 위해서 찾아보았으며 전체 데이터는 약 100GB에 달하는 방대한 양입니다. 수업에서 실제로 다루기 보다는 다루어 보실 수 있게 데이터를 준비했습니다.

## R과 Rstudio {#rstudio-intro}

R은 [여기][116]에서 다운로드 할 수 있습니다. [RStudio][118]은 R을 사용하기 위한 [IDE][119]로 여러 편의성을 제공합니다. 자세한 사용법은 2장에서 소개합니다.

## git과 github {#github-intro}

[git][120]은 코드의 버전관리 도구로 [github][121]의 인기에 힘입어 많은 개발자들이 사용하고 있습니다. 코드를 공개해 사용하면 무료이며, 이 책을 호스팅 하는 것처럼 각 아이디의 서브도메인을 무료로 사용할 수 있게 제공해줍니다. 수업에서는 자료 공유의 목적과 다른 사용자의 코드를 사용하는 수준으로 사용을 권장할 예정이며 깊게 공부하고 싶다면 [한글자료][122]가 많이 준비되어 있으니 참고하시기 바랍니다.

## 사용할 데이터베이스 {#database-for-class}

오픈소스인 [mariaDB][108]을 사용하려고 합니다. 사용한 이유는 [이 기사][109]가 잘 설명하는 것 같습니다. 기본적으로는 전통적인 RDBMS이면서 많은 사람들이 사용하는 제품이기 때문입니다. 수업에 사용하는 모든 서비스, 패키지 등 일체는 모두 1. 오픈 소스이고 2. 많은 사용자를 확보해서 활발히 발달하고 있으며 3. 참고할 자료가 많은 것을 선택하려고 노력했습니다. 데이터베이스의 설치는 [windows][110], [mac][112]을 참고해 주세요. mariaDB와 함께 인터페이스로 설치되는 [HeidiSQL][113]은 데이터베이스를 관리하는데 사용하는 GUI 툴입니다. 맥에서는 WINE을 통해서 사용할 수 있다고 하는데, [Sequel Pro][114]라는 도구도 있고, 설치를 소개하는 [블로그][111]가 있으니 참고하시기 바랍니다. 

## 환경 통일을 위한 도구 도커 {#docker-for-reproducible}

수업에서 다루지는 않지만 설치나 다른 환경 세팅으로 인한 시간 소모를 줄이기 위해서 [docker][115]를 사용할 수 있습니다. 수업 데이터가 준비되어 있는 마리아디비 도커 이미지를 준비하고 있습니다. 윈도우에서 하이퍼바이저(pro 버전 등에서 사용가능)가 있지 않은 경우 버추얼박스를 통해서 동작하므로 성능이 떨어질 수 있습니다. 

## 정보 {#Colophon}

 이 책의 소스는 [여기][117]에서 확인하실 수 있으며 아래 주어진 R 패키지(및 종속 패키지)의 버전으로 제작되었습니다. 저작물의 재현을 위해서 필요합니다.


package       *    version   date         source         
------------  ---  --------  -----------  ---------------
backports          1.0.5     2017-01-18   CRAN (R 3.3.3) 
bookdown           0.3       2016-11-28   CRAN (R 3.3.3) 
codetools          0.2-15    2016-10-05   CRAN (R 3.3.3) 
devtools           1.12.0    2016-12-05   CRAN (R 3.3.3) 
digest             0.6.12    2017-01-27   CRAN (R 3.3.3) 
evaluate           0.10      2016-10-11   CRAN (R 3.3.3) 
htmltools          0.3.5     2016-03-21   CRAN (R 3.3.3) 
htmlwidgets        0.8       2016-11-09   CRAN (R 3.3.3) 
jsonlite           1.3       2017-02-28   CRAN (R 3.3.3) 
knitr              1.15.1    2016-11-22   CRAN (R 3.3.3) 
magrittr           1.5       2014-11-22   CRAN (R 3.3.3) 
memoise            1.0.0     2016-01-29   CRAN (R 3.3.3) 
Rcpp               0.12.10   2017-03-19   CRAN (R 3.3.3) 
rmarkdown          1.3       2016-12-21   CRAN (R 3.3.3) 
rprojroot          1.2       2017-01-16   CRAN (R 3.3.3) 
stringi            1.1.2     2016-10-01   CRAN (R 3.3.3) 
stringr            1.2.0     2017-02-18   CRAN (R 3.3.3) 
visNetwork    *    1.0.3     2016-12-22   CRAN (R 3.3.3) 
withr              1.0.2     2016-06-20   CRAN (R 3.3.3) 
yaml               2.1.14    2016-11-12   CRAN (R 3.3.3) 

 이 책은 [박찬엽][123]이 Sunday, April 02, 2017 08:58:15 PM UTC에 마지막으로 업데이트 했습니다.

[101]: http://hadley.nz/
[102]: http://scienceon.hani.co.kr/?document_srl=396048
[103]: http://jaesan.newstapa.org/#data
[104]: http://www.sejongdata.com/
[105]: https://github.com/mrchypark/sejongFinData
[106]: https://www.kaggle.com/
[107]: https://www.kaggle.com/c/outbrain-click-prediction/data
[108]: https://downloads.mariadb.org/
[109]: http://www.bloter.net/archives/172930
[110]: http://pyonji.tistory.com/11
[111]: http://wingsnote.com/22
[112]: https://cpuu.postype.com/post/24270/
[113]: https://www.heidisql.com/
[114]: http://www.sequelpro.com/
[115]: http://www.docker.com/
[116]: https://cloud.r-project.org/
[117]: https://github.com/mrchypark/data_camp_dabrp
[118]: https://www.rstudio.com/products/rstudio/download/
[119]: https://ko.wikipedia.org/wiki/%ED%86%B5%ED%95%A9_%EA%B0%9C%EB%B0%9C_%ED%99%98%EA%B2%BD
[120]: https://git-scm.com/book/ko/v2/%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0-%EB%B2%84%EC%A0%84-%EA%B4%80%EB%A6%AC%EB%9E%80%3F
[121]: https://github.com/
[122]: https://rogerdudler.github.io/git-guide/index.ko.html
[123]: https://rcoholic.github.io/
