<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="java.io.PrintWriter" %>
 <%@page import="bbs.Bbs" %>
 <%@page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial0scale="1">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>JSP 게시판 만들기</title>
</head>
<body>
	<%
		//로그인이 된 사람은 로그인 정보를 담아준다
		/*
		로그인을 한사람이면 userID변수에 해당id가 담기고 그렇지 않은 사람은 null값이 담긴다
		*/
		String userID = null;
		if(session.getAttribute("userID") !=null){
			userID= (String)session.getAttribute("userID");  
		}
		
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		int bbsID = 0;
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
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expended="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
					aria-expanded="false">접속하기<span  class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			  <!-- 로그인 중인 사람이 보는 화면-->
			   <ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
					aria-expanded="false">회원관리<span  class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
						
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="row">
		<!-- bbsID를 넘김 -->
		<form action="updateAction.jsp?bbsID=<%=bbsID %>" method="post">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;" >게시판 수정 양식</th>				
					</tr>					
				</thead>
				<tbody>
					<tr><!-- getBbsTitle db에 저장된 제목 가지고옴 -->
						<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%=bbs.getBbsTitle()%>"></td>	
					</tr>
					<tr>				
						<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px;"><%=bbs.getBbsContent()%></textarea></td>					
					</tr>
				</tbody>
			
			</table>
				<input type="submit"class="btn btn-primary pull-right" value="글수정">
		</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>