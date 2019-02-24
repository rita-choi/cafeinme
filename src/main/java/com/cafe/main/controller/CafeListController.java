package com.cafe.main.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafe.main.commons.paging.PageMaker;
import com.cafe.main.commons.paging.SearchCriteria;
import com.cafe.main.commons.utils.UploadFileUtils;
import com.cafe.main.domain.CafeListVO;
import com.cafe.main.domain.ReviewVO;
import com.cafe.main.domain.UserVO;
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
	
    @Resource(name = "uploadPath")
    private String uploadPath;
	
    // 카페 등록 페이지 redirect
    @RequestMapping(value = "/write", method = RequestMethod.GET)
    public String writeGET() throws Exception {

        return "cafe/write";

    }
    
    // 카페글 등록 처리
    @RequestMapping(value = "/write", method = RequestMethod.POST)
    public String writePOST(@ModelAttribute("vo") CafeListVO vo,
                            RedirectAttributes redirectAttributes) throws Exception {

        cafelistService.createCafeList(vo);
        redirectAttributes.addFlashAttribute("msg", "INSERTED");

        return "redirect:/cafe/list";

    }
    
    // 카페 상세 조회
    @RequestMapping(value = "/read", method = RequestMethod.GET)
    public String read(@RequestParam("cno") int cno,
                       @ModelAttribute("searchCriteria") SearchCriteria searchCriteria, Model model,  HttpSession session) throws Exception {

        model.addAttribute("cafelist", cafelistService.readCafeList(cno, session));

        return "cafe/read";

    }
    
    // 카페 수정
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modifySearchGET(@RequestParam("cno") int cno, Model model,
			@ModelAttribute("searchCriteria") SearchCriteria searchCriteria,  HttpSession session) throws Exception {

		model.addAttribute("cafelist", cafelistService.readCafeList(cno, session));

		return "cafe/modify";

	}
    
    // 카페 수정
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
    
    // 카페 삭제
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
    
    // 카페 목록 + 페이징 + 검색
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(@ModelAttribute("searchCriteria") SearchCriteria searchCriteria, Model model) throws Exception {

 
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(searchCriteria);
		pageMaker.setTotalCount(cafelistService.countSearchedLists(searchCriteria));

		model.addAttribute("cafelists", cafelistService.cafeListSearch(searchCriteria));
		model.addAttribute("pageMaker", pageMaker);

		return "cafe/list";
    }
    
	// 평점 조회

	@RequestMapping(value = "/score/{cno}", method = RequestMethod.GET)
	public ResponseEntity<Integer> score(@PathVariable("cno") int cno) {

		ResponseEntity<Integer> entity = null;

		try {

		
		 entity = new ResponseEntity<>(cafelistService.countScores(cno), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	 // 회원 프로필 이미지 수정처리
    @RequestMapping(value = "/modify/image", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public String cafeImgModify(int cno,
                                MultipartFile file,
                                RedirectAttributes redirectAttributes) throws Exception {
        if (file == null) {
            redirectAttributes.addFlashAttribute("msg", "FAIL");
            return "redirect:/cafe/read";
        }
        
        logger.info("========================================= FILE UPLOAD =========================================");
        logger.info("ORIGINAL FILE NAME : " + file.getOriginalFilename());
        logger.info("FILE SIZE : " + file.getSize());
        logger.info("CONTENT TYPE : " + file.getContentType());
        logger.info("===============================================================================================");
       
        String uploadFile = UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes());
        
        logger.info("=======================uploadFile=======================" + uploadFile + "======================");
        String front = uploadFile.substring(0, 12);
        String end = uploadFile.substring(14);
        String cimage = front + end;
        cafelistService.modifyCimage(cno, cimage);
        CafeListVO cafelistVO = new CafeListVO();
        cafelistVO.setCimage(cimage);
       
        redirectAttributes.addFlashAttribute("msg", "SUCCESS");
        return "redirect:/cafe/read";
    }

}

