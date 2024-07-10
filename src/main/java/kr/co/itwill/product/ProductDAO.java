package kr.co.itwill.product;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAO {

	public ProductDAO() {
		System.out.println("----ProductDAO() 객체 생성됨");
	}//end
	
	//스프링 빈으로 자동 생성된 객체를 가져와서 연결하기 (Spring09MyshopApplication 클래스 참조)
	@Autowired
	SqlSession sqlSession;
	
	public void insert(Map<String, Object> map) {
		sqlSession.insert("product.insert", map);
	}//insert() end
	
	
	public List<Map<String, Object>> list(){
		return sqlSession.selectList("product.list");
	}//list() end

	
	public List<Map<String, Object>> search(String product_name) { //검색어
		//영문자일 경우 대소문자 구분없이
		//return sqlSession.selectList("product.search", "%" + product_name.toUpperCase() + "%");
		return sqlSession.selectList("product.search", "%" + product_name + "%");
	}//search() end
	

	public Map<String, Object> detail(int product_code){
//		System.out.println("dao");
//		System.out.println(product_code);
		return sqlSession.selectOne("product.detail", product_code);
	}//detail() end
	
	
	public String filename(int product_code){
		return sqlSession.selectOne("product.filename", product_code);
	}//filename() end
	
	
	public void delete(int product_code){
		sqlSession.delete("product.delete", product_code);
	}//detail() end
	
	
	public void update(Map<String, Object> map) {
		sqlSession.update("product.update", map);
	}//update() end
	
	
	
	
	
	
	
}//class end





