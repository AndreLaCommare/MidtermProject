package com.skilldistillery.alexandria.data;

import java.util.Comparator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import com.skilldistillery.alexandria.entities.Book;
import com.skilldistillery.alexandria.entities.BookComment;
@Transactional
@Service
public class BookDaoImpl implements BookDAO {

	public static final Comparator<BookComment> COMMENT_COMPARATOR = (c1, c2) -> {
		int result = 0;
		if (c1.getParentComment() == null) {
			// c1 not reply comment
			if (c2.getParentComment() == null) {
				// c2 also not reply
				result = c1.getCommentDate().compareTo(c2.getCommentDate());

			} else {

				if (c2.getParentComment().getId() == c1.getId()) {
					// c2 is a direct reply to c1

					result = -1;

				} else {
					// c2 is a reply but not to c1
					result = c1.getCommentDate().compareTo(c2.getParentComment().getCommentDate());
				}
			}
		} else {
			// c1 is a reply
			if (c1.getParentComment().getId() == c2.getId()) {
				// c1 is a direct reply to c2
				result = 1;
			} else {
				if (c2.getParentComment() == null) {
					
					result = c1.getCommentDate().compareTo(c2.getCommentDate());
					
				} else if (c1.getParentComment().getId() == c2.getParentComment().getId()) {
					// c1 and c2 are replies to the same comment
					result = c1.getCommentDate().compareTo(c2.getCommentDate());
				} else {
					result = c1.getParentComment().getCommentDate().compareTo(c2.getParentComment().getCommentDate());
				}
				// both comments are replies in general

			}
		}

		return result;
	};
	
	
	@PersistenceContext
	private EntityManager em;
	
	@Override
	public List<Book> findBooksByTitle(String title) {
		title = "%" + title + "%";
		String jpql = "SELECT b FROM Book b WHERE b.title LIKE :title";
		List<Book> book = em.createQuery(jpql, Book.class).setParameter("title", title).getResultList();
		return book;
	}

	@Override
	public List<Book> findBooksByAuthor(String author) {
		author = "%" + author + "%";
		String jpql = "SELECT b FROM Book b WHERE b.author.name LIKE :author";
		return em.createQuery(jpql, Book.class).setParameter("author", author).getResultList();
	}

	@Override
	public List<Book> findBooksByLanguage(String language) {
		// TODO Auto-generated method stub
		language = "%" + language + "%";
		String jpql = "SELECT b FROM Book b WHERE b.language.name LIKE :language";
		return em.createQuery(jpql, Book.class).setParameter("language", language).getResultList();
	}

	@Override
	public List<Book> findBooksByDescription(String description) {
		// TODO Auto-generated method stub
		description = "%" + description + "%";
		String jpql = "SELECT b FROM Book b WHERE b.description LIKE :description";
		return em.createQuery(jpql, Book.class).setParameter("description", description).getResultList();
	}

	@Override
	public Book findBookByISBN(String isbn) {
		// TODO Auto-generated method stub
		String jpql = "SELECT b FROM Book b WHERE b.isbn = :isbn";
		Book book = null;
		try {
			book =  em.createQuery(jpql, Book.class).setParameter("isbn", isbn).getSingleResult();
			if (book.getBookComments() != null) {
				book.getBookComments().sort(COMMENT_COMPARATOR);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return book;
	}
	
	@Override
	public Book findBookById(int id) {

		Book book = em.find(Book.class, id);

		if (book.getBookComments() != null) {
			book.getBookComments().sort(COMMENT_COMPARATOR);
		}

		return book;
	}

	@Override
	public List<Book> clubFavorites(int clubId) {
		String jpql = "SELECT b FROM Book b JOIN b.usersWithFavBooks fav JOIN fav.clubMemberships cm WHERE cm.id = :clubId AND b MEMBER OF b.usersWithFavBooks";
		List<Book> books = null;
		
			books =  em.createQuery(jpql, Book.class).setParameter("clubId", clubId).getResultList();
			
			System.out.println(books);
		return books;
	}
	
	@Override
	public List<Book> findAllBooks() {
		String jpql = "SELECT b FROM Book b";
		return em.createQuery(jpql, Book.class).getResultList();
	}

}
