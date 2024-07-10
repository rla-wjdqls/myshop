package kr.co.itwill.comment;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Repository
public class CommentDAO {

	public CommentDAO() {
		System.out.println("----CommentDAO() 객체 생성됨");
	}//end
	
	@Autowired
	SqlSession sqlSession;
	
	
	public int commentInsert(CommentDTO comment) {
		return sqlSession.insert("comment.insert", comment);
	}//commentInsert() end

		
	
	public List<CommentDTO> commentList(int product_code) {
		return sqlSession.selectList("comment.list", product_code);
	}//commentList() end
	
		
	
	public int commentUpdate(CommentDTO commeDto) {
		return sqlSession.update("comment.update", commeDto);
	}//commentUpdate() end
	
	
	public int commentDelete(int cno) throws Exception {
		return sqlSession.delete("comment.delete", cno);
	}//commentDelete() end
	
	
	
	
	
	
	
	
	
	
	
	
	
}//class end




