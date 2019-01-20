package com.cafe.main.persistence;

import java.util.List;

import com.cafe.main.commons.paging.Criteria;
import com.cafe.main.domain.ReviewVO;

public interface ReviewDAO {

	List<ReviewVO> list(int cno) throws Exception;

	void create(ReviewVO reviewVO) throws Exception;

	void update(ReviewVO reviewVO) throws Exception;

	void delete(int rno) throws Exception;

	// 페이징 처리
	List<ReviewVO> listPaging(int cno, Criteria criteria) throws Exception;

	int countReview(int cno) throws Exception;

	// 댓글 게시글 번호 조회 > 댓글이 삭제될 때마다
	int getCafeNo(int rno) throws Exception;
	
	 // 회원이 작성한 댓글 목록
    public List<ReviewVO> userReviews(String uid) throws Exception;
}
