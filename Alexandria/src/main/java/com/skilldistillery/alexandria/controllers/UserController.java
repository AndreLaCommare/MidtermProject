package com.skilldistillery.alexandria.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.skilldistillery.alexandria.data.UserDAO;

@Controller
public class UserController {
	
	@Autowired
	private UserDAO userDao;
}
