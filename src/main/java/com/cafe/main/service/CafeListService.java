package com.cafe.main.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.cafe.main.commons.paging.Criteria;
import com.cafe.main.commons.paging.SearchCriteria;
import com.cafe.main.domain.CafeListVO;

public interface CafeListService {

	// 카페 등록
	public void createCafeList(CafeListVO vo) throws Exception;

	// 카페글 상세
	public CafeListVO readCafeList(int cno, HttpSession session) throws Exception;

	// 카페글 수정
	public void updateCafeList(CafeListVO vo) throws Exception;

	// 카페글 삭제
	public void deleteCafeList(int cno) throws Exception;
	
	// 페이징 처리 목록 + 검색 기능
	public List<CafeListVO> cafeListSearch(SearchCriteria searchCriteria) throws Exception;

	// 전체 게시글 갯수
	public int countLists(Criteria criteria) throws Exception;

	// 검색 게시글 갯수
	public int countSearchedLists(SearchCriteria searchCriteria) throws Exception;

    // 회원이 작성한 카페글 목록 
    public List<CafeListVO> userCafeList(String uid) throws Exception;
    
    public Integer countScores(int cno) throws Exception;
    
    // 카페 대표 이미지 수정
    public void modifyCimage(int cno, String cimage) throws Exception;
    
    // 평점 순 게시물
    public List<CafeListVO> listRate() throws Exception;

}
