package com.skilldistillery.alexandria.entities;

import java.time.format.DateTimeFormatter;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity	
@Table(name = "club_comment")
public class ClubComment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name="club_comment")
	private String clubComment;

	@Column(name="comment_date")
	private DateTimeFormatter commentDate;

	@Column(name="user_id")
	private int userId;

	@Column(name="club_id")
	private int clubId;

	@Column(name="in_reply_to_id")
	private int inReplyToId;

	public ClubComment() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getClubComment() {
		return clubComment;
	}

	public void setClubComment(String clubComment) {
		this.clubComment = clubComment;
	}

	public DateTimeFormatter getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(DateTimeFormatter commentDate) {
		this.commentDate = commentDate;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getClubId() {
		return clubId;
	}

	public void setClubId(int clubId) {
		this.clubId = clubId;
	}

	public int getInReplyToId() {
		return inReplyToId;
	}

	public void setInReplyToId(int inReplyToId) {
		this.inReplyToId = inReplyToId;
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
		StringBuilder builder = new StringBuilder();
		builder.append("ClubComment [id=").append(id).append(", clubComment=").append(clubComment)
				.append(", commentDate=").append(commentDate).append(", userId=").append(userId).append(", clubId=")
				.append(clubId).append(", inReplyToId=").append(inReplyToId).append("]");
		return builder.toString();
	}

}
