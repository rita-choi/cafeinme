package com.cafe.main.persistence;

import java.util.List;

public interface UploadDAO {

    // 첨부파일 추가
    public void addAttach(String fullName, int cno) throws Exception;

    // 첨부파일 조회
    public List<String> getAttach(int cno) throws Exception;

    // 첨부파일 수정
    public void replaceAttach(String fullName, int cno) throws Exception;

    // 첨부파일 삭제
    public void deleteAttach(String fullName) throws Exception;

    // 첨부파일 일괄 삭제
    public void deleteAllAttach(int cno) throws Exception;

    // 특정 글의 첨부파일 갯수 갱신
    public void updateAttachCnt(int cno) throws Exception;
	
}
