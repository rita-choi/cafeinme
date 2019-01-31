-- 첨부파일 테이블
CREATE TABLE cafe_attach (
  fullname VARCHAR(150) NOT NULL,
  cno INT NOT NULL,
  regdate TIMESTAMP DEFAULT NOW(),
  PRIMARY KEY (fullname)
);

-- 외래키
ALTER TABLE cafe_attach ADD CONSTRAINT fk_cafe_attach
FOREIGN KEY (cno) REFERENCES cafe_list (cno);