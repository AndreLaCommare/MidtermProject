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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Book {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String title;
	private String description;
	private int pages;
	private double price;
	private String isbn;

	@ManyToOne
	@JoinColumn(name = "language_id")
	private Language language;

	@ManyToOne
	@JoinColumn(name = "author_id")
	private Author author;

	@Column(name = "published_year")
	private int publishedYear;
	@Column(name = "cover_url")
	private String coverUrl;

	@ManyToMany
	@JoinTable(name = "book_has_genre", 
	joinColumns = @JoinColumn(name = "book_id"), 
	inverseJoinColumns = @JoinColumn(name = "genre_id"))
	private List<Genre> genres;

	@ManyToMany(mappedBy = "books")
	private List<BookList> bookLists;

	@ManyToMany(mappedBy = "clubBooks")
	private List<Club> clubsWithThisBook;

	@ManyToMany(mappedBy = "favoriteBooks")
	private List<User> usersWithFavBooks;

	@OneToMany(mappedBy = "book")
	private List<BookComment> bookComments;
	
	@OneToMany(mappedBy="book")
	private List<BookReview> reviews;


	public Book() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getPages() {
		return pages;
	}

	public void setPages(int pages) {
		this.pages = pages;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public Language getLanguage() {
		return language;
	}

	public void setLanguage(Language language) {
		this.language = language;
	}

	public Author getAuthor() {
		return author;
	}

	public void setAuthor(Author author) {
		this.author = author;
	}

	public int getPublishedYear() {
		return publishedYear;
	}

	public void setPublishedYear(int publishedYear) {
		this.publishedYear = publishedYear;
	}

	public String getCoverUrl() {
		return coverUrl;
	}

	public void setCoverUrl(String coverUrl) {
		this.coverUrl = coverUrl;
	}

	public List<Genre> getGenres() {
		return genres;
	}

	public void setGenres(List<Genre> genres) {
		this.genres = genres;
	}

	public List<BookList> getBookLists() {
		return bookLists;
	}

	public void setBookLists(List<BookList> bookLists) {
		this.bookLists = bookLists;
	}

	public List<Club> getClubsWithThisBook() {
		return clubsWithThisBook;
	}

	public void setClubsWithThisBook(List<Club> clubsWithThisBook) {
		this.clubsWithThisBook = clubsWithThisBook;
	}

	public List<User> getUsersWithFavBooks() {
		return usersWithFavBooks;
	}

	public void setUsersWithFavBooks(List<User> usersWithFavBooks) {
		this.usersWithFavBooks = usersWithFavBooks;
	}

	public List<BookComment> getBookComments() {
		return bookComments;
	}

	public void setBookComments(List<BookComment> bookComments) {
		this.bookComments = bookComments;
	}
	public List<BookReview> getReviews() {
		return reviews;
	}
	
	public void setReviews(List<BookReview> reviews) {
		this.reviews = reviews;
	}
	
	public void addGenre(Genre genre) {
		if (genres == null ) {genres = new ArrayList<>(); }
		if ( ! genres.contains(genre) ) {
			genres.add(genre);
			genre.addBook(this);
		}
	}
	
	public void removeGenre(Genre genre) {
		if (genres != null && genres.contains(genre)) {
			genres.remove(genre);
			genre.removeBook(this);
		}
	}

	public void addBookList(BookList bookList) {
		if (bookLists == null ) {bookLists = new ArrayList<>(); }
		if ( ! bookLists.contains(bookList) ) {
			bookLists.add(bookList);
			bookList.addBook(this);
		}
	}
	
	public void removeBookList(BookList bookList) {
		if (bookLists != null && bookLists.contains(bookList)) {
			bookLists.remove(bookList);
			bookList.removeBook(this);
		}
	}
	
	public void addClub(Club club) {
		if (clubsWithThisBook == null ) {clubsWithThisBook = new ArrayList<>(); }
		if ( ! clubsWithThisBook.contains(club) ) {
			clubsWithThisBook.add(club);
			club.addBook(this);
		}
	}
	
	public void removeClub(Club club) {
		if (clubsWithThisBook != null && clubsWithThisBook.contains(club)) {
			clubsWithThisBook.remove(club);
			club.removeBook(this);
		}
	}
	public void addUser(User user) {
		if (usersWithFavBooks == null ) {usersWithFavBooks = new ArrayList<>(); }
		if ( ! usersWithFavBooks.contains(user) ) {
			usersWithFavBooks.add(user);
			user.addFavoriteBook(this);
		}
	}
	
	public void removeUser(User user) {
		if (usersWithFavBooks != null && usersWithFavBooks.contains(user)) {
			usersWithFavBooks.remove(user);
			user.removeFavoriteBook(this);
		}
	}
	
	public void addBookComment(BookComment bookComment) {
		if (bookComments == null) {bookComments = new ArrayList<>(); }
		if ( ! bookComments.contains(bookComment) ) {
			bookComments.add(bookComment);
			if (bookComment.getBook() != null) {
				bookComment.getBook().removeBookComment(bookComment);
			}
			bookComment.setBook(this);
		}
	}
	
	public void removeBookComment(BookComment bookComment) {
		if (bookComments != null && bookComments.contains(bookComment)) {
			bookComments.remove(bookComment);
			bookComment.setBook(null);
		}
	}
	
	public void addBookReview(BookReview bookReview) {
		if (reviews == null) {reviews = new ArrayList<>(); }
		if ( ! reviews.contains(bookReview) ) {
			reviews.add(bookReview);
			if (bookReview.getBook() != null) {
				bookReview.getBook().removeBookReview(bookReview);
			}
			bookReview.setBook(this);
		}
	}
	
	public void removeBookReview(BookReview bookReview) {
		if (reviews != null && reviews.contains(bookReview)) {
			reviews.remove(bookReview);
			bookReview.setBook(null);
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
		Book other = (Book) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Book [id=" + id + ", title=" + title + ", description=" + description + ", pages=" + pages + ", price="
				+ price + ", isbn=" + isbn + ", publishedYear=" + publishedYear + ", coverUrl=" + coverUrl + "]";
	}

}
