package com.model2.mvc.service.domain;

import java.sql.Date;

public class Cart {
	
	private User buyer;
	private Product cartProd;
	private int prodNo;
	private int cartNo;
	private int cartQuantity;
	private int cartPrice;
	private Date regDate;
	private String prodName;
	private int prodPrice;
	private int sumPrice;
	private String cartCancel;
	
	public Cart(){
	}

	public User getBuyer() {
		return buyer;
	}

	public Product getCartProd() {
		return cartProd;
	}

	public int getProdNo() {
		return prodNo;
	}

	public int getCartNo() {
		return cartNo;
	}

	public int getCartQuantity() {
		return cartQuantity;
	}

	public int getCartPrice() {
		return cartPrice;
	}

	public Date getRegDate() {
		return regDate;
	}

	public String getProdName() {
		return prodName;
	}

	public int getProdPrice() {
		return prodPrice;
	}

	public int getSumPrice() {
		return sumPrice;
	}

	public String getCartCancel() {
		return cartCancel;
	}

	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}

	public void setCartProd(Product cartProd) {
		this.cartProd = cartProd;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public void setCartQuantity(int cartQuantity) {
		this.cartQuantity = cartQuantity;
	}

	public void setCartPrice(int cartPrice) {
		this.cartPrice = cartPrice;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public void setProdPrice(int prodPrice) {
		this.prodPrice = prodPrice;
	}

	public void setSumPrice(int sumPrice) {
		this.sumPrice = sumPrice;
	}

	public void setCartCancel(String cartCancel) {
		this.cartCancel = cartCancel;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Cart [buyer=");
		builder.append(buyer);
		builder.append(", cartProd=");
		builder.append(cartProd);
		builder.append(", prodNo=");
		builder.append(prodNo);
		builder.append(", cartNo=");
		builder.append(cartNo);
		builder.append(", cartQuantity=");
		builder.append(cartQuantity);
		builder.append(", cartPrice=");
		builder.append(cartPrice);
		builder.append(", regDate=");
		builder.append(regDate);
		builder.append(", prodName=");
		builder.append(prodName);
		builder.append(", prodPrice=");
		builder.append(prodPrice);
		builder.append(", sumPrice=");
		builder.append(sumPrice);
		builder.append(", cartCancel=");
		builder.append(cartCancel);
		builder.append("]");
		return builder.toString();
	}

}