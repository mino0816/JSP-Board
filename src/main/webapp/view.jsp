<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="bbs.Bbs"%>
<!-- 빈즈사용 -->
<%@page import="bbs.BbsDAO"%>
<!-- 메서드사용 데이터베이스 접근 객체 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial0scale="1">
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
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	//bbsID를 0으로 설정합니다.
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

	//유효한 글이라면 해당글내용을 구체적으로 가지고 bbs라는 인스턴스에 넣어줍니다.
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expended="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<!-- 현재 페이지 표시 -->
				<li class="active"><a href="board.jsp">게시판</a></li>
			</ul>
			<%
			//로그인이 되지 않은사람들만 접속하기를 보이게함
			if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">접속하기<span
						class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
			} else {
			%>
			<!-- 로그인 중인 사람이 보는 화면-->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">회원관리<span
						class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>

					</ul></li>
			</ul>
			<%
			}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<!-- 글제목,글내용은 글쓰기 버튼을 클릭하면 action.jsp로 옮겨짐 -->
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					<!-- 문자에 특수문자 처리하는이유는 크로스 사이팅 스크립트 해킹을 방지하기위해서 해야한다. 강제로 스크립트문을 넣음으로써 문제가 생길수있다. 웹보안에서 아주 중요한 방어체계를 마련 할 수 있다. -->
						<td style="width: 20%"> 글 제목</td>
						<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%=bbs.getBbsDate().substring(0, 11)+bbs.getBbsDate().substring(11, 13)+"시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll("<", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="board.jsp" class="btn btn-primary">목록</a>
			<%
				//해당글 작성자가 본인이 맞다면
				if(userID != null &&userID.equals(bbs.getUserID())){
			%>
					
				<a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
				<a onclick	="return confirm('정말로 삭제 하시겠습니까?')" href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭제</a>
				
			<%
				}			
			%>
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>