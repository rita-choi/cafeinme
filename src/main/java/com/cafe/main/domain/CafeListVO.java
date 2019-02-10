package com.cafe.main.domain;

import java.util.Date;

public class CafeListVO {

	private int cno; // 카페 번호
	private String cafename; // 카페 이름
	private String content; // 카페 설명
	private String location; // 카페 위치
	private String writer; // 작성자
	private Date regdate; // 등록일
	private Date updatedate; // 수정일
	private int viewcnt; // 조회수
	private int mymenu; // 나만의 메뉴 설정 가능 여부
	private int reviewcnt; // 리뷰 총 개수
	private Integer scorecnt; // 총 리뷰 평점
	// 댓글 작성자 정보
	private UserVO userVO;
    // 게시글 첨부파일
    private String[] files;
    // 게시글 첨부파일 갯수
    private int attachcnt;
    // 카페 대표 이미지
    private String cimage;

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



	public Integer getScorecnt() {
		return scorecnt;
	}

	public void setScorecnt(Integer scorecnt) {
		this.scorecnt = scorecnt;
	}

	public UserVO getUserVO() {
		return userVO;
	}

	public void setUserVO(UserVO userVO) {
		this.userVO = userVO;
	}
	

    public String[] getFiles() {
        return files;
    }

    public void setFiles(String[] files) {
        this.files = files;
		setAttachcnt(files.length);
		// CafeListVO가 스스로 첨부파일 개수의 상태를 가질 수 있게 설정 : 외부에서 호출해주지 않아도 됨
    }

    public int getAttachcnt() {
        return attachcnt;
    }

    public void setAttachcnt(int attachcnt) {
        this.attachcnt = attachcnt;
    }

	public String getCimage() {
		return cimage;
	}

	public void setCimage(String cimage) {
		this.cimage = cimage;
	}
    
    

}
