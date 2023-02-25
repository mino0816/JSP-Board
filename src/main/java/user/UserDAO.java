package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	//데이터 베이스에 접근 객체 생성
	private Connection conn;
	private PreparedStatement pstmt;
	//정보를담을수 있는 객체 생성
	private ResultSet rs; 
	
	//생성자 데이터 접근객체
	public UserDAO() {
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
	
	public int login(String userID, String userPassword) {
		//user 테이블에서 해당사용 비밀번호를 가지고옴 
		//sql인젝션 해킹을 방지하기 위해서 PreparedStatement를 씀
		//매개변수로 넘어온 userID를 ?에 대입 사용자 아이디 입력받음
		//아이디 존재하면 비밀번호가 무엇인지 데이터베이스에서 가지고옴 
		String sql = "select userPassword FROM USER WHERE userID = ?";
		
		try {
			//pstmt에 정해진 sql문을 삽입
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				//쿼리문이 있다면
				if(rs.getString(1).equals(userPassword)) {
					//입력받은 userID의 password랑 db에있는 입력받은 userID의 password가 같다면 
					return 1; //로그인 성공
					
				}
				else
					return 0;//비밀번호 불일치
			}
			return -1;//로그인 실패
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;//데이터베이스 오류
	}
	//회원가입을 위한 join함수 생성
	public int join(User user) {
		String sql = "INSERT INTO USER VALUES(?, ?, ?, ?, ?)";
		//각 ?들 값을 집어 넣음
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail() );
			//실행한 결과를 리턴함 insert는 0이상의 값을 리턴함으로 -1이 아니면 성공적으로 회원가입이 이루어짐
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류 
	}
}
