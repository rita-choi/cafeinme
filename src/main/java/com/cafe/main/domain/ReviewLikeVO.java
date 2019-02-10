package com.cafe.main.domain;

public class ReviewLikeVO {

	private Integer rno; // 리뷰 번호
	private Integer rlno; // 추천 번호
	private Integer cno; // 카페 번호
	private String uid; // 아이디
	

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public Integer getCno() {
		return cno;
	}

	public void setCno(Integer cno) {
		this.cno = cno;
	}

	public Integer getRlno() {
		return rlno;
	}

	public void setRlno(Integer rlno) {
		this.rlno = rlno;
	}

	public Integer getRno() {
		return rno;
	}

	public void setRno(Integer rno) {
		this.rno = rno;
	}


}
