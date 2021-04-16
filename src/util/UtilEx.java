package util;

import java.util.List;

import dto.CalendarDto;

public class UtilEx {

	// 한문자를 두문자로 변경해 주는 함수	2021 03 19	-> 1 ~ 9 -> 01 ~ 09
	public static String two(String msg) {
		return msg.trim().length()<2?"0"+msg.trim():msg.trim();
	}
	
	// 날짜를 클릭하면 controller의 param = callist로 이동
	
		public static String callist(int year, int month, int day) {
			String str = "";
			
			str += String.format("&nbsp;<a href='%s&year=%d&month=%d&day=%d'>", 
											"calendar?param=callist", year, month, day);
			str += String.format("%2d", day);
			str += "</a>";
			
			// <a href='callist.jsp?year=2021&month=3&day=19'>19</a>
			return str;
		}
		
		/*
		public static String callist(int year, int month, int day) {
			String str = "";
			
			str += String.format("&nbsp;<a href='%s&year=%d&month=%d&day=%d' data-toggle='modal' data-target='#callist-modal' class='login-btn'>",
					"calendar?param=callist", year, month, day);
			str += String.format("%2d", day);
			str += "</a>";
			
			// <a href='callist.jsp?year=2021&month=3&day=19'>19</a>
			return str;
		}
		*/
		
		// 일정을 추가하기 위해서 pen이미지를 클릭하면 calwrite.jsp로 이동하는 함수
		public static String showPen(int year, int month, int day) {
			String str = "";
			
			String image = "<i class='fa fa-pencil' aria-hidden='true'></i>";
			
			str = String.format("<a href='%s&year=%d&month=%d&day=%d'>%s</a>", 
					"calendar?param=calwrite", year, month, day, image);
		
			
			return str;		
		}
		
		
		// nvl 함수 : 문자열이 비어 있는지 확인 함수
		public static boolean nvl(String msg) {
			return msg == null || msg.trim().equals("")?true:false;
		}
		
		// 달력의 날짜 별로 설정할 테이블을 작성하는 함수
		public static String makeTable(int year, int month, int day, List<CalendarDto> list) {
			String str = "";
			
			// 2021 3 19	-> 20210319
			String dates = (year + "") + two(month + "") + two(day + "");
			
			
			for(CalendarDto dto : list) {
				if(dto.getCalRdate().substring(0, 8).equals(dates)) {
								
					str += "<a href='calendar?param=caldetail&seq=" + dto.getCalSeq() + "' style='font-size: 10pt; color:black; font-weight:bold;'>";				
					str += dot3(dto.getCalTitle());				
					str += "</a>";
					str += "<br>";
					
				}			
			}		
			
			
			return str;
		}
		
		// 일정의 제목이 길 때 ...로 처리하는 함수		CGV에서 데이트 약속 -> CGV에서... 
		public static String dot3(String msg) {
			String str = "";
			if(msg.length() > 7) {
				str = msg.substring(0, 7);
				str += "...";
			}else {
				str = msg.trim();
			}		
			return str;
		}
	
	
	
	
}
