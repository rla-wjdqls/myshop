<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
    
<!DOCTYPE html>
<html lang="ko">
<head>
	  <title>write.jsp</title>
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
        <a href="/login/loginForm" class="nav-link active">로그인</a>
      </li>
      <li class="nav-item">
        <a href="/product/list" class="nav-link active">상품</a>
      </li>
      <li class="nav-item">
        <a href="/cart/list" class="nav-link active">장바구니</a>
      </li>
    </ul>
  </div>
</nav>

<div class="container text-center">
  <!-- 본문시작 -->

  <div class="row">
    <div class="col-sm-12">
    	<p><h3>상품목록</h3></p>
		<p>
			<button type="button" onclick="location.href='list'" class="btn btn-primary">상품전체목록</button>
		</p>
    </div><!-- col end -->
  </div><!-- row end -->
  
    <div class="row">
    <div class="col-sm-12">
    	<form name="productfrm" id="product" method="post" action="insert" enctype="multipart/form-data">
			<table class="table table-hover">
		   	 <tbody style="text-align: left;">
			    <tr>
					<td>상품명</td>
					<td> <input type="text" name="product_name" class="form-control"> </td>
			    </tr>
			    <tr>
					<td>상품가격</td>
					<td> <input type="number" name="price" class="form-control"> </td>
			    </tr>
				<tr>
					<td>상품설명</td>
					<td> 
					    <textarea rows="5" cols="60" name="description" class="form-control"></textarea>     
					 </td>
			    </tr>
			    <tr>
					<td>상품사진</td>
					<td> <input type="file" name="img" class="form-control"> </td>
			    </tr>
			    <tr>
					<td colspan="2" align="center">
					    <input type="submit" value="상품등록" class="btn btn-success"> 
					</td>
			    </tr>   
			   </tbody> 
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











