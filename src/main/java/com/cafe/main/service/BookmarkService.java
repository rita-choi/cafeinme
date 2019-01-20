package com.cafe.main.service;

import java.util.List;

import com.cafe.main.domain.BookmarkVO;

public interface BookmarkService {

    // 북마크 등록
    public void create(BookmarkVO bookmarkVO) throws Exception;

    // 북마크 목록
    public List<BookmarkVO> list(String uid) throws Exception;

    // 북마크 확인
    public boolean checkBookmark(int cno, String uid) throws Exception;

    // 북마크 삭제
    public void remove(int cno, String uid) throws Exception;
}
