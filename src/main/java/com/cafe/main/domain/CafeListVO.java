package com.cafe.main.domain;

import java.util.Date;

public class CafeListVO {

	private int cno;
	private String cafename;
	private String content;
	private String location;
	private String writer;
	private Date regdate;
	private Date updatedate;
	private int viewcnt;
	private int mymenu; // 나만의 메뉴 설정 가능 여부
	private int reviewcnt;
	private int scorecnt; // 총 리뷰 평점
	// 댓글 작성자 정보
	private UserVO userVO;

	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}

	public String getCafename() {
		return cafename;
	}

	public void setCafename(String cafename) {
		this.cafename = cafename;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
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

	public int getViewcnt() {
		return viewcnt;
	}

	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}

	public int getMymenu() {
		return mymenu;
	}

	public void setMymenu(int mymenu) {
		this.mymenu = mymenu;
	}

	public int getReviewcnt() {
		return reviewcnt;
	}

	public void setReviewcnt(int reviewcnt) {
		this.reviewcnt = reviewcnt;
	}

	public int getScorecnt() {
		return scorecnt;
	}

	public void setScorecnt(int scorecnt) {
		this.scorecnt = scorecnt;
	}

	public UserVO getUserVO() {
		return userVO;
	}

	public void setUserVO(UserVO userVO) {
		this.userVO = userVO;
	}

}
