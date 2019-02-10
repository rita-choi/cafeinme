package com.cafe.main.domain;

import java.util.Date;

public class ReviewVO {
	private int rno; // 리뷰 번호
	private int cno; // 카페 번호
	private String reviewtxt; // 리뷰 내용
	private String reviewer; // 리뷰아
	private Date regdate; // 리뷰 등록일
	private Date updatedate; // 리뷰 수정일
	private int score; // 리뷰 평점 
	  // 리뷰 작성자 정보
    private UserVO userVO;
      // 카페  정보
    private CafeListVO cafelistVO;
    // 댓글 추천수
    private Integer rlnocount;
    
    

	public Integer getRlnocount() {
		return rlnocount;
	}

	public void setRlnocount(Integer rlnocount) {
		this.rlnocount = rlnocount;
	}

	public UserVO getUserVO() {
		return userVO;
	}

	public void setUserVO(UserVO userVO) {
		this.userVO = userVO;
	}

	public CafeListVO getCafelistVO() {
		return cafelistVO;
	}

	public void setCafelistVO(CafeListVO cafelistVO) {
		this.cafelistVO = cafelistVO;
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}


	public String getReviewtxt() {
		return reviewtxt;
	}

	public void setReviewtxt(String reviewtxt) {
		this.reviewtxt = reviewtxt;
	}

	public String getReviewer() {
		return reviewer;
	}

	public void setReviewer(String reviewer) {
		this.reviewer = reviewer;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Date getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	
}
