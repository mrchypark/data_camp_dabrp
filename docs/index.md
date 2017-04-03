
---
title: "실무 빅데이터 분석을 위한 SQL과 R의 활용 CAMP"
author: "ChanYub Park"
date: "2017-04-06"
knit: "bookdown::render_book"
site: bookdown::bookdown_site
documentclass: book
---
# 머리말 {-}

 이 책은 [패스트캠퍼스][1]의 [데이터 사이언스 캠프][2] 코스의 [실무 빅데이터 분석을 위한 SQL과 R의 활용 CAMP][3]의 수업용으로 제작되었습니다. 수업에 대해 더 자세히 알고 싶으신 분은 [강사 인터뷰][4]를 참고하세요. 

 책은 각각 R의 IDE로 사실상 표준인 [RStudio][5]에 사용하기 좋은 기능 소개, 대부분의 에러 문제를 해결할 수 있는 기초 자료형에 대한 이해, 단순 반복 업무를 위한 for문과 apply류 맛보기, 데이터 원본/의존성의 개념과 SQL 문법 익히기, [tidy data][6] 개념과 dplyr+tidyr로 데이터 다루기, 보고용 차트를 위한 ggplot2 사용하기, 정기 보고서 자동 작성을 위해 knitr로 문서화하고 스케줄러로 자동화하기, [shiny][7] 패키지를 활용한 인터렉티프 웹 만들기로 구성되어 있습니다. 많은 부분 [rstudio-IDE-cheatsheet][13], [R for Data Science][9], [R Programming for Data Science][10], [ggplot2-book][11], [shiny-tutorial][12], [Microsoft's DAT204x][14], [datacamp][15], [programiz][16]을 참고하였습니다.
 
 데이터 분석은 많은 단계들과 업무들로 나누어져 있습니다. 개인적으로 1. 데이터 확보 2. 데이터 정제 3. 분석 4. 시각화의 단계를 거친다고 생각합니다. 데이터란 사내에서 관리하고 있는 내부 데이터와 외부 인터넷에 공개되어 있는 데이터로 구분할 수 있습니다. 이런 데이터들 중 분석과 업무 목적에 맞는 데이터를 찾고, 활용하기 위에 확보하는 과정이 1단계 입니다. 분석 방법과 내용에 따라 확보된 데이터를 정리하거나 고쳐야 하는 일도 있습니다. 2 단계는 그것을 뜻합니다. 3 단계인 분석은 다양한 통계적 방법들을 통해 분석 목적을 이루는 것입니다. 4단계는 이렇게 이루어낸 결과물을 다른 사람에게 전달하기 위해 필요합니다. 
 
 이 책은 그 중 2단계인 정제와 4단계인 시각화에 초점이 맞춰져 있습니다. 계속 업데이트되므로 정보 챕터 하단에 업데이트 날짜를 확인하세요.

 저작물 라이선스로 [크리에이티브 커먼즈 라이선스 4.0(저작자 표시-비영리-변경 금지(BY-NC-ND))][8]를 따릅니다.


[1]: http://www.fastcampus.co.kr
[2]: http://www.fastcampus.co.kr/category_data_camp/
[3]: http://www.fastcampus.co.kr/data_camp_dabrp/
[4]: http://www.fastcampus.co.kr/data_camp_dabrp_instructor_1/
[5]: http://www.rstudio.org/
[6]: http://vita.had.co.nz/papers/tidy-data.pdf
[7]: https://shiny.rstudio.com/
[8]: https://creativecommons.org/licenses/by-nc-nd/4.0/
[9]: http://r4ds.had.co.nz/
[10]: https://bookdown.org/rdpeng/rprogdatascience/
[11]: http://had.co.nz/ggplot2/
[12]: https://shiny.rstudio.com/tutorial/
[13]: https://www.rstudio.com/wp-content/uploads/2016/01/rstudio-IDE-cheatsheet.pdf
[14]: https://courses.edx.org/courses/course-v1:Microsoft+DAT204x+1T2017/info
[15]: https://www.datacamp.com/community/tutorials/
[16]: https://www.programiz.com/r-programming/
