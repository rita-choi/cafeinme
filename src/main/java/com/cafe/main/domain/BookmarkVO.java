package com.cafe.main.domain;

import java.util.Date;

public class BookmarkVO {

    private int bmno;
    private int cno;
    private String uid;
    private Date regdate;
    private CafeListVO cafelistVO;



    public int getBmno() {
		return bmno;
	}

	public void setBmno(int bmno) {
		this.bmno = bmno;
	}

	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}

	public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public Date getRegdate() {
        return regdate;
    }

    public void setRegdate(Date regdate) {
        this.regdate = regdate;
    }

	public CafeListVO getCafelistVO() {
		return cafelistVO;
	}

	public void setCafelistVO(CafeListVO cafelistVO) {
		this.cafelistVO = cafelistVO;
	}


}