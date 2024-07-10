<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
    
<!DOCTYPE html>
<html lang="ko">
<head>
	  <title>list.jsp</title>
	  <meta charset="utf-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	  <script src="/js/jquery-3.7.1.min.js"></script>
	  <link href="/css/main.css" rel="stylesheet" type="text/css">	 
	  <script>

		 function cartDelete(cartno){ //cartno 62 전달받음
			if(confirm("해당 상품을 삭제할까요?")){
				//또 다른 방법 <form action='/cart/delete'></form>
				location.href='/cart/delete?cartno=' + cartno;
			} //if end	
		 }//cartDelete() end

		 function order(){
			 if(confirm("주문할까요?")){
				 	location.href='/order/orderform';
				 //if end 
				 
			 }//if end
		 }//order() end
		 
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
		<p><h3>장바구니 목록</h3></p>
    </div><!-- col end -->
  </div><!-- row end -->
  
    <div class="row">
    <div class="col-sm-12">
		<table class="table table-hover">
			<thead class="table-success">
				<th>선택</th>
				<th>아이디</th>
				<th>번호</th>
				<th>상품코드</th>
				<th>사진</th>
				<th>상품명</th>
				<th>단가</th>
				<th>상품수량</th>
				<th>가격</th>
				<th>삭제</th>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="row">
					<tr>
						<!-- "1" 선택 한것만 주문하기 -->
						<td><input type="checkbox" name="cbox" id="cbox" value="1"></td>
						<td>${row.id}</td>
						<td>${row.cartno}</td>
						<td>${row.product_code}</td>
						<td>
							<c:choose>
								<c:when test="${row.filename !='-'}">					
									<a href="/product/detail/${row.product_code}">
										<img src="/storage/${row.filename}" class="img-responsive margin" width="100px">
									</a>
								</c:when>
							<c:otherwise>
								등록된 사진 없음!<br>
							</c:otherwise>
							</c:choose>
						</td> <!-- 사진 -->
						<td><a href="/product/detail/${row.product_code}">${row.product_name}</a></td> <!-- 상품명 -->
						<td><fmt:formatNumber value="${row.price}" pattern="#,###원"/> </td>
						<td>${row.qty}</td>
						<td><fmt:formatNumber value="${row.price*row.qty}" pattern="#,###원"/></td>
						<td>
							<input type="button" class="btn basic" value="삭제" onclick="cartDelete(${row.cartno})">
						</td>
					</tr>
				</c:forEach>
				<tr>
					<!-- <td> 총금액  </td> -->
				</tr>
			</tbody>
		</table>
		<hr>
		<input type="button" class="btn btn-primary" value="계속쇼핑하기" onclick="location.href='/product/list'">
		<input type="button" class="btn btn-warning" value="주문하기" onclick="order()">
		
		
    </div><!-- col end -->
  </div><!-- row end -->
  
  
    <!-- 본문 끝 -->
</div><!-- container end -->
  
<div class="mt-5 p-4 bg-dark text-white text-center">
  <p>ITWILL 아이티윌 교육센터</p>
</div>
 
</body>
</html>











