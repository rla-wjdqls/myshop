package kr.co.itwill.comment;

public class CommentDTO {

    private int cno;
    private int product_code;
    private String content;     
    private String wname;      
    private String regdate;
    
    
	public CommentDTO() {}


	public int getCno() {
		return cno;
	}


	public void setCno(int cno) {
		this.cno = cno;
	}


	public int getProduct_code() {
		return product_code;
	}


	public void setProduct_code(int product_code) {
		this.product_code = product_code;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getWname() {
		return wname;
	}


	public void setWname(String wname) {
		this.wname = wname;
	}


	public String getRegdate() {
		return regdate;
	}


	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	

	@Override
	public String toString() {
		return "CommentDTO [cno=" + cno + ", product_code=" + product_code + ", content=" + content + ", wname=" + wname
				+ ", regdate=" + regdate + "]";
	} 
	
    
	
	
	
}//class end
