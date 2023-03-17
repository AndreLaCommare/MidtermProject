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

class ClubTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Club club;

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
		club = em.find(Club.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		club = null;
	}

	@Test
	void test_Club_entity_mapping() {
		assertNotNull(club);
		assertEquals("Alexandria", club.getName());
	}
	
	@Test
	void test_Club_to_ListOfClubBooks_ManyToMany() {
		assertNotNull(club);
		assertNotNull(club.getClubBooks());
		//assertFalse(book.getClubBooks().isEmpty());
	}
	@Test
	void test_Club_to_ListOfUsers_ManyToMany() {
		assertNotNull(club);
		assertNotNull(club.getClubMembers());
		//assertFalse(book.getClubBooks().isEmpty());
	}
	
	@Test
	void test_Club_has_listOfClubComments_OneToMany() {
		assertNotNull(club);
		assertNotNull(club.getCommentsOnClub());
		assertNotNull("Great club!",club.getCommentsOnClub().get(0).getComment());
	}
	

}
