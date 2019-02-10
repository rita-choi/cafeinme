package com.cafe.main.persistence;

import java.util.List;

import com.cafe.main.commons.paging.Criteria;
import com.cafe.main.domain.ReviewVO;

public interface ReviewDAO {

	// 리뷰 전체 목록 조회
	List<ReviewVO> list(int cno) throws Exception;

	// 리뷰 등록
	void create(ReviewVO reviewVO) throws Exception;

	// 리뷰 수정
	void update(ReviewVO reviewVO) throws Exception;

	// 리뷰 삭제
	void delete(int rno) throws Exception;
	
	//전체 리뷰 삭제 
	void deleteAll(int cno) throws Exception;

	// 페이징 처리
	List<ReviewVO> listPaging(int cno, Criteria criteria) throws Exception;

	// 총 리뷰 갯수 
	int countReview(int cno) throws Exception;

	// 댓글 게시글 번호 조회 > 댓글이 삭제될 때마다
	int getCafeNo(int rno) throws Exception;
	
	 // 회원이 작성한 댓글 목록
    public List<ReviewVO> userReviews(String uid) throws Exception;
}
