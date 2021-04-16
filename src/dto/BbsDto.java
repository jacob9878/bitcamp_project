package dto;

import java.io.Serializable;

public class BbsDto implements Serializable{
	private String memberId;
	private int seq;
	private int ref;
	private int step;
	private int depth;
	private String title;
	private String content;
	private String wdate;
	private int del;
	private int readcount;
	private int likecount;
	private String img;
	private String division;
	private int bbstype;
	private String memProfileImg;
	private String trainerPrice;
	private String newfilename;
	private int memLevel;
	
	
	
	
	public int getMemLevel() {
		return memLevel;
	}

	public void setMemLevel(int memLevel) {
		this.memLevel = memLevel;
	}

	public BbsDto() {
	}
	
	public BbsDto(String memberid, String title, String content) {
		super();
		this.memberId = memberid;
		this.title = title;
		this.content = content;
	}
	
	public BbsDto(String memberId, String title, String content, String img, String division) {
		super();
		this.memberId = memberId;
		this.title = title;
		this.content = content;
		this.img = img;
		this.division = division;
		
	}
	
	public BbsDto(String memberId, String title, String content, String img, String newFilename, String division) {
		super();
		this.memberId = memberId;
		this.title = title;
		this.content = content;
		this.img = img;
		this.newfilename = newFilename;
		this.division = division;
	}
	
	
	public BbsDto(String memberId, String title, String content, String img, String division, int bbstype) {
		super();
		this.memberId = memberId;
		this.title = title;
		this.content = content;
		this.img = img;
		this.division = division;
		this.bbstype = bbstype;
	}

	
	public BbsDto(int seq, String title, String content, String img,String newFilename, String division) {
		super();
		this.seq = seq;
		this.title = title;
		this.content = content;
		this.img = img;
		this.division = division;
		this.newfilename = newFilename;
	}
	

	public BbsDto(String memberId, int seq, int ref, int step, int depth, String title, String content, String wdate,
			int del, int readcount, int likecount, String img, String division, int bbstype, String memProfileImg,
			String trainerPrice, String newfilename) {
		super();
		this.memberId = memberId;
		this.seq = seq;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.del = del;
		this.readcount = readcount;
		this.likecount = likecount;
		this.img = img;
		this.division = division;
		this.bbstype = bbstype;
		this.memProfileImg = memProfileImg;
		this.trainerPrice = trainerPrice;
		this.newfilename = newfilename;
	}

	public BbsDto(String memberId, int seq, int ref, int step, int depth, String title, String content, String wdate,
			int del, int readcount, int likecount, String img, String division, int bbstype, int memLevel) {
		super();
		this.memberId = memberId;
		this.seq = seq;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.del = del;
		this.readcount = readcount;
		this.likecount = likecount;
		this.img = img;
		this.division = division;
		this.bbstype = bbstype;
		this.memLevel= memLevel;
	}
	
	

	public BbsDto(String memberId, int seq, int ref, int step, int depth, String title, String content, String wdate,
			int del, int readcount, int likecount, String img, String newFilename, String division, int bbstype) {
		super();
		this.memberId = memberId;
		this.seq = seq;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.del = del;
		this.readcount = readcount;
		this.likecount = likecount;
		this.img = img;
		this.division = division;
		this.bbstype = bbstype;
		this.newfilename = newFilename;
	}



	public BbsDto(String memberId, String title, String content, String img, String newfilename, String division,
			int bbstype) {
		super();
		this.memberId = memberId;
		this.title = title;
		this.content = content;
		this.img = img;
		this.newfilename = newfilename;
		this.division = division;
		this.bbstype = bbstype;
	}
	
	

	public BbsDto(String memberId, int seq, int ref, int step, int depth, String title, String content, String wdate,
			int del, int readcount, int likecount, String img, String division, int bbstype, String memProfileImg,
			String trainerPrice) {
		super();
		this.memberId = memberId;
		this.seq = seq;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.del = del;
		this.readcount = readcount;
		this.likecount = likecount;
		this.img = img;
		this.division = division;
		this.bbstype = bbstype;
		this.memProfileImg = memProfileImg;
		this.trainerPrice = trainerPrice;
	}

	
	
	
	
	public String getNewfilename() {
		return newfilename;
	}

	public void setNewfilename(String newfilename) {
		this.newfilename = newfilename;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public int getDel() {
		return del;
	}

	public void setDel(int del) {
		this.del = del;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public int getLikecount() {
		return likecount;
	}

	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public int getBbstype() {
		return bbstype;
	}

	public void setBbstype(int bbstype) {
		this.bbstype = bbstype;
	}


	public String getMemProfileImg() {
		return memProfileImg;
	}

	public void setMemProfileImg(String memProfileImg) {
		this.memProfileImg = memProfileImg;
	}

	public String getTrainerPrice() {
		return trainerPrice;
	}

	public void setTrainerPrice(String trainerPrice) {
		this.trainerPrice = trainerPrice;
	}

	@Override
	public String toString() {
		return "BbsDto [memberId=" + memberId + ", seq=" + seq + ", ref=" + ref + ", step=" + step + ", depth=" + depth
				+ ", title=" + title + ", content=" + content + ", wdate=" + wdate + ", del=" + del + ", readcount="
				+ readcount + ", likecount=" + likecount + ", img=" + img + ", division=" + division + ", bbstype="
				+ bbstype + ", memProfileImg=" + memProfileImg + ", trainerPrice=" + trainerPrice + "]";
	}

	
	
	
	
	
}
