package com.skilldistillery.alexandria.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Club {
	
	@Id 
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String description;
	
	@ManyToOne
	@JoinColumn(name="owner_id")
	private User owner;
	
	@Column(name="create_date")
	@CreationTimestamp
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



	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
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
	
	public void addBook(Book book) {
		if (clubBooks == null ) {clubBooks = new ArrayList<>(); }
		if ( ! clubBooks.contains(book) ) {
			clubBooks.add(book);
			book.addClub(this);
		}
	}
	
	public void removeBook(Book book) {
		if (clubBooks != null && clubBooks.contains(book)) {
			clubBooks.remove(book);
			book.removeClub(this);
		}
	}
	public void addUser(User user) {
		if (clubMembers == null ) {clubMembers = new ArrayList<>(); }
		if ( ! clubMembers.contains(user) ) {
			clubMembers.add(user);
			user.addClub(this);
		}
	}
	
	public void removeUser(User user) {
		if (clubMembers != null && clubMembers.contains(user)) {
			clubMembers.remove(user);
			user.removeClub(this);
		}
	}
	
	public void addClubComment(ClubComment clubComment) {
		if (commentsOnClub == null) {commentsOnClub = new ArrayList<>(); }
		if ( ! commentsOnClub.contains(clubComment) ) {
			commentsOnClub.add(clubComment);
			if (clubComment.getClub() != null) {
				clubComment.getClub().removeClubComment(clubComment);;
			}
			clubComment.setClub(this);
		}
	}
	
	public void removeClubComment(ClubComment clubComment) {
		if (commentsOnClub != null && commentsOnClub.contains(clubComment)) {
			commentsOnClub.remove(clubComment);
			clubComment.setClub(null);
		}
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
				.append(description).append(", ownerId=").append(owner).append(", createDate=").append(createDate)
				.append(", imageURL=").append(imageURL).append("]");
		return builder.toString();
	}
	
}
