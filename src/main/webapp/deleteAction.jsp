<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="bbs.BbsDAO" %>
<%@page import="bbs.Bbs" %>
<!-- 자바스크립트를 사용하기위해서 -->
<%@page import="java.io.PrintWriter" %>
<!-- 건너오는 데이터를 UTF-8로 받음 -->
<%request.setCharacterEncoding("UTF-8"); %>

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
		
		if(userID == null){
			
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href=login.jsp");
			script.println("</script>");
		}int bbsID = 0;
		//파라미터로 넘어온 매개변수가 존재한다면
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));		
		}
		//System.out.println(bbsID);
		if (bbsID == 0) {
			//bbsID가 0일경우 유효하지 않으므로 alert를 띄우고 board.jsp로 돌려보냄
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='board.jsp'");
			script.println("</script>");
		} 
		//작성한 글이 본인이 작성했는지 확인이 필요함
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		//getUserID가 userID랑 같지 않다면
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='board.jsp'");
			script.println("</script>");
		}else{
		
			//bbsDAO인스턴스 생성
			BbsDAO bbsDAO = new BbsDAO();	
			//delete 함수 사용해서 게시글을 작성해줌
			int result = bbsDAO.delete(bbsID);
			if(result == -1){ 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패 했습니다')");	
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
			
			else {
				//성공하면 board.jsp게시판으로 다시 이동함
				PrintWriter script = response.getWriter();
				script.println("<script>");				
				script.println("location.href='board.jsp'");
				script.println("</script>");
				}
		}
	
	
	
	%>
	
</body>
</html>