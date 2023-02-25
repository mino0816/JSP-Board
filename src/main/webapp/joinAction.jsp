<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="user.UserDAO" %>
<!-- 자바스크립트를 사용하기위해서 -->
<%@page import="java.io.PrintWriter" %>
<!-- 건너오는 데이터를 UTF-8로 받음 -->
<%request.setCharacterEncoding("UTF-8"); %>
<!-- 자바빈즈 활용 한명의 유저정보를 담는 User 클래스를 자바빈즈로 활용 
	scope는 현재페이지에서만 사용해서 page를 넣음
-->
<jsp:useBean id="user" class="user.User" scope="page"/>
<!-- login.jsp에서 넘겨준 input태그안 name의 userID를 그대로 받아서 property에 넣어줌-->
<jsp:setProperty name="user"  property="userID"/>
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" /> 
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- userDAO를 참조해서 로그인기능 구현 loginAction.jsp  -->
<title>JSP 게시판 만들기</title>
</head>
<body>
	<%
			//로그인된 유저는 회원가입 및 로그인 페이지에 들어가지 못하게 만들어줌
			String userID = null;
		//세션id가 null이아니라면
		if(session.getAttribute("userID") != null){
			//userID라는 변수에 session아이디값을 넣어줌 
			userID=(String)session.getAttribute("userID");
		}
		//userID가 null값이 아닌경우
		if(userID != null){
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href=main.jsp");
			script.println("</script>");
		}
			
	
		//데이터를 입력안하고 전송하면 null값이 들어옴 사용자가 데이터를 입력안한 경우의 수 체크 
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName()==null || user.getUserGender() == null
		|| user.getUserEmail() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");			
			script.println("alert('입력이 안 된 사항이 있습니다')");			
			script.println("history.back()");
			script.println("</script>");
		}else{
			//userDAO인스턴스 생성
			UserDAO userDAO = new UserDAO();			
			int result = userDAO.join(user);
			if(result == -1){ 
				//primarykey로 userID가 설정 되어있음 그래서 id가 중복되면 데이터베이스 오류 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");	
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
			//-1이 아닌경우는 다 회원가입이 됨
			else {
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");				
				script.println("location.href='main.jsp'");
				script.println("</script>");
				}
		}
	
		
	
	%>
	
</body>
</html>