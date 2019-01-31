package com.cafe.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.cafe.main.commons.paging.Criteria;
import com.cafe.main.commons.paging.PageMaker;
import com.cafe.main.domain.ReviewLikeVO;
import com.cafe.main.domain.ReviewVO;
import com.cafe.main.service.LikeService;
import com.cafe.main.service.ReviewService;

/**
 * Handles requests for the application home page.
 */
@RestController
@RequestMapping("/likes")
public class LikeController {

	private static final Logger logger = LoggerFactory.getLogger(LikeController.class);

	   @Inject
	    private LikeService likeService;



	    // 댓글 추천 하기
	    @RequestMapping(value = "/create/{cno}/{uid}/{rno}", method = RequestMethod.POST)
	    public ResponseEntity<String> createReviewLike(@PathVariable("cno") Integer cno,
	                                                  @PathVariable("rno") Integer rno,
	                                                  @PathVariable("uid") String uid) {
	        ResponseEntity<String> entity = null;
	        try {
	            ReviewLikeVO reviewLikeVO = new ReviewLikeVO();
	            reviewLikeVO.setCno(cno);
	            reviewLikeVO.setRno(rno);
	            reviewLikeVO.setUid(uid);
	            likeService.createReviewLike(reviewLikeVO);
	            entity = new ResponseEntity<>("REVIEW LIKE CREATED", HttpStatus.OK);
	        } catch (Exception e) {
	            entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);

	        }
	        return entity;
	    }

	    // 댓글 추천 취소
	    @RequestMapping(value = "/delete/{cno}/{uid}/{rno}", method = RequestMethod.DELETE)
	    public ResponseEntity<String> deleteReviewLike(@PathVariable("cno") Integer cno,
	                                                  @PathVariable("rno") Integer rno,
	                                                  @PathVariable("uid") String uid) {

	        ResponseEntity<String> entity = null;
	        try {
	            ReviewLikeVO reviewLikeVO = new ReviewLikeVO();
	            reviewLikeVO.setCno(cno);
	            reviewLikeVO.setUid(uid);
	            reviewLikeVO.setRno(rno);
	            likeService.deleteReviewLike(reviewLikeVO);
	            entity = new ResponseEntity<>("REVIEW LIKE DELETED", HttpStatus.OK);
	        } catch (Exception e) {
	            entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
	        }
	        return entity;
	    }

	    // 댓글 추천 갯수
	    @RequestMapping(value = "/count/{cno}/{rno}", method = RequestMethod.GET)
	    public ResponseEntity<Map<String, Object>> countReviewLikes(@PathVariable("cno") Integer cno,
	                                                               @PathVariable("rno") Integer rno) {
	        ResponseEntity<Map<String, Object>> entity = null;
	        try {
	            int reviewLikeTotalCount = likeService.countReviewLikes(rno);
	            Map<String, Object> map = new HashMap<>();
	            map.put("reviewLikeTotalCount", reviewLikeTotalCount);
	            entity = new ResponseEntity<>(map, HttpStatus.OK);
	        } catch (Exception e) {
	            e.printStackTrace();
	            entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	        }
	        return entity;
	    }

	    // 댓글 추천 여부
	    @RequestMapping(value = "/check/{cno}/{uid}/{rno}", method = RequestMethod.GET)
	    public ResponseEntity<Map<String, Object>> checkReviewLike(@PathVariable("cno") Integer cno,
	                                                              @PathVariable("rno") Integer rno,
	                                                              @PathVariable("uid") String uid) {
	        ResponseEntity<Map<String, Object>> entity = null;
	        try {
	            boolean checkReviewLike = likeService.checkReviewLike(rno, uid);
	            Map<String, Object> map = new HashMap<>();
	            map.put("checkReviewLike", checkReviewLike);
	            entity = new ResponseEntity<>(map, HttpStatus.OK);
	        } catch (Exception e) {
	            entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	            
	        }
	        return entity;
	    }
	
    
}

