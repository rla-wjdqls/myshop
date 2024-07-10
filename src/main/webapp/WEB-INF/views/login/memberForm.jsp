<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
    
<!DOCTYPE html>
<html lang="ko">
<head>
	  <title>memberForm.jsp</title>
	  <meta charset="utf-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	  <link href="/css/main.css" rel="stylesheet" type="text/css">	   
	  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	  <script src="/js/jquery-3.7.1.min.js"></script> 
	  <script src="/js/jquery.cookie.js"></script>
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
  <br>
  <!--쿠키를 활용하여 아이디 중복 확인을 해야만 회원가입이 가능하다-->
  <h3>* 회/원/가/입 *</h3>

<span style="color:red; font-weight: bold">* 필수입력 *</span>
<br>
																	  	
<form name="memfrm" id="memfrm" method="post" action="insert" onsubmit="return send()">
<table class="table">
<tr>
    <th>*아이디</th>
    <td style="text-align: left">
    	<input type="text" name="id" id="id" size="10" maxlength="10">
    	<input type="button" value="ID중복확인" id="btn_id">
    	<br>
		<span id="panel1"></span><!-- 아이디 중복 관련 메세지 -->
    </td>
</tr>
<tr>
    <th>*비밀번호</th>
    <td style="text-align: left">
    	<input type="password" name="passwd" id="passwd" size="10" maxlength="10" required>
    </td>
</tr>
<tr>
    <th>*비밀번호 확인</th>
    <td style="text-align: left">
    	<input type="password" name="repasswd" id="repasswd" size="10" maxlength="10" required>
    </td>
</tr>
<tr>
    <th>*이름</th>
    <td style="text-align: left">
    	<input type="text" name="wname" id="wname" size="20" maxlength="20" required>
    </td>
</tr>
<tr>
    <th>*이메일</th>
    <td style="text-align: left">
    	<input type="text" name="email" id="email" size="10" maxlength="50">
    	<input type="button" value="email중복확인" id="btn_email">
    	<br>
		<span id="panel2"></span><!-- 이메일 중복 관련 메세지 -->
    </td>
</tr>
<tr>
    <th>전화번호</th>
    <td style="text-align: left"><input type="text" name="tel" id="tel" size="15" maxlength="14"></td>
</tr>
<tr>
    <th>우편번호</th>
    <td style="text-align: left">
      <input type="text" name="zipcode" id="zipcode" size="7"  readonly>
      <input type="button" value="주소찾기" onclick="DaumPostcode()">    
    </td>
</tr>
<tr>  
    <th>주소</th>
    <td style="text-align: left"><input type="text" name="address1" id="address1" size="45" readonly></td>
</tr>
<tr>  
    <th>나머지주소</th>
    <td style="text-align: left"><input type="text" name="address2" id="address2" size="45"></td>
</tr>
<tr>
    <td colspan="2">
        <input type="submit" value="회원가입"  class="btn btn-primary"/>
        <input type="reset"  value="취소"     class="btn btn-primary"/>
    </td>
</tr>
</table>
</form>

<!-- ----- DAUM 우편번호 API 시작 ----- -->
  <div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
    <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
  </div>

  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
      // 우편번호 찾기 찾기 화면을 넣을 element
      var element_wrap = document.getElementById('wrap');

      function foldDaumPostcode() {
          // iframe을 넣은 element를 안보이게 한다.
          element_wrap.style.display = 'none';
      }

      function DaumPostcode() {
          // 현재 scroll 위치를 저장해놓는다.
          var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
          new daum.Postcode({
              oncomplete: function(data) {
                  // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                  var addr = ''; // 주소 변수
                  var extraAddr = ''; // 참고항목 변수

                  //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                  if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                      addr = data.roadAddress;
                  } else { // 사용자가 지번 주소를 선택했을 경우(J)
                      addr = data.jibunAddress;
                  }

                  // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                  if(data.userSelectedType === 'R'){
                      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                          extraAddr += data.bname;
                      }
                      // 건물명이 있고, 공동주택일 경우 추가한다.
                      if(data.buildingName !== '' && data.apartment === 'Y'){
                          extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                      }
                      // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                      if(extraAddr !== ''){
                          extraAddr = ' (' + extraAddr + ')';
                      }
                      // 조합된 참고항목을 해당 필드에 넣는다.
                      document.getElementById("address2").value = extraAddr;
                  
                  } else {
                      document.getElementById("address2").value = '';
                  }

                  // 우편번호와 주소 정보를 해당 필드에 넣는다.
                  document.getElementById('zipcode').value = data.zonecode;
                  document.getElementById("address1").value = addr;
                  // 커서를 상세주소 필드로 이동한다.
                  document.getElementById("address2").focus();

                  // iframe을 넣은 element를 안보이게 한다.
                  // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                  element_wrap.style.display = 'none';

                  // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                  document.body.scrollTop = currentScroll;
              },
              // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
              onresize : function(size) {
                  element_wrap.style.height = size.height+'px';
              },
              width : '100%',
              height : '100%'
          }).embed(element_wrap);

          // iframe을 넣은 element를 보이게 한다.
          element_wrap.style.display = 'block';
      }
  </script>
<!-- ----- DAUM 우편번호 API 종료----- -->
    </div><!-- col end -->
  </div><!-- row end -->
  
<!-- 로그인 관련 자바스크립트 -->  
<script>

//6)해당 페이지가 로딩되었을 때 아이디 중복확인과 관련된 쿠키변수 삭제
$(function(){
	$.removeCookie("checkID");
	$.removeCookie("checkEmail");
}); //end


//1-1)id="btn_id" 아이디 중복확인 버튼 클릭했을 때
	$("#btn_id").click(function(){
		
		//2)입력한 id="btn_id" 값을 변수에 대입하기
		let params1 = "id=" + $("#id").val().trim(); 
		//alert(params1); //itwill
		//JSON 응답
		$.post("idcheckcookieproc", params1, checkID, "json"); 
	})//click end

//1-2)id="btn_email" 아이디 중복확인 버튼 클릭했을 때
	$("#btn_email").click(function(){
	
		let params2 = "email=" + $("#email").val().trim(); 
		//alert(params2); //itwill@itwill.co.kr
		$.post("emailcheckcookieproc", params2, checkEmail, "json"); 
	})//click end

//4)callback함수
function checkID(result1){
	//5)서버에서 응답받은 메세지(result)를 본문의 id=panel에 출력하고, 쿠키변수에 저장
	//  형식) $.cookie("쿠키변수명", 값)
	let count1 = eval(result1.count1); //형변환
	//alert(count1); //itwill -> 1
	if(count1==0){
		$("#panel1").css("color", "blue");
		$("#panel1").text("사용 가능한 아이디 입니다");
		$.cookie("checkID", "PASS1"); //아이디중복확인을 했다는 증거. "PASS" 변경 가능
	}else{
		$("#panel1").css("color", "red");
		$("#panel1").text("중복된 아이디 입니다");
		$("#id").focus(); //커서생성
	}//if end
}//checkID() end

function checkEmail(result2){
	let count2 = eval(result2.count2); //형변환
	//alert(count2); //itwill@itwill.co.kr -> 1
	if(count2==0){
		$("#panel2").css("color", "blue");
		$("#panel2").text("사용 가능한 이메일 입니다");
		$.cookie("checkEmail", "PASS2"); 
	}else{
		$("#panel2").css("color", "red");
		$("#panel2").text("중복된 이메일 입니다");
		$("#email").focus(); //커서생성
	}//if end
}//checkEmail() end


//7)아이디중복확인을 해야만 회원가입폼이 서버로 전송
function send() {
	
	//아이디 입력했는지?
	let id = $("#id").val().trim();
	if(id.length<5 || id.length>15){
		alert("아이디 5~15 글자로 입력해 주세요!");
		return false;
	}//if end
	
	//비밀번호 입력했는지?
	let passwd = $("#passwd").val().trim();
	if(passwd.length<5 || passwd.length>15){
		alert("비밀번호 5~15 글자로 입력해 주세요!");
		return false;
	}//if end
	
	//이름 입력했는지?
	let name = $("#wname").val().trim();
	if(name.length==0){
		alert("이름 입력해 주세요!");
		return false;
	}//if end	
			
	//이메일 입력했는지?
	let email = $("#email").val().trim();
	if(email.length==0){
		alert("제대로된 이메일 입력해 주세요!");
		return false;
	}//if end

	//아이디 중복확인 했는지?
	let checkID = $.cookie("checkID"); //쿠키변수 값 가져오기
	alert(checkId);
	if(checkID=="PASS"){
		return true;
	} else{
		$("#panel1").css("color", "green");
		$("#panel1").text("아이디 중복 확인 해주세요");
		$("#id").focus();
		return false;
	}//if end

}//send() end

</script>

    <!-- 본문 끝 -->
    
</div><!-- container end -->
  
<div class="mt-5 p-4 bg-dark text-white text-center">
  <p>ITWILL 아이티윌 교육센터</p>
</div>
 
 
 
 
 
</body>
</html>











