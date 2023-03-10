<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--반응형 메타태그-->
<meta name="viewport" content="width=device-width", initial0scale="1">
<!--부트스트랩 참조-->
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>JSP 게시판 만들기</title>
</head>
<body>
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
				<li><a href="board.jsp">게시판</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
					aria-expanded="false">접속하기<span  class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>	
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top:20px">
			<!-- 로그인 정보보내기 -->
				<form action="loginAction.jsp" method="post">
					<h3 style="text-align: center;">회원가입 화면</h3>
					<div class="form-group">
					<!-- name은 나중에 서버프로그램 작성할때 사용함 중요하다!! -->
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
						<div class="form-group">				
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<input class="btn btn-primary form-control" value="회원가입" type="submit">
					<!-- 로그인 버튼 클릭하면 form에있는 action="loginAction.jsp"로 데이터들이 넘겨짐 -->
				</form>
			</div>
		</div>	
		<div class="col-lg-4"></div>	
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>