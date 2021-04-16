package dto;

import java.io.Serializable;

public class CalendarDto implements Serializable{
	
	private int calSeq;
	private String memberId;
	private String calTitle;
	private String calContent;
	private String calWdate;	// 작성날짜
	private String calRdate;	// 예약 ? ? 날짜

	public CalendarDto() {
		
	}

	public CalendarDto(int calSeq, String memberId, String calTitle, String calContent, String calWdate,
			String calRdate) {
		super();
		this.calSeq = calSeq;
		this.memberId = memberId;
		this.calTitle = calTitle;
		this.calContent = calContent;
		this.calWdate = calWdate;
		this.calRdate = calRdate;
	}
	
	public CalendarDto(String memberId, String calTitle, String calContent, String calRdate) {
		super();
		this.memberId = memberId;
		this.calTitle = calTitle;
		this.calContent = calContent;
		this.calRdate = calRdate;
	}

	public int getCalSeq() {
		return calSeq;
	}

	public void setCalSeq(int calSeq) {
		this.calSeq = calSeq;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getCalTitle() {
		return calTitle;
	}

	public void setCalTitle(String calTitle) {
		this.calTitle = calTitle;
	}

	public String getCalContent() {
		return calContent;
	}

	public void setCalContent(String calContent) {
		this.calContent = calContent;
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

	@Override
	public String toString() {
		return "CalendarDto [calSeq=" + calSeq + ", memberId=" + memberId + ", calTitle=" + calTitle + ", calContent="
				+ calContent + ", calWdate=" + calWdate + ", calRdate=" + calRdate + "]";
	}
	
	
	
	
	
	
	
	
	
}
