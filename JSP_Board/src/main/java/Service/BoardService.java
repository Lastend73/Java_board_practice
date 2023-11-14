package Service;

import java.util.ArrayList;

import Dto.Board;
import dao.BoardDao;

public class BoardService {
	BoardDao bdao = new BoardDao(); 
	
	public int boardWrite(Board board) {
		System.out.println("SERVICE - boardWrite() 호출");
		// board - 글제목, 글내용, 글 작성자
		// 1.새 글번호 생성
		/* 현재 등록된 글 번호의 최대값 + 1
		 * 글번호의 초대값 조회 : Select NVL(MAX(BNO),0) FROM BOARDS;
		 * */
		int bno = bdao.selectMaxBno()+1;
		if(bno == 0) {
			return 0;
		}
		board.setBno(bno);
		//2.DAO -INSERT INTO BOARDS VALUE(?, ?, ?, ?, 0, '1' 문 호출
		int result = bdao.insertBoard(board); // Insert문 실행
		return result;
	}

	public ArrayList<Board> getBoardList() {
		System.out.println("Service - getBoardList()호출");
		ArrayList<Board> blist = bdao.selectAll();
		return blist;
	}

	public Board getBoardView(int viewBno) {
		System.out.println("Service - getBoardView()호출");
		// dao - UPDATE BOARDS SET BHITS = BHITS + 1 WHERE BNO = ?
		bdao.updateBoardHits(viewBno);
		// dao - SELECT
		Board bo = bdao.getBoardview(viewBno);
		return bo;
		
		
	}

	public int boardUpdate(int upadteBno) {
		System.out.println("Service - boardDelete()호출");
		int result = bdao.updateView(upadteBno);
		return result;
	}

	public ArrayList<Board> getSerachBoard(String searchTitle) {
		System.out.println("Service - getSerachBoard()호출");
		
		ArrayList<Board> boardList =bdao.selectBoardSearch(searchTitle);
		return boardList;
	}

}
