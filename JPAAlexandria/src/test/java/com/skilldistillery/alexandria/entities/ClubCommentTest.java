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

class ClubCommentTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private ClubComment clubComment;

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
		clubComment = em.find(ClubComment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		clubComment = null;
		em.close();
	}

	@Test
	void test() {
		assertNotNull(clubComment);
		assertEquals("Great club!", clubComment.getComment());
		assertEquals(2023, clubComment.getCommentDate().getYear());
		assertEquals(3, clubComment.getCommentDate().getMonthValue());
		assertEquals(17, clubComment.getCommentDate().getDayOfMonth());
	}
	
	@Test
	void test_ClubComment_hasUser_ManyToOne() {
		assertNotNull(clubComment);
		assertNotNull(clubComment.getUser());
		assertEquals("kenny",clubComment.getUser().getFirstName());
		
	}
	
	@Test
	void test_ClubComment_hasClub_ManyToOne() {
		assertNotNull(clubComment);
		assertNotNull(clubComment.getClub());
		assertEquals("Alexandria",clubComment.getClub().getName());
		
	}

}
