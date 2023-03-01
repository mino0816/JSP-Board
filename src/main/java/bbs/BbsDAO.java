package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
		//데이터 베이스에 접근 객체 생성
		private Connection conn;
		//정보를담을수 있는 객체 생성
		private ResultSet rs; 
		
		//생성자 데이터 접근객체
		public BbsDAO() {
			try {
				//데이터베이스 url
				String dbURL="jdbc:mysql://localhost:3306/mydb";
				//데이터베이스 id
				String dbID ="root";
				//데이터베이스 password
				String dbPassword ="1234";
				//mysql 드라이버
				Class.forName("com.mysql.cj.jdbc.Driver");
				//dbURL에 dbID,dbPassword를 통해서 접속
				conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//현재 시간을 가져오는 함수
		public String getDate() {
			//여러개 함수가 사용됨 각 함수 끼리 마찰이 일어나지 않도록 pstmt는 안에서 선언함
			String sql = "SELECT NOW()";
			try {
				//연결되어있는 conn객체를 통해 sql문을 실행준비 단계
				PreparedStatement pstmt = conn.prepareStatement(sql);
				//실행된결과 가지고오기
				rs = pstmt.executeQuery();
				if(rs.next()) {
					//결과가 있는 경우 현재의 날짜를 그대로 반환한다.
					return rs.getString(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "";//데이터베이스 오류
		}
		
		
		public int getNext() {
			//bbsID 내림차순
			String sql = "SELECT bbsID FROM bbs ORDER BY bbsID DESC";
			try {
				//연결되어있는 conn객체를 통해 sql문을 실행준비 단계
				PreparedStatement pstmt = conn.prepareStatement(sql);
				//실행된결과 가지고오기
				rs = pstmt.executeQuery();
				if(rs.next()) {
					//나온 결과에다가 1을 더함
					return rs.getInt(1) + 1;
				}
				return 1; //첫 번째 게시물일 경우
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;//데이터베이스 오류
		}
		
		public int write (String bbsTitle, String userID, String bbsContent) {
			//bbsID 내림차순
			String sql = "INSERT INTO BBS VALUEs (?, ?, ?, ?, ?, ?)";
			try {
				//연결되어있는 conn객체를 통해 sql문을 실행준비 단계
				PreparedStatement pstmt = conn.prepareStatement(sql);
				//게시글 번호
				pstmt.setInt(1, getNext());
				pstmt.setString(2, bbsTitle);
				pstmt.setString(3, userID);
				pstmt.setString(4, getDate());
				pstmt.setString(5, bbsContent);
				pstmt.setInt(6, 1);
				//실행된결과 가지고오기
				//instert 문은 executeUpdate 가 사용됨

				return pstmt.executeUpdate();
			
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;//데이터베이스 오류
		}
		//특정한 리스트를 담아서 반환 10개의 게시글당 페이징처리
		public ArrayList<Bbs> getList(int pageNumber){
			//bbsID가 ? 작을경우 삭제가 되지않은 Available이 1인 값을 가져온다
			String sql = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable =1 ORDER BY bbsID DESC LIMIT 10";
			//bbs클래스에서 나오는 인스턴스를 보관하는 list를 만들어줌
			ArrayList<Bbs> list = new ArrayList<Bbs>();
			try {
				//연결되어있는 conn객체를 통해 sql문을 실행준비 단계
				PreparedStatement pstmt = conn.prepareStatement(sql);
				//getNext는 그다음으로 작성되는 글 번호 지금 게시글 번호가 5일경우 getNext의값은 6이다
				//pageNumber 값은 1이다  그래서 getNext의 값은 6이다 그래서 bbsID가 6보다 작은값을 다가져온다
				pstmt.setInt(1, getNext()- (pageNumber-1)*10);
				//실행된결과 가지고오기
				rs = pstmt.executeQuery();
				while(rs.next()) {
					//bbs라는 인스턴스를 만듬
					Bbs bbs= new Bbs();
					//bbs에 담긴 모든 속성들을 가지고온다
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					//list에 해당 bbs라는 인스턴스를 담아서 반환한다
					list.add(bbs);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;//데이터베이스 오류
		}
		
		//nextPage함수 게시글이 10단위로 떨어질때 다음페이지가 없어야한다
		//페이징처리를 위해서 만든 함수이다.
		public boolean nextPage(int pageNumber) {
			//bbsID가 ? 작을경우 삭제가 되지않은 Available이 1인 값을 가져온다
			String sql = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable =1 ORDER BY bbsID DESC LIMIT 10";
			try {
			
				PreparedStatement pstmt = conn.prepareStatement(sql);				
				pstmt.setInt(1, getNext()- (pageNumber-1)*10);
				
				rs = pstmt.executeQuery();
				//실행된결과가 하나라도 존재한다면
				if(rs.next()) {
					return true;
					//다음 페이지로 넘어감
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;//안넘어감
		}
		
		//특정한 아이디에 해당하는 게시글을 가지고옴
		public Bbs getBbs(int bbsID) {
			String sql = "SELECT * FROM BBS WHERE bbsID= ?";
			try {
			
				PreparedStatement pstmt = conn.prepareStatement(sql);				
				pstmt.setInt(1, bbsID);
				//실행결과를 rs에 담음
				rs = pstmt.executeQuery();
				//실행된결과가 하나라도 존재한다면
				if(rs.next()) {
					//bbs라는 인스턴스를 만듬
					Bbs bbs= new Bbs();
					//bbs에 담긴 모든 속성들을 가지고온다
					bbs.setBbsID(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserID(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					//위의 값들을 bbs에 결과들을 리턴시킨다 
					return bbs;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;//해당글이 없으면 null을 반환한다
		}
		
		//글 수정 함수생성 특정한 번호에 매개변수로 들어온 제목과 내용을 수정함
		public int update(int bbsID, String bbsTitle, String bbsContent) {
			//특정한 id에 제목과 내용을 바꿔줌
			String sql = "UPDATE BBS SET bbsTitle =?, bbsContent =? WHERE bbsID = ?";
			try {
				//연결되어있는 conn객체를 통해 sql문을 실행준비 단계
				PreparedStatement pstmt = conn.prepareStatement(sql);
				//게시글 번호
				pstmt.setString(1, bbsTitle);
				pstmt.setString(2, bbsContent);
				pstmt.setInt(3, bbsID);
			
				

				return pstmt.executeUpdate();
			
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;//데이터베이스 오류
		}
		
		//삭제 함수 어떤 글인지 알 수 있게 bbsID값을 받아온다
		public int delete(int bbsID) {
			//글을 삭제 하더라도 데이터는 남아있게 available을 0으로 만들어준다 1은 글이 삭제 되지않음을 알려줌
			String sql = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
			try {
				//연결되어있는 conn객체를 통해 sql문을 실행준비 단계
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bbsID);
				//0이상의 값을 반환해서 성공임
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;//데이터베이스 오류
		}
}
