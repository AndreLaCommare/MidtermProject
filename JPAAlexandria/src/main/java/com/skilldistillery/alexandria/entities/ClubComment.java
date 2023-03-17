package com.skilldistillery.alexandria.entities;

import java.time.LocalDate;
import java.util.Objects;

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

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public LocalDate getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(LocalDate commentDate) {
		this.commentDate = commentDate;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ClubComment other = (ClubComment) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "ClubComment [id=" + id + ", comment=" + comment + ", commentDate=" + commentDate + "]";
	}
	
	
	
	
	
	
}
