package com.cafe.main.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe.main.commons.paging.Criteria;
import com.cafe.main.domain.ReviewVO;
import com.cafe.main.persistence.CafeListDAO;
import com.cafe.main.persistence.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService {

	private final ReviewDAO reviewDAO;
	private final CafeListDAO cafelistDAO;

	@Inject
	public ReviewServiceImpl(ReviewDAO reviewDAO, CafeListDAO cafelistDAO) {
		this.reviewDAO = reviewDAO;
		this.cafelistDAO = cafelistDAO;

	}

	@Override
	public List<ReviewVO> list(int cno) throws Exception {
		// TODO Auto-generated method stub
		return reviewDAO.list(cno);
	}

	// 댓글 등록
	@Transactional // 트랜잭션 처리
	@Override
	public void create(ReviewVO reviewVO) throws Exception {
		// TODO Auto-generated method stub
		reviewDAO.create(reviewVO);
		cafelistDAO.updateReplyCnt(reviewVO.getCno(), 1);
		
	}

	@Override
	public void update(ReviewVO replyVO) throws Exception {
		// TODO Auto-generated method stub
		reviewDAO.update(replyVO);
	}

	// 댓글 삭제

	@Override
	@Transactional // 트랜잭션 처리
	public void delete(int rno) throws Exception {
		// TODO Auto-generated method stub

		int cno = reviewDAO.getCafeNo(rno);
		reviewDAO.delete(rno);
		cafelistDAO.updateReplyCnt(cno, -1); // 댓글 감소

	}

	@Override
	public List<ReviewVO> getReviewsPaging(int cno, Criteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return reviewDAO.listPaging(cno, criteria);
	}

	@Override
	public int countReviews(int cno) throws Exception {
		// TODO Auto-generated method stub
		return reviewDAO.countReview(cno);
	}

	@Override
	public List<ReviewVO> userReviews(String uid) throws Exception {
		// TODO Auto-generated method stub
		return reviewDAO.userReviews(uid);
	}
}
