package com.skilldistillery.alexandria.data;

import java.util.List;

import com.skilldistillery.alexandria.entities.Book;
import com.skilldistillery.alexandria.entities.BookList;

import com.skilldistillery.alexandria.entities.BookComment;

import com.skilldistillery.alexandria.entities.BookReview;
import com.skilldistillery.alexandria.entities.Club;
import com.skilldistillery.alexandria.entities.User;

public interface UserDAO {

	User login(User user);

	User getUserByUserNameAndPassword(String userName, String password);

	User findUserById(int userId);

	User updateUser(int userId, User user);

	User createUser(User user);

	

	

	Club createBookClub(Club bookClub);

	boolean deleteBookClub(int id);

	Club findClubById(int userId);
	
	Club updateBookClub(Club bookClub, int userId);

	BookReview writeReview(BookReview review, int userId);

	BookReview updateBookReview(BookReview review, int userId);

	BookReview bookReviewExistsForUser(int bookId, int userId);

	


	BookComment writeComment(BookComment comment, int userId);

	BookComment replyComment(BookComment comment, int parentCommentId, int userId);


	Book addToFavorites(int bookId, int userId);

	boolean removeFromFavorites(int bookId, int userId);

	Club joinClub(int clubId, int userId);
	
	Club leaveClub(int clubId, int userId);

	User findUserByUsername(String username);

}
