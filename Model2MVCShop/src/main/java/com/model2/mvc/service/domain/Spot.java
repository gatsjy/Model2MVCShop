package com.model2.mvc.service.domain;

public class Spot {
	
	private int id;
	private String spotCode;
	private String spotTitle;
	private String spotAddress;
	private float spotX;
	private float spotY;
	private String phone;
	private String spotDetailURL;
	private String spotDetail;
	private String spotImg;
	
	public Spot(){
	}

	public int getId() {
		return id;
	}

	public String getSpotCode() {
		return spotCode;
	}

	public String getSpotTitle() {
		return spotTitle;
	}

	public String getSpotAddress() {
		return spotAddress;
	}

	public float getSpotX() {
		return spotX;
	}

	public float getSpotY() {
		return spotY;
	}

	public String getPhone() {
		return phone;
	}

	public String getSpotDetailURL() {
		return spotDetailURL;
	}

	public String getSpotDetail() {
		return spotDetail;
	}

	public String getSpotImg() {
		return spotImg;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setSpotCode(String spotCode) {
		this.spotCode = spotCode;
	}

	public void setSpotTitle(String spotTitle) {
		this.spotTitle = spotTitle;
	}

	public void setSpotAddress(String spotAddress) {
		this.spotAddress = spotAddress;
	}

	public void setSpotX(float spotX) {
		this.spotX = spotX;
	}

	public void setSpotY(float spotY) {
		this.spotY = spotY;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setSpotDetailURL(String spotDetailURL) {
		this.spotDetailURL = spotDetailURL;
	}

	public void setSpotDetail(String spotDetail) {
		this.spotDetail = spotDetail;
	}

	public void setSpotImg(String spotImg) {
		this.spotImg = spotImg;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Spot [id=");
		builder.append(id);
		builder.append(", spotCode=");
		builder.append(spotCode);
		builder.append(", spotTitle=");
		builder.append(spotTitle);
		builder.append(", spotAddress=");
		builder.append(spotAddress);
		builder.append(", spotX=");
		builder.append(spotX);
		builder.append(", spotY=");
		builder.append(spotY);
		builder.append(", phone=");
		builder.append(phone);
		builder.append(", spotDetailURL=");
		builder.append(spotDetailURL);
		builder.append(", spotDetail=");
		builder.append(spotDetail);
		builder.append(", spotImg=");
		builder.append(spotImg);
		builder.append("]");
		return builder.toString();
	}

}