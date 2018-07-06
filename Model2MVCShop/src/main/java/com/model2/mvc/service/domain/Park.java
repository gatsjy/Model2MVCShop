package com.model2.mvc.service.domain;

import java.sql.Date;

public class Park {
	
	private int parkNo;
	private String parkName;
	private String parkDetail;
	private String parkImg;
	private String parkProvince;
	private String parkAddress;
	private String parkPhone;
	private String parkX;
	private String parkY;
	
	public Park(){
	}

	public int getParkNo() {
		return parkNo;
	}

	public String getParkName() {
		return parkName;
	}

	public String getParkDetail() {
		return parkDetail;
	}

	public String getParkImg() {
		return parkImg;
	}

	public String getParkProvince() {
		return parkProvince;
	}

	public String getParkAddress() {
		return parkAddress;
	}

	public String getParkPhone() {
		return parkPhone;
	}

	public String getParkX() {
		return parkX;
	}

	public String getParkY() {
		return parkY;
	}

	public void setParkNo(int parkNo) {
		this.parkNo = parkNo;
	}

	public void setParkName(String parkName) {
		this.parkName = parkName;
	}

	public void setParkDetail(String parkDetail) {
		this.parkDetail = parkDetail;
	}

	public void setParkImg(String parkImg) {
		this.parkImg = parkImg;
	}

	public void setParkProvince(String parkProvince) {
		this.parkProvince = parkProvince;
	}

	public void setParkAddress(String parkAddress) {
		this.parkAddress = parkAddress;
	}

	public void setParkPhone(String parkPhone) {
		this.parkPhone = parkPhone;
	}

	public void setParkX(String parkX) {
		this.parkX = parkX;
	}

	public void setParkY(String parkY) {
		this.parkY = parkY;
	}


}