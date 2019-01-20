package com.cafe.main.commons.paging;

public class Criteria {

	private int page; // 현재 번호
	private int perPageNum; // 페이지 당 출력되는 게시글의 갯수

	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	} // 기본 생성자, 현재 페이지를 1 , 페이지 당 출력할 게시글의 갯수 10으로 기본 세팅

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		
		if(page <= 0) {
			this.page =1;
			return;
		} // 음수가 들어오지 않도록 세팅
		
		this.page = page;
	}
	

	public int getPerPageNum() {
		return this.perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		
		if(perPageNum <= 0 || perPageNum >100) {
			this.perPageNum = 10;
			return;
		} // 음수가 들어오지 않도록 세팅
		
		this.perPageNum = perPageNum;
	}
	
	public int getPageStart() {
		return ( this.page - 1 ) * perPageNum;
 	} // LIMIT 구문에서 현재 페이지 게시글의 시작 위치를 지정할 때 사용 
	// 예를 들어, 10개씩 출력할 경우 3Page는 LIMIT 20, 10과 같은 형태가 되어야 한다
	// 현재 페이지의 시작 게시글 번호 = (현재 페이지 번호 -1) * 페이지 당 출력할 게시글의 갯수
	
	
	
}


