package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
		
		
}
