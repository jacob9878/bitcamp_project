package dto;

import java.io.Serializable;

public class BadgeDto implements Serializable{

	private String memberID;		
	private int yogaCount;			// 요가 뱃지?
	private int weightCount;		// 다이어트??
	private int cardidCount;		
	private int pialaCount;			// 필라테스
	
	
	
	public String getMemberID() {
		return memberID;
	}
	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}
	public int getYogaCount() {
		return yogaCount;
	}
	public void setYogaCount(int yogaCount) {
		this.yogaCount = yogaCount;
	}
	public int getWeightCount() {
		return weightCount;
	}
	public void setWeightCount(int weightCount) {
		this.weightCount = weightCount;
	}
	public int getCardidCount() {
		return cardidCount;
	}
	public void setCardidCount(int cardidCount) {
		this.cardidCount = cardidCount;
	}
	public int getPialaCount() {
		return pialaCount;
	}
	public void setPialaCount(int pialaCount) {
		this.pialaCount = pialaCount;
	}
	
}
