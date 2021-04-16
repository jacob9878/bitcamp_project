package dto;

public class ExDto {
   
      private int exSeq ;
      private String exName ;
      private String exPart;
      private String exType ;
      private int exDiff;
      private String exContent;
      private String exImg;
      private String exAdr;
      private int exLike;
       

public ExDto(String exName, String exPart, String exType, int exDiff, String exImg, int exSeq) {
         super();
         this.exName = exName;
         this.exPart = exPart;
         this.exType =exType;
         this.exDiff = exDiff;
         this.exImg = exImg;
         this.exSeq = exSeq;
      }  
   
   public ExDto(int exSeq, String exName, String exPart, String exType, int exDiff, String exContent,
         String exAdr, String exImg, int exLike) {
      super();
      this.exSeq = exSeq;
      this.exName = exName;
      this.exPart = exPart;
      this.exType = exType;
      this.exDiff = exDiff;
      this.exContent = exContent;
      this.exAdr = exAdr;
      this.exImg = exImg;
      this.exLike = exLike;
   }

   
   
   public int getExSeq() {
      return exSeq;
   }


   public void setExSeq(int exSeq) {
      this.exSeq = exSeq;
   }


   public String getExName() {
      return exName;
   }


   public void setExName(String exName) {
      this.exName = exName;
   }


   public String getExPart() {
      return exPart;
   }


   public void setExPart(String exPart) {
      this.exPart = exPart;
   }


   public String getExType() {
      return exType;
   }


   public void setExType(String exType) {
      this.exType = exType;
   }


   public int getExDiff() {
      return exDiff;
   }


   public void setExDiff(int exDiff) {
      this.exDiff = exDiff;
   }


   public String getExContent() {
      return exContent;
   }


   public void setExContent(String exContent) {
      this.exContent = exContent;
   }


   public String getExImg() {
      return exImg;
   }


   public void setExImg(String exImg) {
      this.exImg = exImg;
   }


   public String getExAdr() {
      return exAdr;
   }


   public void setExAdr(String exAdr) {
      this.exAdr = exAdr;
   }

   public int getExLike() {
		return exLike;
	}

	public void setExLike(int exLike) {
		this.exLike = exLike;
	}

}