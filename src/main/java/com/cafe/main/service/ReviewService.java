package com.cafe.main.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cafe.main.commons.paging.Criteria;
import com.cafe.main.domain.ReviewVO;

public interface ReviewService {
	List<ReviewVO> list(int cno) throws Exception;
	void create(ReviewVO reviewVO) throws Exception;
	void update(ReviewVO reviewVO) throws Exception;
	void delete(int rno) throws Exception;
	
	//페이징
	List<ReviewVO> getReviewsPaging(int cno, Criteria criteria) throws Exception;
	int countReviews(int cno) throws Exception;
	
	 // 회원이 작성한 댓글 목록
    public List<ReviewVO> userReviews(String uid) throws Exception;
}
