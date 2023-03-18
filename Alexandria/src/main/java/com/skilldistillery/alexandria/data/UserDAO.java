package com.skilldistillery.alexandria.data;

import java.util.List;

import com.skilldistillery.alexandria.entities.Book;
import com.skilldistillery.alexandria.entities.User;

public interface UserDAO {

	User login(User user);
	
	User getUserByUserNameAndPassword(String userName, String password);
	User findUserById(int userId);
	User updateUser(int userId, User user);

	User createUser(User user);

	List<Book> findBookByTitle(String title);
	List<Book> findBookByGenre(String genre);
	List<Book> findBookByAuthor(String author);
	List<Book> findBookByLanguage(String language);
	List<Book> findBookByDescription(String description);
	List<Book> findBookByISBN(String isbn);

}





