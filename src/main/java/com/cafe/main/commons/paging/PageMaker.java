package com.cafe.main.commons.paging;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;


public class PageMaker {
	private int totalCount; // 전체 게시글의 갯수
	private int startPage; // 시작 페이지 번호
	private int endPage; // 끝 페이지 번호
	private boolean prev; // 이전 링크
	private boolean next; // 다음 링크

	private int displayPageNum = 10; // 페이지 번호의 갯수

	private Criteria criteria;

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public Criteria getCriteria() {
		return criteria;
	}

	public void setCriteria(Criteria criteria) {
		this.criteria = criteria;

	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}

	// 게시글의 전체 갯수가 설정되는 시점에 메서드가 호출되어 필요한 데이터 계산
	private void calcData() {

		// 끝 페이지 번호 = Math.ceil( 현재페이지 / 페이지번호의 갯수) * 페이지번호의 갯수
		endPage = (int) (Math.ceil(criteria.getPage() / (double) displayPageNum) * displayPageNum);

		System.out.println("endPage>>>" + endPage);

		// 시작 페이지 번호 = (끝 페이지 번호 - 페이지 번호의 갯수) + 1
		startPage = (endPage - displayPageNum) + 1;

		System.out.println("StartPage>>>" + startPage);

		// 끝 페이지 번호 = Mail.ceil (전체 게시글 갯수 / 페이지 당 출력할 게시글의 갯수)
		int tempEndPage = (int) (Math.ceil(totalCount / (double) criteria.getPerPageNum()));

		System.out.println("tempEndPage>>>" + tempEndPage);

		// 보정된 결과 확인 후, 보정된 결과 값을 저장
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}

		// 시작 페이지 번호가 1인지 아닌지 검사
		prev = startPage == 1 ? false : true;

		System.out.println("prev>>>" + prev);

		// 다음 링크 = 끝 페이지 * 페이지당 출력할 게시글의 갯수 >= 전체 게시글의 갯수 ? false : true
		next = endPage * criteria.getPerPageNum() >= totalCount ? false : true;

		System.out.println("next>>>" + next);

	}

	// URI 자동 생성 처리
	public String makeQuery(int page) {
		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("perPageNum", criteria.getPerPageNum()).build();
		return uriComponents.toUriString();
	}

	// 검색

	public String makeSearch(int page) {

		UriComponents uriComponents = UriComponentsBuilder.newInstance().queryParam("page", page)
				.queryParam("perPageNum", criteria.getPerPageNum())
				.queryParam("searchType", ((SearchCriteria) criteria).getSearchType())
				.queryParam("keyword", encoding(((SearchCriteria) criteria).getKeyword())).build();
		
		System.out.println("==============" + uriComponents.toUriString());
		
		return uriComponents.toUriString();
	}

	private String encoding(String keyword) {
		if (keyword == null || keyword.trim().length() == 0) {
			return "";
		}

		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return "";
		}

	}
}
