package com.cafe.main.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe.main.domain.BookmarkVO;

@Repository
public class BookmarkDAOImpl implements BookmarkDAO {

    @Inject
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.cafe.main.mapper.BookmarkMapper";

    @Override
    public void create(BookmarkVO bookmarkVO) throws Exception {

        sqlSession.insert(NAMESPACE + ".create", bookmarkVO);

    }

    @Override
    public List<BookmarkVO> list(String uid) throws Exception {

        return sqlSession.selectList(NAMESPACE + ".list", uid);

    }

    @Override
    public boolean checkBookmark(int cno, String uid) throws Exception {

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("cno", cno);
        paramMap.put("uid", uid);

        return sqlSession.selectOne(NAMESPACE + ".checkBookmark", paramMap);
    }

    @Override
    public void delete(int cno, String uid) throws Exception {

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("cno", cno);
        paramMap.put("uid", uid);

        sqlSession.delete(NAMESPACE + ".delete",paramMap);
    }
}