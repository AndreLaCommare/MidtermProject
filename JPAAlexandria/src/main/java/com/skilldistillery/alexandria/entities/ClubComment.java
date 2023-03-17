package com.skilldistillery.alexandria.entities;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="club_comment")
public class ClubComment {

	@Id 
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	@Column(name="club_comment")
	private String comment;
	
	@Column(name="comment_date")
	private LocalDate commentDate;
	
	
	
	
}
