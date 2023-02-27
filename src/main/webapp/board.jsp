<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="java.io.PrintWriter" %>
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
				<a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<!-- 현재 페이지 표시 -->
				<li class="active"><a href="board.jsp">게시판</a></li>
			</ul>
			<%
				//로그인이 되지 않은사람들만 접속하기를 보이게함
				if(userID == null){
			%>
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
			<%}else{%>
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
			<%} %>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;" >번호</th>
						<th style="background-color: #eeeeee; text-align: center;" >제목</th>
						<th style="background-color: #eeeeee; text-align: center;" >작성자</th>
						<th style="background-color: #eeeeee; text-align: center;" >작성일</th>
					</tr>					
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>안녕하세요</td>
						<td>홍길동</td>
						<td>2023-02-27</td>
						
					</tr>
				</tbody>
			</table>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>