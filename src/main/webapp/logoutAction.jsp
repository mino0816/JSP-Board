<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>JSP 게시판 만들기</title>
</head>
<body>
	<%
		//현재 이페이제 접속한 회원의 세션을 빼앗아서 로그아웃 시킴
		session.invalidate();	
	%>
	<script>
		location.href="main.jsp";
	</script>
	
</body>
</html>