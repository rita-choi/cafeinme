package com.cafe.main.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class UploadDAOImpl implements UploadDAO {

    @Inject
    private SqlSession sqlSession;

    @Inject
    public UploadDAOImpl(SqlSession sqlSession) {
    	this.sqlSession = sqlSession;
    }
    
    private static final String NAMESPACE = "com.cafe.main.mapper.UploadMapper";

    // 게시글 첨부파일 추가
    @Override
    public void addAttach(String fullName, int cno) throws Exception {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("fullName", fullName);
        paramMap.put("cno", cno);
        sqlSession.insert(NAMESPACE + ".addAttach", paramMap);
    }
    
    // 게시글 첨부파일 조회
    @Override
    public List<String> getAttach(int cno) throws Exception {
        return sqlSession.selectList(NAMESPACE + ".getAttach", cno);
    }

    // 게시글 첨부파일 수정
    @Override
    public void replaceAttach(String fullName, int cno) throws Exception {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("fullName", fullName);
        paramMap.put("cno", cno);
        sqlSession.insert(NAMESPACE + ".replaceAttach", paramMap);
    }

    // 게시글 첨부파일 삭제
    @Override
    public void deleteAttach(String fullName) throws Exception {
        sqlSession.delete(NAMESPACE + ".deleteAttach", fullName);
    }

    // 게시글 첨부파일 일괄 삭제
    @Override
    public void deleteAllAttach(int cno) throws Exception {
        sqlSession.delete(NAMESPACE + ".deleteAllAttach", cno);
    }

    // 특정 게시글의 첨부파일 갯수 갱신
    @Override
    public void updateAttachCnt(int cno) throws Exception {
        sqlSession.update(NAMESPACE + ".updateAttachCnt", cno);
    }

}