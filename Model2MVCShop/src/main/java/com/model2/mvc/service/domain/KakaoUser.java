package com.model2.mvc.service.domain;

//==>È¸¿øÁ¤º¸¸¦ ¸ðµ¨¸µ(Ãß»óÈ­/Ä¸½¶È­)ÇÑ Bean
public class KakaoUser {
	
	///Field
	private String userId;
	private String userName;
	private String email;
	
	///Constructor
	public KakaoUser(){
	}

	public KakaoUser(String userId, String userName, String email) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.email = email;
	}

	public String getUserId() {
		return userId;
	}

	public String getUserName() {
		return userName;
	}

	public String getEmail() {
		return email;
	}

	public void setUserId(String userId) {
		this.userId = userId.substring(7);
	}

	public void setUserName(String userName) {
		this.userName = userName.substring(9);
	}

	public void setEmail(String email) {
		this.email = email.substring(6);
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("KakaoUser [userId=");
		builder.append(userId);
		builder.append(", userName=");
		builder.append(userName);
		builder.append(", email=");
		builder.append(email);
		builder.append("]");
		return builder.toString();
	}
	
}