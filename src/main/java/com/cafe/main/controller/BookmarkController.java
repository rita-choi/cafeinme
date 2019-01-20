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
import com.cafe.main.domain.BookmarkVO;
import com.cafe.main.domain.ReviewLikeVO;
import com.cafe.main.domain.ReviewVO;
import com.cafe.main.service.BookmarkService;
import com.cafe.main.service.LikeService;
import com.cafe.main.service.ReviewService;

/**
 * Handles requests for the application home page.
 */
@RestController
@RequestMapping("/bookmark")
public class BookmarkController {

	private static final Logger logger = LoggerFactory.getLogger(BookmarkController.class);

	  @Inject
	    private BookmarkService bookmarkService;

	    // 북마크 등록
	    @RequestMapping(value = "/create", method = RequestMethod.POST)
	    public ResponseEntity<String> create(@RequestBody BookmarkVO bookMarkVO) {
	        ResponseEntity<String> entity = null;
	        try {
	            bookmarkService.create(bookMarkVO);
	            entity = new ResponseEntity<>("BOOKMARK INSERTED", HttpStatus.OK);
	        } catch (Exception e) {
	            entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
	        }
	        return entity;
	    }

	    // 북마크 확인
	    @RequestMapping(value = "/check/{cno}/{uid}", method = RequestMethod.GET)
	    public ResponseEntity<Map<String, Object>> checkBookMark(@PathVariable("cno") int cno,
	                                                @PathVariable("uid") String uid) {
	        ResponseEntity<Map<String, Object>> entity = null;
	        try {
	            boolean isBookmarkCheck = bookmarkService.checkBookmark(cno, uid);
	            Map<String, Object> map = new HashMap<>();
	            map.put("isBookmarkCheck", isBookmarkCheck);
	            entity = new ResponseEntity<>(map, HttpStatus.OK);
	        } catch (Exception e) {
	            e.printStackTrace();
	            entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	        }
	        return entity;
	    }

	    // 북마크 삭제
	    @RequestMapping(value = "/remove/{cno}/{uid}", method = RequestMethod.DELETE)
	    public ResponseEntity<String> remove(@PathVariable("cno") int cno,
	                                         @PathVariable("uid") String uid) {
	        ResponseEntity<String> entity = null;
	        try {
	            bookmarkService.remove(cno, uid);
	            entity = new ResponseEntity<>("BOOKMARK DELETED", HttpStatus.OK);
	        } catch (Exception e) {
	            entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
	        }
	        return entity;
	    }
}

