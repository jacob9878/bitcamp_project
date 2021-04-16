package dto;

public class DweightDto {

	private String memberID;
	private String wDate;
	private double dWeight;
	
	public DweightDto(String memberID, String wDate, double dWeight) {
		super();
		this.memberID = memberID;
		this.wDate = wDate;
		this.dWeight = dWeight;
	}

	public String getMemberID() {
		return memberID;
	}

	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}

	public String getwDate() {
		return wDate;
	}

	public void setwDate(String wDate) {
		this.wDate = wDate;
	}

	public double getdWeight() {
		return dWeight;
	}

	public void setdWeight(double dWeight) {
		this.dWeight = dWeight;
	}
	
	
}
