
-- 북마크 테이블
CREATE TABLE cafe_bookmark (
  bmno    INT         NOT NULL AUTO_INCREMENT,
  cno     INT         NOT NULL,
  uid     VARCHAR(50) NOT NULL,
  regdate TIMESTAMP   NOT NULL DEFAULT NOW(),
  PRIMARY KEY (bmno)
);

-- 외래키 설정
ALTER TABLE cafe_bookmark ADD CONSTRAINT fk_cafe_bookmark
FOREIGN KEY (cno) REFERENCES cafe_list (cno);