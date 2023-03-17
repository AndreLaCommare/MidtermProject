package com.skilldistillery.alexandria.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class BookCommentTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private BookComment bookcomment;

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
		bookcomment = em.find(BookComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		bookcomment = null;
	}

	@Test
	void test_BookComment_entity_mapping() {
		assertNotNull(bookcomment);
		assertEquals("Fun to read", bookcomment.getBookComment());
	}

}
