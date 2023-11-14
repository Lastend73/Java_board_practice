package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import Dto.Board;
import Dto.Member;

public class BoardDao {

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

	public int selectMaxBno() {

		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속 실패");
			return -1;
		}
		String sql = "SELECT NVL(MAX(BNO),0) FROM BOARDS";
		int result = 0;

		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;

	}

	public int insertBoard(Board board) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속 실패");
			return 0;
		}
		System.out.println("insert");
		String sql = "INSERT INTO BOARDS VALUES(?, ?, ?, ?, 0, '1')";
		int result = 0;

		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board.getBno());
			pstmt.setString(2, board.getBwriter());
			pstmt.setString(3, board.getBtitle());
			pstmt.setString(4, board.getBcontents());
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public ArrayList<Board> selectAll() {
		ArrayList<Board> bolist = new ArrayList<Board>();
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속 실패");
			return null;
		}
		String sql = "SELECT * FROM BOARDS WHERE BSTATE = '1' ORDER BY BNO DESC";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				Board bo = new Board();
				bo.setBno(rs.getInt("BNO"));
				bo.setBwriter(rs.getString("BWRITER"));
				bo.setBtitle(rs.getString("BTITLE"));
				bo.setBcontents(rs.getString("BCONTENTS"));
				bo.setBhits(rs.getInt("BHITS"));
				bo.setBstate(rs.getString("BSTATE"));
				bolist.add(bo);
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return bolist;
	}

	public Board getBoardview(int viewBno) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속 실패");
			return null;
		}
		String sql = "SELECT * FROM BOARDS WHERE BNO = ?";
		Board bo = null;
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, viewBno);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				bo = new Board();
				bo.setBno(rs.getInt("BNO"));
				bo.setBwriter(rs.getString("BWRITER"));
				bo.setBtitle(rs.getString("BTITLE"));
				bo.setBcontents(rs.getString("BCONTENTS"));
				bo.setBhits(rs.getInt("BHITS"));
				bo.setBstate(rs.getString("BSTATE"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return bo;
	}

	public void updateBoardHits(int viewBno) {

		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속 실패");
		}
		String sql = "UPDATE BOARDS SET BHITS = BHITS + 1 WHERE BNO = ?";
		int result = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, viewBno);
			result = pstmt.executeUpdate();
			System.out.println("완료");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}

	public int updateView(int upadteBno) {
		
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속 실패");
			return 0;
		}
		String sql = "UPDATE BOARDS SET BSTATE = 0 WHERE BNO = ?";
		int result = 0;
		
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, upadteBno);
			result = pstmt.executeUpdate();
			System.out.println("성공");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public ArrayList<Board> selectBoardSearch(String searchTitle) {
		Connection con = getConnection();
		if (con == null) {
			System.out.println("접속 실패");
			return null;
		}
		String sql = "SELECT * FROM BOARDS WHERE BSTATE = '1' AND BTITLE LIKE '%"+searchTitle+"%' ORDER BY BNO DESC";
		Board bo = null;
		ArrayList<Board> boardList = new ArrayList<Board>();
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				bo = new Board();
				bo.setBno(rs.getInt("BNO"));
				bo.setBwriter(rs.getString("BWRITER"));
				bo.setBtitle(rs.getString("BTITLE"));
				bo.setBcontents(rs.getString("BCONTENTS"));
				bo.setBhits(rs.getInt("BHITS"));
				bo.setBstate(rs.getString("BSTATE"));
				boardList.add(bo);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return boardList;
	}

}
