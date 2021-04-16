package dto;

import java.io.Serializable;

public class MemberDto implements Serializable{
   
   private String memberID;            // 회원아이디
   private String pwd;                  // 비밀번호
   private String email;               // 이메일
   private String name;               // 이름
   private String phoneNum;            // 전화번호
   private String gender;               // 성별
   private String trainerID;            // 트레이너 고유ID   Trainer table과 join
   private String profileImg;             // 프로필 이미지
   private int age;                  // 나이
   private double height;               // 키
   private double gWeight;               // 목표 몸무게
   private int memLevel;               // 점수
   private int memType;               // 회원타입
   private String gymName;               // 헬스장이름(트레이너가 일하는곳)
   private String trainerContent;         // 트레이너 소개, 내용, 정보 
   private double weight;               // 몸무게
   private int count;
   

   
   public MemberDto(String memberID, String pwd, String email, String name, String phoneNum, String gender,
         String trainerID, String profileImg, int age, double height, double gWeight, int memLevel, int memType,
         String gymName, String trainerContent, double weight, int count) {
      super();
      this.memberID = memberID;
      this.pwd = pwd;
      this.email = email;
      this.name = name;
      this.phoneNum = phoneNum;
      this.gender = gender;
      this.trainerID = trainerID;
      this.profileImg = profileImg;
      this.age = age;
      this.height = height;
      this.gWeight = gWeight;
      this.memLevel = memLevel;
      this.memType = memType;
      this.gymName = gymName;
      this.trainerContent = trainerContent;
      this.weight = weight;
      this.count = count;
   }

   
   

   public MemberDto(String memberID, String email, String name, int memType) {
      super();
      this.memberID = memberID;
      this.email = email;
      this.name = name;
      this.memType = memType;
   }
   

   
	public MemberDto(String memberID, String email, String name, String gender, String profileImg, int age) {
		super();
		this.memberID = memberID;
		this.email = email;
		this.name = name;
		this.gender = gender;
		this.profileImg = profileImg;
		this.age = age;
	}





	public MemberDto(String memberID, String name, String email,  String gender, String trainerID, int age, int memLevel) {
		super();
		this.memberID = memberID;
		this.email = email;
		this.name = name;
		this.gender = gender;
		this.trainerID = trainerID;
		this.age = age;
		this.memLevel = memLevel;
	}
	
	
	public MemberDto(String memberID, String name, String email,  String gender, String profileImg, int age, int memLevel, String gymName) {
		super();
		this.memberID = memberID;
		this.name = name;
		this.email = email;
		this.gender = gender;
		this.profileImg = profileImg;
		this.age = age;
		this.memLevel = memLevel;
		this.gymName = gymName;
	}


   
   

   public void setCount(int count) {
      this.count = count;
   }



   public int getCount() {
      return count;
   }



   public String getMemberID() {
      return memberID;
   }


   public void setMemberID(String memberID) {
      this.memberID = memberID;
   }


   public String getPwd() {
      return pwd;
   }


   public void setPwd(String pwd) {
      this.pwd = pwd;
   }


   public String getEmail() {
      return email;
   }


   public void setEmail(String email) {
      this.email = email;
   }


   public String getName() {
      return name;
   }


   public void setName(String name) {
      this.name = name;
   }


   public String getPhoneNum() {
      return phoneNum;
   }


   public void setPhoneNum(String phoneNum) {
      this.phoneNum = phoneNum;
   }


   public String getGender() {
      return gender;
   }


   public void setGender(String gender) {
      this.gender = gender;
   }


   public String getTrainerID() {
      return trainerID;
   }


   public void setTrainerID(String trainerID) {
      this.trainerID = trainerID;
   }


   public String getProfileImg() {
      return profileImg;
   }


   public void setProfileImg(String profileImg) {
      this.profileImg = profileImg;
   }


   public int getAge() {
      return age;
   }


   public void setAge(int age) {
      this.age = age;
   }


   public double getHeight() {
      return height;
   }


   public void setHeight(double height) {
      this.height = height;
   }


   public double getgWeight() {
      return gWeight;
   }


   public void setgWeight(double gWeight) {
      this.gWeight = gWeight;
   }


   public int getMemLevel() {
      return memLevel;
   }


   public void setMemLevel(int memLevel) {
      this.memLevel = memLevel;
   }


   public int getMemType() {
      return memType;
   }


   public void setMemType(int memType) {
      this.memType = memType;
   }


   public String getGymName() {
      return gymName;
   }


   public void setGymName(String gymName) {
      this.gymName = gymName;
   }


   public String getTrainerContent() {
      return trainerContent;
   }


   public void setTrainerContent(String trainerContent) {
      this.trainerContent = trainerContent;
   }


   public double getWeight() {
      return weight;
   }


   public void setWeight(double weight) {
      this.weight = weight;
   }



   
   
   
}