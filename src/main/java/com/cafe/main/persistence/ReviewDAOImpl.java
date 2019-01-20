package com.cafe.main.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe.main.commons.paging.Criteria;
import com.cafe.main.domain.ReviewVO;

@Repository
public class ReviewDAOImpl implements ReviewDAO{

	private static String NAMESPACE = "com.cafe.main.mapper.reviewMapper";

	private final SqlSession sqlSession;
	
	@Inject
	public ReviewDAOImpl(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public List<ReviewVO> list(int cno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + ".list", cno);
	}

	@Override
	public void create(ReviewVO reviewVO) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(NAMESPACE + ".create", reviewVO);
	}

	@Override
	public void update(ReviewVO reviewVO) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(NAMESPACE + ".update", reviewVO);
	}

	@Override
	public void delete(int rno) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete(NAMESPACE + ".delete", rno);
	}

	@Override
	public List<ReviewVO> listPaging(int cno, Criteria criteria) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> paramMap = new HashMap<>();
		
		paramMap.put("cno", cno);
		paramMap.put("criteria", criteria);
		
		return sqlSession.selectList(NAMESPACE + ".listPaging", paramMap);
	}

	@Override
	public int countReview(int cno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".countReviews", cno);
	}

	@Override
	public int getCafeNo(int rno) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + ".getCafeNo", rno);
	}
	
    @Override
    public List<ReviewVO> userReviews(String uid) throws Exception {
        return sqlSession.selectList(NAMESPACE + ".userReviews", uid);
    }
}
