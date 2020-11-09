#외부데이터 다루기
#데이터베이스 MySQL/MariaDB/Oracle을 이용해서 테이블에 저장된 데이터를 R에서 활용
install.packages('RMySQL')
library(RMySQL)
?RMySQL
# mysql/mariadb서버 접속
mariadb <- dbConnect(MySQL(),
                      user='bigdata',password='bigdata2020',
                      dbname='bigdata',host='192.168.56.1')
    
#dbDisconnect(mariadb)   :   mysql/mariadb 서버 접속 해제

mariadb <- dbConnect(MySQL(),
                     user='bigdata',password='bigdata2020',
                     dbname='bigdata',host='192.168.56.1')
# db상의 테이블 조회
dbListTables(mariadb)

# 질의 생성 및 실행후 결과 집합 resultset 저장
sql <- 'select * from EMPLOYEES'
result <- dbSendQuery(mariadb,sql)
result

# 결과집합에서 한행씩 추출해서 데이터 프레임에 저장
emps <- fetch(result)
head (emps,10)
# 결과집합은 메모리에서 해제
dbClearResult(result)
dbDisconnect(mariadb)

# ex) Titanic data 읽어오기

mariadb <- dbConnect(MySQL(),
                     user='bigdata',password='bigdata2020',
                     dbname='bigdata',host='192.168.56.1')
sql_1 <- 'select pclass, name, sex, age, survived, cabin from titanic'
result_1 <- dbSendQuery(mariadb,sql_1)
cstm <- fetch(result_1)
dbDisconnect(mariadb)
head(cstm)

# 교통사고 통계 테이블에서 발생년월시 주야 사망자수 발생지시도 등을 선택해서 car_accident 데이터 프레임에 저장


mariadb <- dbConnect(MySQL(),
                     user='bigdata',password='bigdata2020',
                     dbname='bigdata',host='192.168.56.1')

# 한글처리를 위한 설정 
dbSendQuery(mariadb,'set names utf8;')
dbSendQuery(mariadb,'set character set utf8;')
dbSendQuery(mariadb,'set character_set_connection=utf8;')

sql_2 <- 'select 발생년월일시, 주야, 사망자수, 발생지시도 from car_accident_2016'
sql_2 <- iconv(sql_2,to='UTF-8')  # 한글이 포함된 질의문은 utf8로 변환
result_2 <- dbSendQuery(mariadb, sql_2)

car_accident <- fetch(result_2)
names(car_accident) <- iconv(names(car_accident), from ='UTF-8')
car_accident[[2]] <- iconv(car_accident[[2]], from = 'UTF-8')
car_accident[[4]] <- iconv(car_accident[[4]], from = 'UTF-8')
head(car_accident)

dbClearResult(result_2)
dbDisconnect(mariadb)




