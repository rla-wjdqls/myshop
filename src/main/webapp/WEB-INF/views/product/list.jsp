<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
    
<!DOCTYPE html>
<html lang="ko">
<head>
	  <title>My Shop</title>
	  <meta charset="utf-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	  <script src="/js/jquery-3.7.1.min.js"></script>
	  <link href="/css/main.css" rel="stylesheet" type="text/css">
<style>
            #mydiv {
                position: relative;
                left: 100px;
                top: 30px;
                width: 1000px;               
                height: 100px;
                background-color: white; 
                overflow: hidden;          
            }

</style>
<script>
            let ctnt=[];
            ctnt[0]="<img src='/images/k1.png' width='100'>";
            ctnt[1]="<img src='/images/k2.png' width='100'>";
            ctnt[2]="<img src='/images/k3.png' width='100'>";
            ctnt[3]="<img src='/images/k4.png' width='100'>";
            ctnt[4]="<img src='/images/k5.png' width='100'>";
            ctnt[5]="<img src='/images/k6.png' width='100'>";
            ctnt[6]="<img src='/images/k7.png' width='100'>";

            function start(){

                for(let i=0;i<ctnt.length;i++){
                    document.write("<div id='area"+ i +"' style='position:absolute; top:0; left:"+(i*90)+"px'>"); //그림이 담겨있는 <div> 박스 생성
                    document.write(ctnt[i]);
                    document.write("</div>");
                }//for end

                setTimeout(scroll, 3000);
            }//start end

            function scroll(){
                for(let i=0;i<ctnt.length;i++){
                    let tmp= document.getElementById("area"+i).style; 
                    tmp.left= parseInt(tmp.left)-10+"px";

                     if(parseInt(tmp.left)<=-90){ 
                         tmp.left= (ctnt.length-1) *90 + "px";
                         }//if end
                     }//for end

                  timer = setTimeout(scroll, 500);
            }//scroll() end

            let timer;//전역변수
            
            
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
			<button type="button" onclick="location.href='write'" class="btn btn-success">상품등록</button>
			<button type="button" onclick="location.href='list'" class="btn btn-primary">상품전체목록</button>
		</p>
    </div><!-- col end -->
  </div><!-- row end -->
  
    <div class="row">
    <div class="col-sm-12">
		<!-- 검색 -->
		<form method="get" action="search">
			상품명 : <input type="text" name="product_name" value="${product_name}">
			       <input type="submit" value="검색" class="btn">
		</form>		
    </div><!-- col end -->
  </div><!-- row end -->
  <br><hr><br>
     <div class="row">
    	<!-- varStatus="상태용 변수" -->
		<c:forEach items="${list}" var="row" varStatus="vs">
			<div class="col-sm-4 col-md-4">
				<c:choose>
					<c:when test="${row.filename !='-'}">					
						<a href="detail/${row.product_code}">
							<img src="/storage/${row.filename}" class="img-responsive margin" style="width:250px; height:300px;">
						</a>
					</c:when>
					<c:otherwise>
						등록된 사진 없음!<br>
					</c:otherwise>
				</c:choose>
				<br>
				상품명 : 
					<!-- http://localhost:9095/product/detail?product_code=22 -->
					<a href="detail?product_code=${row.product_code}">${row.product_name}</a>
					
					<!-- RESTful Web Service URL 형식으로 서버에 요청 -->
					<!-- http://localhost:9095/product/detail/1 -->
					<%-- <a href="detail/${row.product_code}">${row.product_name}</a> --%>
					
				<br>	
				상품가격 : <fmt:formatNumber value="${row.price}" pattern="#,###원"/> 
				<br>
			</div>
			
			<!-- 한줄에 3칸씩 -->
			<c:if test="${vs.count mod 3==0}">
				</div><!-- row end -->			
				<div style="height: 50px"></div>
				<div class="row">
			</c:if>
		</c:forEach>
  </div><!-- row end -->
  
   <%--  <div class="row">
    	<!-- varStatus="상태용 변수" -->
		<c:forEach items="${list}" var="row" varStatus="vs">
			<div class="col-sm-4 col-md-4">
				<c:choose>
					<c:when test="${row.FILENAME !='-'}">					
						<a href="detail/${row.PRODUCT_CODE}">
							<img src="/storage/${row.FILENAME}" class="img-responsive margin" style="width:100%">
						</a>
					</c:when>
					<c:otherwise>
						등록된 사진 없음!<br>
					</c:otherwise>
				</c:choose>
				<br>
				상품명 : 
					<!-- http://localhost:9095/product/detail?product_code=22 -->
					<a href="detail?product_code=${row.PRODUCT_CODE}">${row.PRODUCT_NAME}</a>
					
					<!-- RESTful Web Service URL 형식으로 서버에 요청 -->
					<!-- http://localhost:9095/product/detail/1 -->
					<a href="detail/${row.PRODUCT_CODE}">${row.PRODUCT_NAME}</a>
					
				<br>	
				상품가격 : <fmt:formatNumber value="${row.PRICE}" pattern="#,###원"/> 
				<br>
			</div>
			
			<!-- 한줄에 3칸씩 -->
			<c:if test="${vs.count mod 3==0}">
				</div><!-- row end -->			
				<div style="height: 50px"></div>
				<div class="row">
			</c:if>
		</c:forEach>
  </div><!-- row end -->
   --%>
  
  
<!-- 본문 끝 -->
</div><!-- container end -->


<div id="mydiv"> <!-- 이미지스크룰 출력 -->
	<script>start();</script>
</div>

<div class="mt-5 p-4 bg-dark text-white text-center">
  <p>ITWILL 아이티윌 교육센터</p>
</div>


</body>
</html>











