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
import com.cafe.main.persistence.CafeListDAO;

@Service
public class CafeListServiceImpl implements CafeListService {

	@Inject
	private CafeListDAO cafelistDAO;

	// 카페글 입력 처리
	@Transactional
	@Override
	public void createCafeList(CafeListVO vo) throws Exception {
		cafelistDAO.createCafeList(vo);
		// 첨부파일 처리는 추가 필요
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
	@Override
	public void updateCafeList(CafeListVO vo) throws Exception {
		cafelistDAO.updateCafeList(vo);
		// 첨부파일  처리는 추가 필요
	}

	// 카페글 삭제
	@Override
	public void deleteCafeList(int cno) throws Exception {
		cafelistDAO.deleteCafeList(cno);
		// 첨부파일 처리는 추가 필요
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

	// 카페 전체 목록 조회
	@Override
	public List<CafeListVO> listAll() throws Exception {
		return cafelistDAO.listAll();
	}

	// 페이징 처리 목록 조회
	@Override
	public List<CafeListVO> listCriteria(Criteria criteria) throws Exception {
		return cafelistDAO.listCriteria(criteria);
	}

	@Override
	public List<CafeListVO> userCafeList(String uid) throws Exception {
		// TODO Auto-generated method stub
		return cafelistDAO.userCafeList(uid);
	}

}
