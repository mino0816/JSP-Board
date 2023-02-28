<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="bbs.BbsDAO" %>
<!-- 자바스크립트를 사용하기위해서 -->
<%@page import="java.io.PrintWriter" %>
<!-- 건너오는 데이터를 UTF-8로 받음 -->
<%request.setCharacterEncoding("UTF-8"); %>
<!-- 자바빈즈 활용 한명의 유저정보를 담는 User 클래스를 자바빈즈로 활용 
	scope는 현재페이지에서만 사용해서 page를 넣음
-->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<!-- write.jsp에서 넘겨준 form 태그안의 bbstitle,bbsContent가 넘어옴 -->
<jsp:setProperty name="bbs"  property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent" />

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
		if(userID == null){
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href=login.jsp");
			script.println("</script>");
		}else{
			
	
		//데이터를 입력안하고 전송하면 null값이 들어옴 사용자가 데이터를 입력안한 경우의 수 체크 
		if(bbs.getBbsTitle() == null || bbs.getBbsContent()== null){
			PrintWriter script = response.getWriter();
			script.println("<script>");			
			script.println("alert('입력이 안 된 사항이 있습니다')");			
			script.println("history.back()");
			script.println("</script>");
		}else{
			//bbsDAO인스턴스 생성
			BbsDAO bbsDAO = new BbsDAO();	
			//write 함수 사용해서 게시글을 작성해줌
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			if(result == -1){ 
			
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패 했습니다')");	
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
			
			else {
				
				PrintWriter script = response.getWriter();
				script.println("<script>");				
				script.println("location.href='board.jsp'");
				script.println("</script>");
				}
		}
	
		}
	
	%>
	
</body>
</html>