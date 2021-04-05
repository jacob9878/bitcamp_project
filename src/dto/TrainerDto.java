package dto;

import java.io.Serializable;

public class TrainerDto implements Serializable {

	private int seq;	// 게시판 번호 (bbsDto seq와 같다)
	private int price1;	// PT 1회 가격
	private int price10;	// PT 10회 가격
	private int price30;	// PT 30회 가격
	private String gymLocation;	// 카카오지도 헬스장 좌표
	private String instaLink;	// 트레이너의 인스타 주소
	private String faceLink;	// 트레이너의 페이스북 주소
	
	
	public TrainerDto(int seq, int price1, int price10, int price30, String gymLocation, String instaLink,
			String faceLink) {
		super();
		this.seq = seq;
		this.price1 = price1;
		this.price10 = price10;
		this.price30 = price30;
		this.gymLocation = gymLocation;
		this.instaLink = instaLink;
		this.faceLink = faceLink;
	}

	

	public TrainerDto(int price1, int price10, int price30, String gymLocation, String instaLink, String faceLink) {
		super();
		this.price1 = price1;
		this.price10 = price10;
		this.price30 = price30;
		this.gymLocation = gymLocation;
		this.instaLink = instaLink;
		this.faceLink = faceLink;
	}



	public int getSeq() {
		return seq;
	}


	public void setSeq(int seq) {
		this.seq = seq;
	}


	public int getPrice1() {
		return price1;
	}


	public void setPrice1(int price1) {
		this.price1 = price1;
	}


	public int getPrice10() {
		return price10;
	}


	public void setPrice10(int price10) {
		this.price10 = price10;
	}


	public int getPrice30() {
		return price30;
	}


	public void setPrice30(int price30) {
		this.price30 = price30;
	}


	public String getGymLocation() {
		return gymLocation;
	}


	public void setGymLocation(String gymLocation) {
		this.gymLocation = gymLocation;
	}


	public String getInstaLink() {
		return instaLink;
	}


	public void setInstaLink(String instaLink) {
		this.instaLink = instaLink;
	}


	public String getFaceLink() {
		return faceLink;
	}


	public void setFaceLink(String faceLink) {
		this.faceLink = faceLink;
	}
	
	
	
	
	
}
