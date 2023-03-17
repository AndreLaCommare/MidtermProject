package com.skilldistillery.alexandria.entities;

import java.time.format.DateTimeFormatter;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

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
	private DateTimeFormatter createDate;
	
	@Column(name="image_url")
	private String imageURL;

	public Club() {
		super();
	}

	public int getId() {
		return id;
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

	public DateTimeFormatter getCreateDate() {
		return createDate;
	}

	public void setCreateDate(DateTimeFormatter createDate) {
		this.createDate = createDate;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
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
