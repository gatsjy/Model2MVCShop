package com.model2.mvc.service.domain;

import java.sql.Date;

public class Notice {
	
	///Field
	private int noticeNo;
	private String noticeId;
	private String noticeTitle;
	private String noticeDetail;
	private Date regDate;
	private int noticeHits;
	private String fileName;
	
	///Constructor
	public Notice() {
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public String getNoticeId() {
		return noticeId;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public String getNoticeDetail() {
		return noticeDetail;
	}

	public Date getRegDate() {
		return regDate;
	}

	public int getNoticeHits() {
		return noticeHits;
	}

	public String getFileName() {
		return fileName;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public void setNoticeDetail(String noticeDetail) {
		this.noticeDetail = noticeDetail;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public void setNoticeHits(int noticeHits) {
		this.noticeHits = noticeHits;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Notice [noticeNo=");
		builder.append(noticeNo);
		builder.append(", noticeId=");
		builder.append(noticeId);
		builder.append(", noticeTitle=");
		builder.append(noticeTitle);
		builder.append(", noticeDetail=");
		builder.append(noticeDetail);
		builder.append(", regDate=");
		builder.append(regDate);
		builder.append(", noticeHits=");
		builder.append(noticeHits);
		builder.append(", fileName=");
		builder.append(fileName);
		builder.append("]");
		return builder.toString();
	}

}