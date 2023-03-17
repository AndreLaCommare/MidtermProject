package com.skilldistillery.alexandria.entities;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

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
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="in_reply_to_id")
	private ClubComment parentComment;
	
	@OneToMany(mappedBy="parentComment")
	private List<ClubComment> replies;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="club_id")
	private Club club;


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

	public ClubComment getParentComment() {
		return parentComment;
	}
	
	public void setParentComment(ClubComment parentComment) {
		this.parentComment = parentComment;
	}
	
	public List<ClubComment> getReplies() {
		return replies;
	}
	
	public void setReplies(List<ClubComment> replies) {
		this.replies = replies;
	}
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Club getClub() {
		return club;
	}

	public void setClub(Club club) {
		this.club = club;
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