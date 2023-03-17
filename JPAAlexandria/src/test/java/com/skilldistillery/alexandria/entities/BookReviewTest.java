package com.skilldistillery.alexandria.entities;

import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.*;

class BookReviewTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private BookReview review;

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
		BookReviewId id = new BookReviewId();
		id.setUserId(1);
		id.setBookId(1);
		review = em.find(BookReview.class, id);

	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		review = null;
	}

	@Test
	void test_bookreview_mapping() {
		assertNotNull(review);
	}
	
	@Test
	void test_BookReview_has_Book_ManyToOne() {
		assertNotNull(review);
		assertEquals("Ender's Game", review.getBook().getTitle());
	}

}
