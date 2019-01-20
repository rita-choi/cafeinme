package com.cafe.main.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe.main.commons.paging.Criteria;
import com.cafe.main.commons.paging.SearchCriteria;
import com.cafe.main.domain.CafeListVO;

@Repository
public class CafeListDAOImpl implements CafeListDAO{

	
	private static final String NAMESPACE = "com.cafe.main.mapper.cafelistMapper";

	private final SqlSession sqlSession;
	
	@Inject
	public CafeListDAOImpl(SqlSession sqlSession) {
		this.sqlSession =sqlSession;
	}

	
	@Override
	public void createCafeList(CafeListVO vo) throws Exception {
		sqlSession.insert(NAMESPACE+".create", vo);
	}

	@Override
	public CafeListVO readCafeList(int cno) throws Exception {
		return sqlSession.selectOne(NAMESPACE+".read", cno);
	}

	@Override
	public void updateCafeList(CafeListVO vo) throws Exception {
		sqlSession.update(NAMESPACE+".update", vo);
		
	}

	@Override
	public void deleteCafeList(int cno) throws Exception {
		sqlSession.delete(NAMESPACE+".delete", cno);
	}

	@Override
	public List<CafeListVO> cafeListSearch(SearchCriteria searchCriteria) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".listSearch", searchCriteria);
	}

	@Override
	public int countLists(Criteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".countLists", criteria);
	}

	@Override
	public void updateReplyCnt(int cno, int amount) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("cno", cno);
		paramMap.put("amount", amount);
		
		sqlSession.update(NAMESPACE + ".updateReplyCnt", paramMap);
		
	}

	@Override
	public void updateViewCnt(int cno) throws Exception {
		sqlSession.update(NAMESPACE + ".updateViewCnt", cno);
		
	}

	@Override
	public List<CafeListVO> listAll() throws Exception {
		return sqlSession.selectList(NAMESPACE+".listAll");
	}

	@Override
	public int countSearchedLists(SearchCriteria searchCriteria) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".countSearchedLists", searchCriteria);
	}
	

	@Override
	public List<CafeListVO> listPaging(int page) throws Exception {
		// TODO Auto-generated method stub
		if(page <= 0) {
			page = 1;
		}
		
		page = (page - 1) * 10;
		return sqlSession.selectList(NAMESPACE + ".listPaging", page);
	}

	@Override
	public List<CafeListVO> listCriteria(Criteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".listCriteria", criteria);
	}


	@Override
	public List<CafeListVO> userCafeList(String uid) throws Exception {
		// TODO Auto-generated method stub
		 return sqlSession.selectList(NAMESPACE + ".userCafeList", uid);
	}

}
