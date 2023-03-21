package com.skilldistillery.alexandria.entities;

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
import javax.persistence.OneToMany;

@Entity
public class User {

	@Id 
	@GeneratedValue(strategy= GenerationType.IDENTITY)
	private int id;
	
	
	private String username;
	
	private String password;
	
	private boolean	enabled;
	
	private String role;
	
	@Column(name="image_url")
	private String imageUrl;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	@Column(name="about_me")
	private String aboutMe;
	
	@ManyToMany(mappedBy="clubMembers")
	private List<Club> clubMemberships;
	
	
	@OneToMany(mappedBy= "owner")
	private List<Club> ownedClubs;
	
	@ManyToMany
	@JoinTable(name="user_has_favorite_book",
			joinColumns=@JoinColumn(name="user_id"),
			inverseJoinColumns=@JoinColumn(name="book_id"))
			private List<Book> favoriteBooks;
	
	@OneToMany(mappedBy="user")
	private List<BookComment> userBookComments;
	
	@OneToMany(mappedBy="user")
	private List<ClubComment> userClubComments;
	
	@OneToMany(mappedBy="user")
	private List<BookList> userBookLists;
	
	@OneToMany(mappedBy="user")
	private List<BookReview> bookReviews;
	
	
	
	
	
	

	public User() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getAboutMe() {
		return aboutMe;
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}

	public List<Club> getClubMemberships() {
		return clubMemberships;
	}

	public void setClubMemberships(List<Club> clubMemberships) {
		this.clubMemberships = clubMemberships;
	}

	public List<Book> getFavoriteBooks() {
		return favoriteBooks;
	}

	public void setFavoriteBooks(List<Book> favoriteBooks) {
		this.favoriteBooks = favoriteBooks;
	}

	public List<BookComment> getUserBookComments() {
		return userBookComments;
	}

	public void setUserBookComments(List<BookComment> userBookComments) {
		this.userBookComments = userBookComments;
	}

	public List<ClubComment> getUserClubComments() {
		return userClubComments;
	}

	public void setUserClubComments(List<ClubComment> userClubComments) {
		this.userClubComments = userClubComments;
	}

	public List<BookList> getUserBookLists() {
		return userBookLists;
	}

	public void setUserBookLists(List<BookList> userBookLists) {
		this.userBookLists = userBookLists;
	}
	
	public List<Club> getOwnedClubs() {
		return ownedClubs;
	}

	public void setOwnedClubs(List<Club> ownedClubs) {
		this.ownedClubs = ownedClubs;
	}

	public List<BookReview> getBookReviews() {
		return bookReviews;
	}

	public void setBookReviews(List<BookReview> bookReviews) {
		this.bookReviews = bookReviews;
	}

	public void addFavoriteBook(Book book) {
		if (favoriteBooks == null ) {favoriteBooks = new ArrayList<>(); }
		if ( ! favoriteBooks.contains(book) ) {
			favoriteBooks.add(book);
			book.addUser(this);
		}
	}
	
	public void removeFavoriteBook(Book book) {
		if (favoriteBooks != null && favoriteBooks.contains(book)) {
			favoriteBooks.remove(book);
			book.removeUser(this);
		}
	}
	public void addClub(Club club) {
		if (clubMemberships == null ) {clubMemberships = new ArrayList<>(); }
		if ( ! clubMemberships.contains(club) ) {
			clubMemberships.add(club);
			club.addUser(this);
		}
	}
	
	public void removeClub(Club club) {
		if (clubMemberships != null && clubMemberships.contains(club)) {
			clubMemberships.remove(club);
			club.removeUser(this);
		}
	}
	
	public void addBookList(BookList bookList) {
		if (userBookLists == null) {userBookLists = new ArrayList<>(); }
		if ( ! userBookLists.contains(bookList) ) {
			userBookLists.add(bookList);
			if (bookList.getUser() != null) {
				bookList.getUser().removeBookList(bookList);
			}
			bookList.setUser(this);
		}
	}
	
	public void removeBookList(BookList bookList) {
		if (userBookLists != null && userBookLists.contains(bookList)) {
			userBookLists.remove(bookList);
			bookList.setUser(null);
		}
	}
	
	public void addBookComment(BookComment bookComment) {
		if (userBookComments == null) {userBookComments = new ArrayList<>(); }
		if ( ! userBookComments.contains(bookComment) ) {
			userBookComments.add(bookComment);
			if (bookComment.getUser() != null) {
				bookComment.getUser().removeBookComment(bookComment);
			}
			bookComment.setUser(this);
		}
	}
	
	public void removeBookComment(BookComment bookComment) {
		if (userBookComments != null && userBookComments.contains(bookComment)) {
			userBookComments.remove(bookComment);
			bookComment.setUser(null);
		}
	}
	
	public void addClubComment(ClubComment clubComment) {
		if (userClubComments == null) {userClubComments = new ArrayList<>(); }
		if ( ! userClubComments.contains(clubComment) ) {
			userClubComments.add(clubComment);
			if (clubComment.getUser() != null) {
				clubComment.getUser().removeClubComment(clubComment);
			}
			clubComment.setUser(this);
		}
	}
	
	public void removeClubComment(ClubComment clubComment) {
		if (userClubComments != null && userClubComments.contains(clubComment)) {
			userClubComments.remove(clubComment);
			clubComment.setUser(null);
		}
	}
	
	public void addBookReview(BookReview bookReview) {
		if (bookReviews == null) {bookReviews = new ArrayList<>(); }
		if ( ! bookReviews.contains(bookReview) ) {
			bookReviews.add(bookReview);
			if (bookReview.getUser() != null) {
				bookReview.getUser().removeBookReview(bookReview);
			}
			bookReview.setUser(this);
		}
	}
	
	public void removeBookReview(BookReview bookReview) {
		if (bookReviews != null && bookReviews.contains(bookReview)) {
			bookReviews.remove(bookReview);
			bookReview.setUser(null);
		}
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
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", enabled=" + enabled
				+ ", role=" + role + ", imageUrl=" + imageUrl + ", firstName=" + firstName + ", lastName=" + lastName
				+ ", aboutMe=" + aboutMe + "]";
	}
	
	
}
