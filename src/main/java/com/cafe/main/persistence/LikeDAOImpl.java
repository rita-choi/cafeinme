package com.cafe.main.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe.main.domain.ReviewLikeVO;

import javax.inject.Inject;
import java.util.HashMap;
import java.util.Map;

@Repository
public class LikeDAOImpl implements LikeDAO {

    @Inject
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.cafe.main.mapper.LikeMapper";


    @Override
    public void createReviewLike(ReviewLikeVO reviewLikeVO) throws Exception {
        sqlSession.insert(NAMESPACE + ".createReviewLike", reviewLikeVO);
    }

    @Override
    public void deleteReviewLike(ReviewLikeVO reviewLikeVO) throws Exception {
        sqlSession.delete(NAMESPACE + ".deleteReviewLike", reviewLikeVO);
    }

    @Override
    public int countReviewLikes(Integer rno) throws Exception {
        return sqlSession.selectOne(NAMESPACE + ".countReviewLikes", rno);
    }

    @Override
    public boolean checkReviewLike(Integer rno, String uid) throws Exception {

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("rno", rno);
        paramMap.put("uid", uid);

        return sqlSession.selectOne(NAMESPACE + ".checkReviewLike", paramMap);
    }
}