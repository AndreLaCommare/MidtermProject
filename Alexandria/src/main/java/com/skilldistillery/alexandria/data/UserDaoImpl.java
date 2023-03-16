package com.skilldistillery.alexandria.data;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import net.bytebuddy.matcher.ElementMatcher;

@Transactional
@Service
public class UserDaoImpl implements UserDAO {
	
	
	@PersistenceContext
	private EntityManager em;
}
