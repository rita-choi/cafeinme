package com.cafe.main.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.cafe.main.domain.BookmarkVO;
import com.cafe.main.persistence.BookmarkDAO;

@Service
public class BookmarkServiceImpl implements BookmarkService {

    @Inject
    private BookmarkDAO bookmarkDAO;

    @Override
    public void create(BookmarkVO bookmarkVO) throws Exception {
        bookmarkDAO.create(bookmarkVO);
    }

    @Override
    public List<BookmarkVO> list(String uid) throws Exception {
        return bookmarkDAO.list(uid);
    }

    @Override
    public boolean checkBookmark(int cno, String uid) throws Exception {
        return bookmarkDAO.checkBookmark(cno, uid);
    }

    @Override
    public void remove(int cno, String uid) throws Exception {
        bookmarkDAO.delete(cno, uid);
    }
}