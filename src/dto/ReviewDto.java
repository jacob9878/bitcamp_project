package dto;

import java.io.Serializable;

public class ReviewDto implements Serializable {
	private String memberID;
	private String trainerID;
	private String trainerReview;
	private String videoID;
	private String videoReview;
	
	
	
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
	public String getTrainerReview() {
		return trainerReview;
	}
	public void setTrainerReview(String trainerReview) {
		this.trainerReview = trainerReview;
	}
	public String getVideoID() {
		return videoID;
	}
	public void setVideoID(String videoID) {
		this.videoID = videoID;
	}
	public String getVideoReview() {
		return videoReview;
	}
	public void setVideoReview(String videoReview) {
		this.videoReview = videoReview;
	}
	
	
	
	
}
