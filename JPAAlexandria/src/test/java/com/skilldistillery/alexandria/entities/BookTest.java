package com.skilldistillery.alexandria.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class BookTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Book book;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPABookClub");
	}
	

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		book = em.find(Book.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		book = null;
	}

	@Test
	void test_basic_mappings() {
		assertNotNull(book);
		assertEquals("Ender's Game", book.getTitle());
		assertEquals(300, book.getPages());
		assertEquals(1985, book.getPublishedYear());
	}
	
	@Test
	void test_Book_to_ListOfBooklists_ManyToMany() {
		assertNotNull(book);
		assertNotNull(book.getBookLists());
		//assertFalse(book.getBookLists().isEmpty());
	}
	
	@Test
	void test_Book_to_ListOfClubs_ManyToMany() {
		assertNotNull(book);
		assertNotNull(book.getClubsWithThisBook());
		//assertFalse(book.getBookLists().isEmpty());
	}
	
	@Test
	void test_Book_UsersWithFavBooks_ManyToMany() {
		assertNotNull(book);
		assertNotNull(book.getUsersWithFavBooks());
		//assertFalse(book.getBookLists().isEmpty());
	}
	
	@Test
	void test_Book_ListOfBookComments_OneToMany() {
		assertNotNull(book);
		assertNotNull(book.getBookComments());
	}
	
	@Test
	void test_Book_hasAuthor() {
		assertNotNull(book);
		assertNotNull(book.getAuthor());
	}
	
	@Test
	void test_Book_to_ListOfReviews_OneToMany() {
		assertNotNull(book);
		assertNotNull(book.getReviews());
		//assertFalse(book.getBookLists().isEmpty());
	}

}
