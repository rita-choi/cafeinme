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
		return reviewDAO.list(cno);
	}

	// 리뷰 등록
	@Transactional // 트랜잭션 처리
	@Override
	public void create(ReviewVO reviewVO) throws Exception {
		reviewDAO.create(reviewVO);
		cafelistDAO.updateReviewCnt(reviewVO.getCno(), 1);
		cafelistDAO.updateScoreCnt(reviewVO.getCno()); // 평점 처리
		
	}

	@Override
	public void update(ReviewVO replyVO) throws Exception {
		reviewDAO.update(replyVO);
	}

	// 리뷰 삭제

	@Override
	@Transactional // 트랜잭션 처리
	public void delete(int rno) throws Exception {
		// TODO Auto-generated method stub

		int cno = reviewDAO.getCafeNo(rno);
		reviewDAO.delete(rno);
		cafelistDAO.updateReviewCnt(cno, -1); // 리뷰 감소
		cafelistDAO.updateScoreCnt(cno); // 평점 처리

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
