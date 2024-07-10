<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>emailCheckForm.jsp</title>
</head>
<body>

<div style="text-align: center">
	<h3>* 이메일 중복확인 *</h3>
	<form action="emailCheckProc.jsp" onsubmit="return blankCheck()">
		이메일 : <input type="text" name="email" id="email" maxlength="50" autofocus>
			<input type="submit" value="중복확인">
	</form>
</div>


<script>
	function blankCheck(){
		 let email = document.getElementById("email").value;
		 email = email.trim();
		 if(email.length<5 || email.indexOf('@')==-1){
			 alert("제대로 된 이메일을 입력해 주세요");
			 return false;
		 }//if end
	
		 return true;
	}//blackCheck() end
</script>

</body>
</html>










