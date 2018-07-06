package com.model2.mvc.service.domain;

import java.sql.Date;

public class Product {
	
	private String fileName;
	private String manuDate;
	private int price;
	private String prodDetail;
	private String prodName;
	private int prodNo;
	private Date regDate;
	private String proTranCode;
	private int prodQuantity;
	private double star;
	private String review;
	private String buyerId;
	
	public Product(){
	}

	public String getFileName() {
		return fileName;
	}

	public String getManuDate() {
		return manuDate;
	}

	public int getPrice() {
		return price;
	}

	public String getProdDetail() {
		return prodDetail;
	}

	public String getProdName() {
		return prodName;
	}

	public int getProdNo() {
		return prodNo;
	}

	public Date getRegDate() {
		return regDate;
	}

	public String getProTranCode() {
		return proTranCode;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public void setManuDate(String manuDate) {
		this.manuDate = manuDate.replace("-", "");
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public void setProdDetail(String prodDetail) {
		this.prodDetail = prodDetail;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public void setProTranCode(String proTranCode) {
		this.proTranCode = proTranCode.trim();
	}

	public int getProdQuantity() {
		return prodQuantity;
	}

	public void setProdQuantity(int prodQuantity) {
		this.prodQuantity = prodQuantity;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Product [fileName=");
		builder.append(fileName);
		builder.append(", manuDate=");
		builder.append(manuDate);
		builder.append(", price=");
		builder.append(price);
		builder.append(", prodDetail=");
		builder.append(prodDetail);
		builder.append(", prodName=");
		builder.append(prodName);
		builder.append(", prodNo=");
		builder.append(prodNo);
		builder.append(", regDate=");
		builder.append(regDate);
		builder.append(", proTranCode=");
		builder.append(proTranCode);
		builder.append(", prodQuantity=");
		builder.append(prodQuantity);
		builder.append("]");
		return builder.toString();
	}

	public double getStar() {
		return star;
	}

	public void setStar(double star) {
		this.star = star;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public String getBuyerId() {
		return buyerId;
	}

	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}


}