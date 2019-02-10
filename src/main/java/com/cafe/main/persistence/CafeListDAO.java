package com.cafe.main.persistence;

import java.util.List;

import com.cafe.main.commons.paging.Criteria;
import com.cafe.main.commons.paging.SearchCriteria;
import com.cafe.main.domain.CafeListVO;

public interface CafeListDAO {

	// 카페 등록
	void createCafeList(CafeListVO vo) throws Exception;
	
	// 카페글 상세
	CafeListVO readCafeList(int cno) throws Exception;
	
	// 카페글 수정
	void updateCafeList(CafeListVO vo) throws Exception;
	
	// 카페 목록
	List<CafeListVO> listAll() throws Exception;
	
	// 카페글 삭제
	void deleteCafeList(int cno) throws Exception;
	
	// 페이징 처리
	List<CafeListVO> listPaging(int page) throws Exception;
	
	// 페이징 처리 목록 + 검색 기능
	List<CafeListVO> cafeListSearch(SearchCriteria searchCriteria) throws Exception;
	
	// 전체 게시글 갯수
	int countLists(Criteria criteria) throws Exception;
	
	// 전체 게시글 갯수 + 검색된 게시글의 수
	int countSearchedLists(SearchCriteria searchCriteria) throws Exception;
	
	//댓글 갯수 갱신
	void updateReviewCnt(int cno, int amount) throws Exception;
	
	//평점 갱신
	void updateScoreCnt(int cno) throws Exception;
	
	//게시글 조회수
	void updateViewCnt(int cno) throws Exception;
	
	// 회원이 작성한 카페글 목록
    public List<CafeListVO> userCafeList(String uid) throws Exception;
    
    //평점 불러옴
    Integer countScores(int cno) throws Exception;
    
    //카페 대표 이미지 수정
	public void updateCimage(int cno, String cimage) throws Exception;
    
	
}
