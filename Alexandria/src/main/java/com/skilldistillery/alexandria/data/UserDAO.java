package com.skilldistillery.alexandria.data;

import java.util.List;

import com.skilldistillery.alexandria.entities.Book;
import com.skilldistillery.alexandria.entities.Genre;
import com.skilldistillery.alexandria.entities.User;

public interface UserDAO {

	User login(User user);
	
	User getUserByUserNameAndPassword(String userName, String password);
	User findUserById(int userId);
	User updateUser(int userId, User user);

	User createUser(User user);

	List<Book> findBooksByTitle(String title);
	List<Book> findBooksByGenre(String genre);
	List<Book> findBooksByAuthor(String author);
	List<Book> findBooksByLanguage(String language);
	List<Book> findBooksByDescription(String description);
	Book findBooksByISBN(String isbn);


}





