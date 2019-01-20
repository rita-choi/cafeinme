package com.cafe.main.service;

import com.cafe.main.domain.ReviewLikeVO;

public interface LikeService {

    // 댓글 추천 하기
    public void createReviewLike(ReviewLikeVO reviewLikeVO) throws Exception;

    // 댓글 추천 취소
    public void deleteReviewLike(ReviewLikeVO reviewLikeVO) throws Exception;

    // 댓글 추천 갯수
    public int countReviewLikes(Integer rno) throws Exception;

    // 댓글 추천 여부
    public boolean checkReviewLike(Integer rno, String uid) throws Exception;
	
}
