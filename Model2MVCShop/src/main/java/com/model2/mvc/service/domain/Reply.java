package com.model2.mvc.service.domain;

import java.sql.Date;

public class Reply {
	
	private int replyNo;
	private int noticeNo;
	private String replyId;
	private String replyDetail;
	private Date regDate;
	private Date updateDate;
	
	public Reply() {
	}

	public int getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getReplyId() {
		return replyId;
	}

	public void setReplyId(String replyId) {
		this.replyId = replyId;
	}

	public String getReplyDetail() {
		return replyDetail;
	}

	public void setReplyDetail(String replyDetail) {
		this.replyDetail = replyDetail;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@Override
	public String toString() {
		return "reply [replyNo=" + replyNo + ", noticeNo=" + noticeNo + ", replyId=" + replyId + ", replyDetail="
				+ replyDetail + ", regDate=" + regDate + ", updateDate=" + updateDate + "]";
	}
	
}
