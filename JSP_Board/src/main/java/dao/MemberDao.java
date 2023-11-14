package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Dto.Member;

public class MemberDao {
	Connection getConnection() {
		Connection con = null; // 접속 정보 저장

		String url = "jdbc:oracle:thin:@//localhost:1521/xe";
		String userId = "JSP_BOARD";
		String userPw = "1111";
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			con = DriverManager.getConnection(url, userId, userPw);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.out.println("드라이버 예외");
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB 예외");
		}

		if (con != null) {
			System.out.println("DB 접속");
		} else {
			System.out.println("DB 접속 실패");
		}

		return con;
	}

	public Member selctMemberInfo(String checkId) {
		System.out.println("dao - selctMemberInfo() 호출");
		// 1. DB접속
		Connection con = getConnection();
		if(con == null) {
			System.out.println("접속 실패");
			return new Member() ;
		}
		// 2. 쿼리문 실행
		String sql ="SELECT * FROM MEMBERS WHERE MID = ?";
		Member member = null;
		PreparedStatement pstmt;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,checkId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				member = new Member();
				member.setMid(rs.getString("MID"));
				member.setMpw(rs.getString("MPW"));
				member.setMname(rs.getString("MNAME"));
				member.setMbirth(rs.getString("MBIRTH"));
				member.setMaddr(rs.getString("MADDR"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return member;
	}

	public int insertInfo(Member joinMember) {
		System.out.println("insertInfo함수 접속");
		Connection con = getConnection();
		if(con == null) {
			System.out.println("접속 실패");
			return 0;
		}
		int result = 0;
		String sql ="INSERT INTO MEMBERS(MID,MPW,MNAME,MBIRTH,MADDR) VALUES( ? , ? , ? , ? , ?)";
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1,joinMember.getMid());
			pstmt.setString(2,joinMember.getMpw());
			pstmt.setString(3,joinMember.getMname());
			pstmt.setString(4,joinMember.getMbirth());
			pstmt.setString(5,joinMember.getMaddr());
			result  = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}

	public Member selectMemberLogin(String inputID, String inputPW) {
		System.out.println("dao - selctMemberInfo() 호출");
		// 1. DB접속
		Connection con = getConnection();
		if(con == null) {
			System.out.println("접속 실패");
			return new Member() ;
		}
		
		String sql ="SELECT * FROM MEMBERS WHERE MID = ? AND MPW = ?";
		Member member = null;
		PreparedStatement pstmt;
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,inputID);
			pstmt.setString(2,inputPW);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				member = new Member();
				member.setMid(rs.getString("MID"));
				member.setMpw(rs.getString("MPW"));
				member.setMname(rs.getString("MNAME"));
				member.setMbirth(rs.getString("MBIRTH"));
				member.setMaddr(rs.getString("MADDR"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return member;
	}

}
