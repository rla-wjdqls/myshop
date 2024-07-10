package kr.co.itwill.order;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.utility.Utility;

@Controller
@RequestMapping("/order")
public class OrderCont {

	public OrderCont() {
		System.out.println("----OrderCont()객체 생성됨");
	}//OrderCont() end
	
	@Autowired
	OrderDAO orderDao;
	
	
	@GetMapping("/orderform")
	public String orderForm() {
		return "/order/orderForm";
	}//orderForm() end
	
	
	@PostMapping("/insert")
	public ModelAndView orderInsert(OrderDTO orderDto, HttpSession session, HttpServletRequest req, HttpServletResponse resp) {
		
		ModelAndView mav = new ModelAndView();
		
		//String s_id = session.getAttribute("세션변수명"); //실제구현
		String s_id = "itwill"; //테스트용 임시 아이디
		
		//System.out.println(orderDto.toString());
		
		//1) 주문서 번호 생성하기
		//   예) 최초주문 202311231436151
		//	     있으면 202311231436152
		
		//오늘날짜 및 현재시각을 문자열 "년월일시분초"로 구성해서 반환하기
		//->예)20231123143615
		SimpleDateFormat sd = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = sd.format(new Date());
		//System.out.println(date); //결제버튼 누르면 출력 20231123160205
		
		String orderno = orderDao.orderno(date);
		if(orderno.equals("1")) { //최초주문
			orderno = date + "1"; //"20231123160205" + "1"
		}else {
			int n = Integer.parseInt(orderno.substring(14)) + 1; //맨마지막글자 + 1
			orderno = date + n;
		}//if end
		
		System.out.println(orderno);
		
		//2)총 결제금액 구하기
		int totalamount = orderDao.totalamount(s_id);
		//System.out.println(totalamount);
		
		
		//3)orderDto에 주문서번호, 총결제금액, 세션아이디 추가로 담기
		orderDto.setOrderno(orderno);
		orderDto.setTotalamount(totalamount);
		orderDto.setId(s_id);
		
		//System.out.println(orderDto.toString()); 
		//OrderDTO [orderno=202311241036391, id=itwill, totalamount=20000]
		
		
		//4)orderlist 테이블에 3)의 내용으로 행 추가하기
		int cnt = orderDao.orderlistInsert(orderDto);
		if(cnt==1) {
			
			//5)cart 테이블에 있는 주문상품을 orderdetail 테이블에 옮겨 담기
			HashMap<String, String> map = new HashMap<>();
			map.put("orderno", orderno);
			map.put("s_id", s_id);
			
			int result = orderDao.orderdetailInsert(map);
			
			if(result!=0) {
				//6)cart 테이블 비우기
				orderDao.cartDelete(s_id);
				
				//7)주문내역서 메일 보내기 : 과제
				
				try{
					//1)사용하고자 하는 메일서버에서 인증받은 계정과 비번 등록하기
					//->MyAuthenticator 클래스 생성
					
					//2)메일서버(POP3/SMTP) 지정하기
					String mailServer = "mw-002.cafe24.com"; //cafe24 메일서버
					Properties props = new Properties(); //props에 메일서버 담음
					props.put("mail.smtp.host", mailServer);
					props.put("mail.smtp.auth", true);
					
					//3)메일서버에서 인증받은 계정+비번
					Authenticator myAuth = new Authenticator() {}; //다형성
					
					//4) 2)와 3)이 유효한지 검증
					Session sess = Session.getInstance(props, myAuth); //클래스. 내장객체x
					System.out.println("메일 서버 인증 성공!");
					
					//5)메일 보내기
					req.setCharacterEncoding("UTF-8");
					String to = "www.rla-wjdqls@daum.net";//req.getParameter("to").trim();
					String from = "www.rla-wjdqls@daum.net";//req.getParameter("from").trim();
					String subject = "[Myshop]주문하신 내역 발송 드립니다.";//req.getParameter("subject").trim();
					String content = " ";//req.getParameter("content").trim();
					
					//엔터 및 특수문자 변경
					content = Utility.convertChar(content);
					
					//표작성
					content += "<hr>";
					content += "<table border='1'>";
					content += "<tr>";
					content += "	<th>상품명</th>";
					content += "	<th>상품가격</th>";
					content += "</tr>";
					content += "<tr>";
					content += "	<td>운동화</td>";
					content += "	<td><span style='color:red; font-weight:bold;'>15,000원</span></td>";
					content += "</tr>";
					content += "</table>";
					
					//이미지 출력하기
					content += "<hr>";
					content += "<img src='http://localhost:9090/myweb/images/angel.png'>";
					
					//받는 사람 이메일 주소
					InternetAddress[] address = {new InternetAddress(to)};
					
					//메일 관련 정보 작성
					Message msg = new MimeMessage(sess);
					
					//받는사람
					msg.setRecipients(Message.RecipientType.TO, address); 

					//보내는 사람
					msg.setFrom(new InternetAddress(from));
					
					//메일 제목
					msg.setSubject(subject);
					
					//메일 내용
					msg.setContent(content, "text/html; charset=UTF-8");
					
					//메일 보낸날짜
					msg.setSentDate(new Date());
					
					//메일 전송
					Transport.send(msg);

					System.out.println(to+"님에게 메일이 발송되었습니다");
					
				} catch(Exception e){
					System.out.println("<p>메일 전송 실패!"+e+"</p>");
					
					//out.println("<p>메일 전송 실패!"+e+"</p>");
					//out.println("<p><a href='javascript:history.back();'>[다시시도]</a></p>");
				}//end
				
				
				mav.addObject("msg1", "<img src='../images/logo_itwill.png'>");
				mav.addObject("msg2", "<p>주문이 완료되었습니다</p>");
				mav.addObject("msg3", "<p><a href='/product/list'>[계속쇼핑하기]</a></p>");
				
			}else {
				mav.addObject("msg1", "<img src='../images/fail.png'>");
				mav.addObject("msg2", "<p>주문 실패하였습니다</p>");
				mav.addObject("msg3", "<p><a href='javascript:history.back'>[다시시도]</a></p>");
			}//if end
			
		}else {
			mav.addObject("msg1", "<img src='../images/fail.png'>");
			mav.addObject("msg2", "<p>주문 실패하였습니다</p>");
			mav.addObject("msg3", "<p><a href='javascript:history.back'>[다시시도]</a></p>");
		}//if end
		
		mav.setViewName("/order/msgView"); // /WEB-INF/views/order/msgView.jsp
		
		return mav;
	}//orderInsert() end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}//class end
