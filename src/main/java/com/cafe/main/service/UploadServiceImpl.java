package com.cafe.main.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.cafe.main.persistence.UploadDAO;

@Service
public class UploadServiceImpl implements UploadService{

	   @Inject
	    private UploadDAO uploadDAO;
	   


	    // 게시글 첨부파일 조회
	    @Override
	    public List<String> getAttach(int cno) throws Exception {
	        return uploadDAO.getAttach(cno);
	    }

	    // 게시글 첨부파일 삭제
	    @Override
	    public void deleteAttach(String fullName) throws Exception {
	        uploadDAO.deleteAttach(fullName);
	    }

	    // 특정 게시글의 첨부파일 갯수 갱신
	    @Override
	    public void updateAttachCnt(int cno) throws Exception {
	        uploadDAO.updateAttachCnt(cno);
	    }

	
	
}