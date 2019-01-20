
-- 리뷰 추천 테이블
CREATE TABLE review_likes (
  rlno     INT         NOT NULL AUTO_INCREMENT,
  rno      INT         NOT NULL,
  uid      VARCHAR(50) NOT NULL,
  likedate TIMESTAMP   NOT NULL DEFAULT NOW(),
  PRIMARY KEY (rlno)
)DEFAULT CHARSET=utf8;

-- cno 추가
 ALTER TABLE review_likes ADD COLUMN cno INT NOT NULL;

-- 외래키 설정

ALTER TABLE review_likes ADD CONSTRAINT fk_review_cafe_likes
FOREIGN KEY (cno) REFERENCES cafe_list (cno);

-- 외래키 설정
ALTER TABLE review_likes ADD CONSTRAINT fk_reply_likes
FOREIGN KEY (rno) REFERENCES cafe_review (rno);