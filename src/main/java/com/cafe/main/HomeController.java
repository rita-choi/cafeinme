package com.cafe.main;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafe.main.commons.paging.PageMaker;
import com.cafe.main.commons.paging.SearchCriteria;
import com.cafe.main.service.CafeListService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Inject
	private CafeListService cafelistService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String list(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria, Model model) throws Exception{
		logger.info("카페와 나 메인 페이지");
		
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCriteria(searchCriteria);
			pageMaker.setTotalCount(cafelistService.countSearchedLists(searchCriteria));

			model.addAttribute("cafelists", cafelistService.cafeListSearch(searchCriteria));
			model.addAttribute("pageMaker", pageMaker);

			return "home";
	    }
	    
	
	
}
