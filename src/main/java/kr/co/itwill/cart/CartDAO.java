package kr.co.itwill.cart;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CartDAO {

	public CartDAO() {
		System.out.println("----CartDAO()객체 생성됨");
	}//end
	

@Autowired
SqlSession sqlSession;


public int cartInsert(CartDTO cartDto) {
	return sqlSession.insert("cart.insert", cartDto);
}//cartInsert() end


public List<CartDTO> cartList(String s_id){
	return sqlSession.selectList("cart.list2", s_id);
}//cartList() end


public int cartDelete(HashMap<String, Object> map) {
	return sqlSession.delete("cart.delete", map);
}//cartDelete() end















	
}//class end
