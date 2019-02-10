package com.cafe.main.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cafe.main.commons.paging.Criteria;
import com.cafe.main.domain.ReviewVO;

public interface ReviewService {
	
	// 리뷰 전체 조회
	List<ReviewVO> list(int cno) throws Exception;
	
	// 리뷰 등록
	void create(ReviewVO reviewVO) throws Exception;
	
	// 리뷰 수정
	void update(ReviewVO reviewVO) throws Exception;
	
	// 리뷰 삭제
	void delete(int rno) throws Exception;
	
	// 페이징 처리
	List<ReviewVO> getReviewsPaging(int cno, Criteria criteria) throws Exception;
	
	// 총 리뷰 갯수
	int countReviews(int cno) throws Exception;
	
	 // 회원이 작성한 댓글 목록
    public List<ReviewVO> userReviews(String uid) throws Exception;
    
}
