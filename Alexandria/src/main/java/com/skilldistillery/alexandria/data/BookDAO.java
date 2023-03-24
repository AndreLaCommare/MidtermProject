package com.skilldistillery.alexandria.data;

import java.util.List;

import com.skilldistillery.alexandria.entities.Book;

public interface BookDAO {
	
	List<Book> findBooksByTitle(String title);

//	List<Book> findBooksByGenre(String genre);
	List<Book> findBooksByAuthor(String author);

	List<Book> findBooksByLanguage(String language);

	List<Book> findBooksByDescription(String description);
	
	Book findBookById(int id);
	
	Book findBookByISBN(String isbn);
	
	List<Book> clubFavorites(int clubId);
	
	List<Book> findAllBooks();
}
