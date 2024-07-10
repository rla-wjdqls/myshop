<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
    
<!DOCTYPE html>
<html lang="ko">
<head>
	  <title>orderForm.jsp</title>
	  <meta charset="utf-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	  <script src="/js/jquery-3.7.1.min.js"></script>
	  <link href="/css/main.css" rel="stylesheet" type="text/css">
<script>
	function orderCheck(){
		//유효성검사 (받는사람, 받는주소, 배송메세지)
		
		if(confirm("결제할까요?")){
			return true;
		}else{
			return false;
		}//if end
		
		
	}//orderCheck() end




</script>
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

  <div class="row">
    <div class="col-sm-12">
    	<p><h3>배송지 작성</h3></p>
    </div><!-- col end -->
  </div><!-- row end -->
  
  <div class="row">
    <div class="col-sm-12">
  		<form method="post" action="insert" onsubmit="return orderCheck()">
	  		<table class="table table-hover">
				<tbody style="text-align: left;">
			    	<tr>
			    		<th>받는사람</th>
			    		<td><input type="text" name="deliverynm" class="form-control"></td>
			    	</tr>
			    	<tr>
			    		<th>받는주소</th>
			    		<td><input type="text" name="deliveryaddr" class="form-control"></td>
			    	</tr>
					<tr>
			    		<th>배송메세지</th>
			    		<td><input type="text" name="deliverymsg" class="form-control"></td>
			    	</tr>
			    	<tr>
			    		<th>결제구분</th>
			    		<td>
			    			<select name="payment" class="form-control">
			    				<option value="cash">현금결제</option>
			    				<option value="card">카드</option>
			    			</select>
			    		</td>
			    	</tr>
					<tr>
			    		<td colspan="2" align="center">
			    			<input type="submit" value="결제하기" class="btn btn-warning">
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











