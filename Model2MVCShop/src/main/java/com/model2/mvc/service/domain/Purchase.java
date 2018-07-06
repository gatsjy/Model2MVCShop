package com.model2.mvc.service.domain;

import java.sql.Date;

public class Purchase {
	
	private User buyer;
	private String divyAddr;
	private String divyDate;
	private String divyRequest;
	private Date orderDate;
	private String paymentOption;
	private Product purchaseProd;
	private String receiverName;
	private String receiverPhone;
	private String tranCode;
	private int tranNo;
	private int purchaseQuantity;
	private int purchasePrice;
	private String purchaseCancel;
	private int star;
	private String review;
	private String lat;
	private String lng;

	public Purchase(){
	}

	public User getBuyer() {
		return buyer;
	}

	public String getDivyAddr() {
		return divyAddr.replace("-", "");
	}

	public String getDivyDate() {
		return divyDate;
	}

	public String getDivyRequest() {
		return divyRequest;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public String getPaymentOption() {
		return paymentOption;
	}

	public Product getPurchaseProd() {
		return purchaseProd;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public String getReceiverPhone() {
		return receiverPhone;
	}

	public String getTranCode() {
		return tranCode.trim();
	}

	public int getTranNo() {
		return tranNo;
	}

	public int getPurchaseQuantity() {
		return purchaseQuantity;
	}

	public int getPurchasePrice() {
		return purchasePrice;
	}

	public String getPurchaseCancel() {
		return purchaseCancel;
	}

	public int getStar() {
		return star;
	}

	public String getReview() {
		return review;
	}

	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}

	public void setDivyAddr(String divyAddr) {
		this.divyAddr = divyAddr;
	}

	public void setDivyDate(String divyDate) {
		if(divyDate==null) {
			this.divyDate = divyDate;
		}else {
			this.divyDate = divyDate.substring(0, 10);
		}
	}

	public void setDivyRequest(String divyRequest) {
		this.divyRequest = divyRequest;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public void setPaymentOption(String paymentOption) {
		this.paymentOption = paymentOption.trim();
	}

	public void setPurchaseProd(Product purchaseProd) {
		this.purchaseProd = purchaseProd;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}

	public void setTranCode(String tranCode) {
		this.tranCode = tranCode;
	}

	public void setTranNo(int tranNo) {
		this.tranNo = tranNo;
	}

	public void setPurchaseQuantity(int purchaseQuantity) {
		this.purchaseQuantity = purchaseQuantity;
	}

	public void setPurchasePrice(int purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public void setPurchaseCancel(String purchaseCancel) {
		this.purchaseCancel = purchaseCancel;
	}

	public void setStar(int star) {
		this.star = star;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public String getLat() {
		return lat;
	}

	public String getLng() {
		return lng;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Purchase [buyer=");
		builder.append(buyer);
		builder.append(", divyAddr=");
		builder.append(divyAddr);
		builder.append(", divyDate=");
		builder.append(divyDate);
		builder.append(", divyRequest=");
		builder.append(divyRequest);
		builder.append(", orderDate=");
		builder.append(orderDate);
		builder.append(", paymentOption=");
		builder.append(paymentOption);
		builder.append(", purchaseProd=");
		builder.append(purchaseProd);
		builder.append(", receiverName=");
		builder.append(receiverName);
		builder.append(", receiverPhone=");
		builder.append(receiverPhone);
		builder.append(", tranCode=");
		builder.append(tranCode);
		builder.append(", tranNo=");
		builder.append(tranNo);
		builder.append(", purchaseQuantity=");
		builder.append(purchaseQuantity);
		builder.append(", purchasePrice=");
		builder.append(purchasePrice);
		builder.append(", purchaseCancel=");
		builder.append(purchaseCancel);
		builder.append(", star=");
		builder.append(star);
		builder.append(", review=");
		builder.append(review);
		builder.append(", lat=");
		builder.append(lat);
		builder.append(", lng=");
		builder.append(lng);
		builder.append("]");
		return builder.toString();
	}
	
}