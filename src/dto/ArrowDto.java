package dto;

public class ArrowDto {
	
	int depth;
	String arrow;
	
	
	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String getArrow(){
		String rs = "<img src='./image/arrow.png' width='20px' height='20px'/>";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";	// 여백
		
		String ts = "";
		for(int i = 0;i < depth; i++){
			ts += nbsp;
		}
		
		return depth==0 ? "":ts + rs;	
	}
}
