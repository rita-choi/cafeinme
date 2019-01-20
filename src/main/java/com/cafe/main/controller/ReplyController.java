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

import com.cafe.main.commons.paging.Criteria;
import com.cafe.main.commons.paging.PageMaker;
import com.cafe.main.domain.ReviewVO;
import com.cafe.main.service.ReviewService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/reviews")
public class ReplyController {

	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);

	private final ReviewService replyService;

	@Inject
	public ReplyController(ReviewService replyService) {
		this.replyService = replyService;
	}

	/**
	 * Simply selects the home view to render by returning its name.
	 * 
	 * @throws Exception
	 */

	// 댓글 등록 처리 메소드
	@RequestMapping(value = "", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_UTF8_VALUE, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<String> register(@RequestBody ReviewVO replyVO) {

		ResponseEntity<String> entity = null;

		try {
			replyService.create(replyVO);
			entity = new ResponseEntity<>("regSuccess", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	// 댓글 목록

	@RequestMapping(value = "/all/{cno}", method = RequestMethod.GET)
	public ResponseEntity<List<ReviewVO>> list(@PathVariable("cno") int cno) {

		ResponseEntity<List<ReviewVO>> entity = null;

		try {

			entity = new ResponseEntity<>(replyService.list(cno), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	// 댓글 수정

	@RequestMapping(value = "/{rno}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> update(@PathVariable("rno") int rno, @RequestBody ReviewVO reviewVO) {

		ResponseEntity<String> entity = null;

		try {
			reviewVO.setRno(rno);
			replyService.update(reviewVO);
			entity = new ResponseEntity<>("modSuccess", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	@RequestMapping(value = "/{rno}", method = RequestMethod.DELETE)
	public ResponseEntity<String> delete(@PathVariable("rno") int rno) {

		ResponseEntity<String> entity = null;

		try {
			replyService.delete(rno);
			entity = new ResponseEntity<>("delSuccess", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	

	@RequestMapping(value = "/{cno}/{page}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPaging(@PathVariable("cno") int cno, @PathVariable("page") int page) {

		ResponseEntity<Map<String, Object>> entity = null;

		try {
			Criteria criteria = new Criteria();
			criteria.setPage(page);
			
			List<ReviewVO> replies = replyService.getReviewsPaging(cno, criteria);
			int repliesCount = replyService.countReviews(cno);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCriteria(criteria);
			pageMaker.setTotalCount(repliesCount);
			
			Map<String, Object> map = new HashMap<>();
			map.put("replies", replies);
			map.put("pageMaker", pageMaker);
			
			
			entity = new ResponseEntity<>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	
    
}

