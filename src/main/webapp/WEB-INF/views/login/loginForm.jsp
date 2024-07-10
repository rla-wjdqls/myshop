<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
    
<!DOCTYPE html>
<html lang="ko">
<head>
	  <title>loginForm.jsp</title>
	  <meta charset="utf-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	  <script src="/js/jquery-3.7.1.min.js"></script>
	  <link href="/css/main.css" rel="stylesheet" type="text/css">
</head>
<body>

<div class="p-5 bg-primary text-white text-center">
  <h1>My Shop</h1>
</div>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <div class="container-fluid">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link active" href="/product/list">상품</a>
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="/cart/list">장바구니</a>
      </li>
    </ul>
  </div>
</nav>

<div class="container text-center">
  <!-- 본문시작 -->
<%
			Cookie[] cookies = request.getCookies();//사용자 PC에 저장된 모든 쿠키값 가져오기
			String c_id = "";
			if(cookies != null){ //쿠키값들이 존재하는지?
				for(int i=0; i<cookies.length; i++){
				   Cookie cookie = cookies[i]; //쿠키 하나씩 가져오기
				   if(cookie.getName().equals("c_id")==true){
					   c_id = cookie.getValue(); //쿠키 변수값 가져오기
				   }//if end
				}//for end
			}//if end
%> 

  <div class="row">
    <div class="col-sm-12">
    <!--onsubmit="return loginCheck()-->
	<form name="loginfrm" id="loginfrm" method="post" action="loginProc">
		<table class="table">
			<tr>
				<td>
					<input type="text" name="id" id="id" value="<%=c_id%>" placeholder="아이디" maxlength="10" required autofocus>
				</td> 
				<td rowspan="2">
				    <!-- type=image는 기본속성이 submit -->
				    <input type="image" name="loginbtn" id="loginbtn" src="../images/bt_login.gif" height="75">
				</td>
			</tr>
			<tr>
				<td>
				    <input type="password" name="passwd" id="passwd" placeholder="비밀번호" maxlength="10" required>
				</td>
			</tr>
			<tr>
				<td colspan="2">
 				<div class="checkbox">				
			       <label><input type="checkbox" id="c_id" name="c_id" value="SAVE" <%if(!c_id.isEmpty()) {out.print("checked");}%>>&nbsp;ID 저장</label>
			    </div> 
				    &nbsp;&nbsp;&nbsp;
				    <a href="agreement">회원가입</a>
				    &nbsp;&nbsp;
				    <a href="findID">아이디/비밀번호찾기</a>			    
				</td>
			</tr>
		</table>
	</form>
    </div><!-- col end -->
  </div><!-- row end -->
  



  
    <!-- 본문 끝 -->
    
</div><!-- container end -->
  
<div class="mt-5 p-4 bg-dark text-white text-center">
  <p>ITWILL 아이티윌 교육센터</p>
</div>
 
 
 
 
 
</body>
</html>











