package dto;

import java.io.Serializable;

public class CalendarDto implements Serializable{
	
	private int calSeq;
	private String memberID;
	private String calTitle;
	private String calWdate;
	private String calRdate;
	
	
	
	public int getCalSeq() {
		return calSeq;
	}
	public void setCalSeq(int calSeq) {
		this.calSeq = calSeq;
	}
	public String getMemberID() {
		return memberID;
	}
	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}
	public String getCalTitle() {
		return calTitle;
	}
	public void setCalTitle(String calTitle) {
		this.calTitle = calTitle;
	}
	public String getCalWdate() {
		return calWdate;
	}
	public void setCalWdate(String calWdate) {
		this.calWdate = calWdate;
	}
	public String getCalRdate() {
		return calRdate;
	}
	public void setCalRdate(String calRdate) {
		this.calRdate = calRdate;
	}
	
	
	
	
}
