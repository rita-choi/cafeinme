package com.cafe.main.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.cafe.main.domain.ReviewLikeVO;
import com.cafe.main.persistence.LikeDAO;

@Service
public class LikeServiceImpl implements LikeService{

    @Inject
    private LikeDAO likeDAO;


	@Override
	public void createReviewLike(ReviewLikeVO reviewLikeVO) throws Exception {
		// TODO Auto-generated method stub
		likeDAO.createReviewLike(reviewLikeVO);
	}

	@Override
	public void deleteReviewLike(ReviewLikeVO reviewLikeVO) throws Exception {
		// TODO Auto-generated method stub
		likeDAO.deleteReviewLike(reviewLikeVO);
	}

	@Override
	public int countReviewLikes(Integer rno) throws Exception {
		// TODO Auto-generated method stub
		return likeDAO.countReviewLikes(rno);
	}

	@Override
	public boolean checkReviewLike(Integer rno, String uid) throws Exception {
		// TODO Auto-generated method stub
		return likeDAO.checkReviewLike(rno, uid);
	}
	


}
