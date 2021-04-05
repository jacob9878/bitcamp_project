package dto;

import java.io.Serializable;

public class ExDto implements Serializable{
	private String videoId;				// 운동영상 고유ID
	private int part;					// 운동 분류중 부위
	private int difficulty;			 	// 운동 분류중 난이도				
	private int type;					// 운동 분류중 종류
	
	
	
	public String getVideoId() {
		return videoId;
	}
	public void setVideoId(String videoId) {
		this.videoId = videoId;
	}
	public int getPart() {
		return part;
	}
	public void setPart(int part) {
		this.part = part;
	}
	public int getDifficulty() {
		return difficulty;
	}
	public void setDifficulty(int difficulty) {
		this.difficulty = difficulty;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	
	
	
	
}
