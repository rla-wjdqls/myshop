package kr.co.itwill.login;

import java.io.PrintStream;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oracle.wls.shaded.org.apache.bcel.classfile.Utility;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import net.utility.*;

@Controller
@RequestMapping("/login")
public class LoginCont {

	public LoginCont() {
		System.out.println("----LoginCont()객체 생성됨");
	}//LoginCont() end
	
	@Autowired
	LoginDAO loginDao;
	
	//로그인 페이지 이동
	 @GetMapping("/loginForm") 
	 public ModelAndView login(HttpSession session) {
		 ModelAndView mav = new ModelAndView();
		 if(session.getAttribute("s_id")==null || session.getAttribute("s_passwd")==null || session.getAttribute("s_mlevel")==null) {
			 mav.setViewName("login/loginForm");
		 }else {
			 mav.setViewName("login/loginResult");
		 }//if end
		 return mav;
	 }//login() end
	 
	 
	//로그인 폼 전송
	 @PostMapping("/loginProc")
	 public ModelAndView loginProc(HttpServletRequest req, HttpServletResponse resp, LoginDTO logindto, HttpSession session) {
		 
		 System.out.println(logindto.getId()); 		//korea
		 System.out.println(logindto.getPasswd());	//12345
		 
		 String mlevel = loginDao.loginProc(logindto);
		 System.out.println(mlevel); //null
		 
		 ModelAndView mav = new ModelAndView();
	
		 if(mlevel==null){  //로그인 실패했을 때
			 	mav.setViewName("login/msgView");
				req.setAttribute("message", "<p>아이디/비밀번호가 일치하지 않습니다</p>");
				req.setAttribute("link", "<a href='javascript:history.back()'>[다시시도]</a>");
		 }else{ 	//로그인 성공했을 때 -> 아이디:itwill 비밀번호:1234
			 
				//다른 페이지에서도 로그인 상태 정보 공유할 수 있도록 session 전역변수에 값 올리기
				session.setAttribute("s_id", logindto.getId());
				session.setAttribute("s_passwd", logindto.getPasswd());
				session.setAttribute("s_mlevel", mlevel);
				//session.setMaxInactiveInterval(60 * 30); //세션 유지시간 설정

				//쿠키 시작--------------------------------------------------------------
				//<input type="checkbox" name="c_id" value="SAVE">ID저장	
				String c_id=net.utility.Utility.checkNull(req.getParameter("c_id")); //id저장 클릭
				//System.out.println(c_id); //SAVE
				Cookie cookie = null;
				//System.out.println(logindto.getId()); //itwill, webmaster
				
				if(c_id.equals("SAVE")){ //ID저장에 체크 했다면
					//쿠키변수 선언 new Cookie("변수명", 값)
					cookie = new Cookie("c_id", logindto.getId()); //c_id에 로그인 성공한 아이디 저장됨
					
					//쿠키 생존기간 1개월
					cookie.setMaxAge(60*60*24*30); //각 브라우저의 쿠키 삭제 영향을 받는다				
				}else{
					cookie = new Cookie("c_id", "");
					cookie.setMaxAge(0);
				}//if end
				
				//요청한 사용자 PC에 쿠키값 저장
				resp.addCookie(cookie);								
				
				//쿠키 끝---------------------------------------------------------------
				mav.setViewName("login/loginResult");	
		}//if end
 
		 return mav;  
	 }//loginProc() end 


	@GetMapping("/agreement")
	public String agreement() {
		return "login/agreement";
	}//agreement() end
	
	
	@RequestMapping("/memberForm")
	public String memberForm() {
		return "login/memberForm";
	}//memberForm() end
	

	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		
		session.removeAttribute("s_id");
		session.removeAttribute("s_passwd");
		session.removeAttribute("s_mlevel");
		
		return "redirect:/login/loginForm";
	}//logout()
	
	/*
	@GetMapping("/idCheckProc")
	public ModelAndView idCheckProc(HttpServletRequest req, String id) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/login/idCheckProc");
		
		String d_id = id;
		//System.out.println(d_id+1);
		int cnt = loginDao.duplicateID(d_id);
		//"입력ID: <strong>"+id+"</strong>"
		
		if(cnt==0) { //아이디 사용가능
			//System.out.println("사용 가능한 아이디입니다");
			mav.addObject("msg1", "<p>사용 가능한 아이디입니다</p>");
			mav.addObject("msg2", "<p><a href='javascript:alert()'>[적용]</a></p>");
			//System.out.println(d_id+2);
			//Uncaught ReferenceError: d_id is not defined
		}else {	     //아이디 사용 불가능
			//System.out.println("해당 아이디는 사용할 수 없습니다");
			mav.addObject("msg1", "<p style='color:red'>해당 아이디는 사용할 수 없습니다</p>");
		}//if end 
		
		return mav;
	}//idCheckProc() end
	*/
	
	@PostMapping("/idcheckcookieproc")
	@ResponseBody
	public String idCheckCookieProc(HttpServletRequest req) {
		String id = req.getParameter("id").trim(); //itwill
		String cnt =loginDao.idDuplicate(id); //"1"
		
		//System.out.println(cnt);	
		//JSON 응답----------------------------------------------------------
		//https://mvnrepository.com에서 json-simple검색후, pom.xml에 의존성 추가해야 함
		JSONObject json = new JSONObject();
		json.put("count1", cnt); //key, value
		return json.toString();
	}//idCheckcookieProc() end
	
	
	@PostMapping("/emailcheckcookieproc")
	@ResponseBody
	public String emailCheckCookieProc(HttpServletRequest req) {
		
		String email = req.getParameter("email").trim(); 
		String cnt =loginDao.emailDuplicate(email); //"1"

		JSONObject json = new JSONObject();
		json.put("count2", cnt); 
		return json.toString();
	}//emailCheckcookieProc() end
	
	
	@PostMapping("/insert")
	public String insert(HttpServletRequest req) {
		LoginDTO loginDto = new LoginDTO();
		
		loginDto.setId(req.getParameter("id"));
		loginDto.setPasswd(req.getParameter("passwd"));
		loginDto.setWname(req.getParameter("wname"));
		loginDto.setTel(req.getParameter("tel"));
		loginDto.setEmail(req.getParameter("email"));
		loginDto.setZipcode(req.getParameter("zipcode"));
		loginDto.setAddress1(req.getParameter("address1"));
		loginDto.setAddress2(req.getParameter("address2"));
		
		loginDao.loginInsert(loginDto);
		
		return "redirect:/login/loginForm";
	}//insert() end
	
	
	
	
	
}//class end









