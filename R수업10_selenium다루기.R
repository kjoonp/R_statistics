# 동적으로 크롤링하기
# 로그인해야만 볼수 있는 특정 정보를 크롤링하거나 
# 반복적인 작업을 통해 정보를 추출하거나
# 마우스클릭등의 무인으로 프로그램을 조작해야 할 필요가 있는 경우
# 브라우져 자동화 프로그램인 ' 셀레니엄'을 이용하면 처리 가능

#RSelenium 패키지 설치
install.packages("RSelenium")

library(RSelenium)
library(rvest)

#seleniumhq.org => downloads => brwosers => documentation  브라우저별 드라이버

# slenium 서버구동
# java -Dwebdriver.gecko.driver='chromedriver.exe' -jar selenium-server-standalone-3.141.59.jar -port 1024

# 자동화 브라우져를 조작하기 위해 셀레니엄 서버에 연결
edge <- remoteDriver('localhost', 1024, 'chrome')

# 원결제어용 브라우져 구동
edge$open()

# 지정한 주소로 브라우져를 조작
edge$navigate('https://'naver.com'')

# 브라우져의 현재 웹페이지의 소스 읽기
res <- edge$getPageSource()[[1]]
html <- read_html(res)

# 원격제어용 브라우저 종료
edge$close()

# 다음 영화 홈에서 실시간 예매순위의 영화제목 추출
## 원격 브라우져 띄우고 영화홈에서 html소스를 크롤링하고 닫음

edge <- remoteDriver('localhost', 1024, 'chrome')
edge$open()
edge$navigate('https://movie.daum.net/main/new#slide-1-0')

res <- edge$getPageSource()[[1]]
html <- read_html(res)
edge$close()

#크롤링한 html 소스로 부터 영화제목 추출

mv <- html_nodes(html,'strong.tit_poster')
mv <- html_text(mv)
mv

###### k-apt.go.kr ##############

# 서울특별시 - 강남구 - 사성동 - 아이파크 삼성동 단지 정보 출력

url <- 'http://k-apt.go.kr/kaptinfo/openkaptinfo.do#'
chrome <- remoteDriver('localhost', 1024, 'chrome')
chrome$open()
chrome$navigate('http://k-apt.go.kr/kaptinfo/openkaptinfo.do#')


sido <- chrome$findElement('xpath',
                           '//*[@class="combo_SIDO"]/option[text()="서울특별시"]')
sido$clickElement()
Sys.sleep(1)

gugun <- chrome$findElement('xpath',
                            '//*[@class="combo_SGG"]/option[text()="강남구"]')
gugun$clickElement()
Sys.sleep(1)

dong <- chrome$findElement('xpath',
                           '//*[@class="combo_EMD"]/option[text()="삼성동"]')
dong$clickElement()
Sys.sleep(1)

danjis <- chrome$findElements('class','jqgrow')

for(i in 1:length(danjis))
  if(danjis[[i]]$getElementText() == '아이파크삼성동')
    danjis[[i]]$clickElement()

danjiinfo <- chrome$findElement('xpath',
                                '//*[@id="ui-id-3"]')

danjiinfo$clickElement()

res <- chrome$getPageSource()[[1]]
html <- read_html(res)

chrome$close()








