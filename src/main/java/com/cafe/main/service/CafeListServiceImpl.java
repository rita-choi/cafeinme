package com.cafe.main.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.cafe.main.commons.paging.Criteria;
import com.cafe.main.commons.paging.SearchCriteria;
import com.cafe.main.domain.CafeListVO;
import com.cafe.main.persistence.BookmarkDAO;
import com.cafe.main.persistence.CafeListDAO;
import com.cafe.main.persistence.LikeDAO;
import com.cafe.main.persistence.ReviewDAO;
import com.cafe.main.persistence.UploadDAO;

@Service
public class CafeListServiceImpl implements CafeListService {


	@Inject
	private CafeListDAO cafelistDAO;

	@Inject
	private UploadDAO uploadDAO;

	@Inject
	private LikeDAO likeDAO;

	@Inject
	private ReviewDAO reviewDAO;

	@Inject
	private BookmarkDAO bookmarkDAO;

	
	// 카페글 입력 처리
	@Transactional
	@Override
	public void createCafeList(CafeListVO vo) throws Exception {
		
		// 첨부파일 처리는 추가 필요
		String[] files = vo.getFiles();

		if (files == null) {
			cafelistDAO.createCafeList(vo);
			return;
		}
		
		vo.setAttachcnt(files.length);
		cafelistDAO.createCafeList(vo);
		int cno = vo.getCno();
		
		// 첨부파일 입력처리
		for (String fileName : files) {
			uploadDAO.addAttach(fileName, cno);
		}
	}

	// 카페글 상세 조회 + 게시글 조회수 갱신
	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public CafeListVO readCafeList(int cno, HttpSession session) throws Exception {
		
		//열람 시각
		long updateTime = 0;
		if(session.getAttribute("updateTime" + cno) != null) {
			updateTime = (long) session.getAttribute("updateTime" + cno);
		}
		
		//현재 시각
		long currentTime = System.currentTimeMillis();
		//현재 시각과 열람시각의 차이가 30분보다 클 경우
		if(currentTime - updateTime > 60*30*1000) {
			//조회수 갱신처리
			cafelistDAO.updateViewCnt(cno);
			//현재 시각을 조회시각으로 저장
			session.setAttribute("updatetime"+cno, currentTime);
		}
		
		return cafelistDAO.readCafeList(cno);
	}

	// 카페글 수정
		@Transactional
		@Override
		public void updateCafeList(CafeListVO vo) throws Exception {
			int cno = vo.getCno();
			// Primary Key가 Duplicate 되지 않도록 전체 파일 내역을 삭제
			uploadDAO.deleteAllAttach(cno);
			
			String[] files = vo.getFiles();
			
			
			// 첨부파일이 없을 경우
			if (files == null) {
			
				vo.setAttachcnt(0);
				cafelistDAO.updateCafeList(vo);
				return;
			}

			
			cafelistDAO.updateCafeList(vo);

			// 첨부파일 입력처리
			for (String fullName : files) {
				uploadDAO.replaceAttach(fullName, cno);
			}
		}

		// 카페 삭제
		@Override
		public void deleteCafeList(int cno) throws Exception {

			// 카페 관련 내용 삭제
			uploadDAO.deleteAllAttach(cno);
			bookmarkDAO.deleteAll(cno);

			// 댓글 관련 내용 삭제
			likeDAO.deleteReviewAllLike(cno);
			reviewDAO.deleteAll(cno);

			// 첨부파일 삭제
			uploadDAO.deleteAllAttach(cno);
			
			// 그 이후 마지막으로 내용 삭제
			cafelistDAO.deleteCafeList(cno);

		}


	// 카페글 목록 + 페이징 + 검색
	@Override
	public List<CafeListVO> cafeListSearch(SearchCriteria searchCriteria) throws Exception {
		return cafelistDAO.cafeListSearch(searchCriteria);
	}

	// 카페글 전체 갯수 
	@Override
	public int countLists(Criteria criteria) throws Exception {
		return cafelistDAO.countLists(criteria);
	}

	// 게시글 전체 갯수 or 검색된 게시글의 수
	@Override
	public int countSearchedLists(SearchCriteria searchCriteria) throws Exception {
		return cafelistDAO.countSearchedLists(searchCriteria);
	}

	// 회원이 작성한 카페 목록
	@Override
	public List<CafeListVO> userCafeList(String uid) throws Exception {
		return cafelistDAO.userCafeList(uid);
	}

	// 총 평점 조회
	@Override
	public Integer countScores(int cno) throws Exception {
		return cafelistDAO.countScores(cno);
	}

	@Override
	public void modifyCimage(int cno, String cimage) throws Exception {
		cafelistDAO.updateCimage(cno, cimage);
	}

	@Override
	public List<CafeListVO> listRate() throws Exception {
		// TODO Auto-generated method stub
		return cafelistDAO.listRate();
	}

	
}
