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
		//userDAO인스턴스 생성
		UserDAO userDAO = new UserDAO();
		/* login.jsp에서 입력받은 userID와 userPassword를 login함수에 넣어서 실행  값들은 result에 담김*/
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result == 1){ 
			//로그인 성공시 세션값을 부여 해당아이디로 세션값부여
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			//로그인 성공시 main.jsp로 이동
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			//비밀번호 틀릴시 나와야함 수업들을때 요즘은 보안 때문에 비밀번호가 틀렸는지 아이디가 틀렸는지 알려주지 않음
			script.println("alert('아이디 또는 비밀번호가 틀립니다.')");
			//로그인 실패시 다시 이전페이지로 돌려보냄
			script.println("history.back() ");
			script.println("</script>");
			}
		else if(result == -1)    {
		PrintWriter script = response.getWriter();
			script.println("<script>");
			//비밀번호 틀릴시 나와야함 수업들을때 요즘은 보안 때문에 비밀번호가 틀렸는지 아이디가 틀렸는지 알려주지 않음
			script.println("alert('아이디 또는 비밀번호가 틀립니다.')");
			//로그인 실패시 다시 이전페이지로 돌려보냄
			script.println("history.back() ");
			script.println("</script>");
			}
		else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			//비밀번호 틀릴시 나와야함 수업들을때 요즘은 보안 때문에 비밀번호가 틀렸는지 아이디가 틀렸는지 알려주지 않음
			script.println("alert('데이터베이스 오류입니다.')");
			//로그인 실패시 다시 이전페이지로 돌려보냄
			script.println("history.back() ");
			script.println("</script>");
			}
		
	
	%>
	
</body>
</html>