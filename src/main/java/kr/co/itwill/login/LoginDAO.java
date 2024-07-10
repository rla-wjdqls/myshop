package kr.co.itwill.login;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAO {

	public LoginDAO() {
		System.out.println("----LoginDAO() 객체 생성됨");
	}//end

	
	@Autowired
	SqlSession sqlSession;
	
	public String loginProc(LoginDTO logindto) {
		return sqlSession.selectOne("login.check", logindto);
	}//loginProc() end
	
	public int loginInsert(LoginDTO logindto) {
		return sqlSession.insert("login.insert", logindto);
	}//loginInsert() end

	public String idDuplicate(String id) {
		return sqlSession.selectOne("login.idDuplicate", id);
	}//idDuplicate() end

	public String emailDuplicate(String email) {
		return sqlSession.selectOne("login.emailDuplicate", email);
	}//idDuplicate() end

	
}//class end












