package dto;

import java.io.Serializable;

public class ReviewDto implements Serializable {
	private String memberID;
	private String trainerID;
	private String trComment;
	private String exSeq;
	private String exComment;
	private String rvDate;
	private int rvSeq;
	
	
	// 운동리뷰 
	public ReviewDto(String memberID, String exComment, String rvDate, int rvSeq) {
		super();
		this.memberID = memberID;
		this.exComment = exComment;
		this.rvDate = rvDate;
		this.rvSeq = rvSeq;
	}

	
	public int getRvSeq() {
		return rvSeq;
	}


	public void setRvSeq(int rvSeq) {
		this.rvSeq = rvSeq;
	}


	public String getRvDate() {
		return rvDate;
	}

	public void setRvDate(String rvDate) {
		this.rvDate = rvDate;
	}

	public String getMemberID() {
		return memberID;
	}

	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}

	public String getTrainerID() {
		return trainerID;
	}

	public void setTrainerID(String trainerID) {
		this.trainerID = trainerID;
	}

	public String getTrComment() {
		return trComment;
	}

	public void setTrComment(String trComment) {
		this.trComment = trComment;
	}


	public String getExSeq() {
		return exSeq;
	}

	public void setExSeq(String exSeq) {
		this.exSeq = exSeq;
	}

	public String getExComment() {
		return exComment;
	}

	public void setExComment(String exComment) {
		this.exComment = exComment;
	}

	
}
