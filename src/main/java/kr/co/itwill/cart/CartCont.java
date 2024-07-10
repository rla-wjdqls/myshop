package kr.co.itwill.cart;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.co.itwill.login.LoginDTO;

@Controller
public class CartCont {

	public CartCont() {
		System.out.println("----CartCont()객체 생성됨");
	}//end
	
	@Autowired
	CartDAO cartDao;	

	
	@PostMapping("/cart/insert")
	public String cartInsert(CartDTO cartDto, HttpSession session) {
		//로그인 기능을 구현했다면 session.getAttribute() 활용
		//cartDto.setId(session.getAttribute("s_id"));
		cartDto.setId("itwill"); //여기서는 임시로 "itwiill"
		cartDao.cartInsert(cartDto);
		
		return "redirect:/cart/list"; //장바구니 목록페이지 호출
	}//cartInsert() end


	@RequestMapping("/cart/list")
	public ModelAndView list(HttpSession session) {
		//로그인 했다면
		//String s_id = session.getAttribute("s_id")
		String s_id = "itwill"; //테스트용 임시 아이디 "itwill"
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("cart/list"); //WEB-INF/views/cart/list.jsp
		mav.addObject("list", cartDao.cartList(s_id));
		return mav;
	}//list() end
	
	
	@GetMapping("/cart/delete")
	public String delete(int cartno, HttpServletRequest req, HttpSession session) {
		/*
			CartDTO cartDto = new CartDTO();
			cartDto.setCartno(cartno);
			cartDto.setId(session.getAttribute("세션변수명"));
			cartDao.cartDelete(cartDto);
		*/
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("no", cartno);
		map.put("s_id", "itwill");
		//세션에 올려놓은 값 사용할 시 -> map.put("s_id", session.getAttribute("세션변수명"));
		cartDao.cartDelete(map);
		return "redirect:/cart/list";
	}//delete() end
	
	
	//http://localhost:9095/product/detail/5
	@GetMapping("/detail/{product_code}") 
	public ModelAndView detail(@PathVariable int product_code) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/detail");
		//mav.addObject("product", cartDao.detail(product_code));
		return mav;
	}//detail() end
	

	
}//class end

















