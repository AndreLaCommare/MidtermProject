package com.skilldistillery.alexandria.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

@Entity
public class Club {
	
	@Id 
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String description;
	
	@Column(name="owner_id")
	private int ownerId;
	
	@Column(name="create_date")
	private LocalDateTime createDate;
	
	@Column(name="image_url")
	private String imageURL;
	
	@ManyToMany
	@JoinTable(name="club_has_book",
			joinColumns=@JoinColumn(name="club_id"),
			inverseJoinColumns=@JoinColumn(name="book_id"))
			private List<Book> clubBooks;
	
	@ManyToMany
	@JoinTable(name="user_has_club",
	joinColumns=@JoinColumn(name="club_id"),
	inverseJoinColumns=@JoinColumn(name="user_id"))
	private List<User> clubMembers;
	
	@OneToMany(mappedBy="club")
	private List<ClubComment> commentsOnClub;

	public Club() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getOwnerId() {
		return ownerId;
	}

	public void setOwnerId(int ownerId) {
		this.ownerId = ownerId;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}

	public List<Book> getClubBooks() {
		return clubBooks;
	}

	public void setClubBooks(List<Book> clubBooks) {
		this.clubBooks = clubBooks;
	}

	public List<User> getClubMembers() {
		return clubMembers;
	}

	public void setClubMembers(List<User> clubMembers) {
		this.clubMembers = clubMembers;
	}

	public List<ClubComment> getCommentsOnClub() {
		return commentsOnClub;
	}

	public void setCommentsOnClub(List<ClubComment> commentsOnClub) {
		this.commentsOnClub = commentsOnClub;
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
		Club other = (Club) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Club [id=").append(id).append(", name=").append(name).append(", description=")
				.append(description).append(", ownerId=").append(ownerId).append(", createDate=").append(createDate)
				.append(", imageURL=").append(imageURL).append("]");
		return builder.toString();
	}
	
}
