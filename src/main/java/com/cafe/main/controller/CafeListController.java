package com.cafe.main.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafe.main.commons.paging.PageMaker;
import com.cafe.main.commons.paging.SearchCriteria;
import com.cafe.main.domain.CafeListVO;
import com.cafe.main.service.CafeListService;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/cafe")
public class CafeListController {

	private static final Logger logger = LoggerFactory.getLogger(CafeListController.class);

	@Inject
	private CafeListService cafelistService;
	
    // 카페글 입력 페이지
    @RequestMapping(value = "/write", method = RequestMethod.GET)
    public String writeGET() throws Exception {

        return "cafe/write";

    }
    
    // 카페글 입력 페이지
    @RequestMapping(value = "/maps", method = RequestMethod.GET)
    public String mapsGET() throws Exception {

        return "cafe/maps";

    }
    
    // 카페글 입력 처리
    @RequestMapping(value = "/write", method = RequestMethod.POST)
    public String writePOST(@ModelAttribute("vo") CafeListVO vo,
                            RedirectAttributes redirectAttributes) throws Exception {

        cafelistService.createCafeList(vo);
        redirectAttributes.addFlashAttribute("msg", "INSERTED");

        return "redirect:/cafe/list";

    }
    
    // 카페글 조회
    @RequestMapping(value = "/read", method = RequestMethod.GET)
    public String read(@RequestParam("cno") int cno,
                       @ModelAttribute("searchCriteria") SearchCriteria searchCriteria, Model model,  HttpSession session) throws Exception {

        model.addAttribute("cafelist", cafelistService.readCafeList(cno, session));

        return "cafe/read";

    }
    
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifySearchGET(@RequestParam("cno") int cno, Model model,
			@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,  HttpSession session) throws Exception {

		logger.info("Search modifyGET() called...");
		model.addAttribute("cafelist", cafelistService.readCafeList(cno, session));

		return "cafe/modify";

	}
    
    // 카페글 수정 처리
    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String modifyPOST(@ModelAttribute("vo") CafeListVO vo,
                             @ModelAttribute("searchCriteria") SearchCriteria searchCriteria,
                             RedirectAttributes redirectAttributes) throws Exception {

        cafelistService.updateCafeList(vo);
        redirectAttributes.addFlashAttribute("msg", "UPDATED");
        redirectAttributes.addAttribute("cno", vo.getCno());
        redirectAttributes.addAttribute("page", searchCriteria.getPage());
        redirectAttributes.addAttribute("perPageNum", searchCriteria.getPerPageNum());
        redirectAttributes.addAttribute("searchType", searchCriteria.getSearchType());
        redirectAttributes.addAttribute("keyword", searchCriteria.getKeyword());
        return "redirect:/cafe/read";

    }
    
    // 카페글 삭제
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String remove(@RequestParam("cno") int cno,
                         @ModelAttribute("searchCriteria") SearchCriteria searchCriteria,
                         RedirectAttributes redirectAttributes) throws Exception {

        cafelistService.deleteCafeList(cno);
        redirectAttributes.addFlashAttribute("msg", "DELETED");
        redirectAttributes.addAttribute("page", searchCriteria.getPage());
        redirectAttributes.addAttribute("perPageNum", searchCriteria.getPerPageNum());
        redirectAttributes.addAttribute("searchType", searchCriteria.getSearchType());
        redirectAttributes.addAttribute("keyword", searchCriteria.getKeyword());

        return "redirect:/cafe/list";

    }
    
    // 카페글 목록 + 페이징 + 검색
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria, Model model) throws Exception {

        logger.info("Search list() called...");

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(searchCriteria);
		pageMaker.setTotalCount(cafelistService.countSearchedLists(searchCriteria));

		model.addAttribute("cafelists", cafelistService.cafeListSearch(searchCriteria));
		model.addAttribute("pageMaker", pageMaker);

		return "cafe/list";
    }
    
    // 첨부파일 조회 추가 필요
    
}

