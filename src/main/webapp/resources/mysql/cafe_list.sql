-- 데이터 베이스 생성 (utf8)

CREATE DATABASE cafedb DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

-- 카페 목록 생성

CREATE TABLE cafe_list (
cno INT NOT NULL AUTO_INCREMENT,
cafename VARCHAR(200) NOT NULL,
content VARCHAR(1000) NOT NULL,
location VARCHAR(200) NOT NULL,
writer VARCHAR(50) NOT NULL,
regdate TIMESTAMP DEFAULT now(),
updatedate TIMESTAMP DEFAULT now(),
viewcnt INT DEFAULT 0,
mymenu INT DEFAULT 0 NOT NULL,
PRIMARY KEY (cno)
) DEFAULT CHARSET=utf8;

-- 리뷰 수, 리뷰 평점 컬럼 추가
ALTER TABLE cafe_list ADD COLUMN reviewcnt int DEFAULT 0;
ALTER TABLE cafe_list ADD COLUMN scorecnt int DEFAULT 0;
ALTER TABLE cafe_list ADD COLUMN attachcnt int DEFAULT 0;