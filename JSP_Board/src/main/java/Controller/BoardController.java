package Controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Dto.Board;
import Service.BoardService;

/**
 * Servlet implementation class BoardController
 */
@WebServlet({ "/boardList", "/boardWriteForm", "/boradWrite","/boardView","/boardDelete","/boardSearch"})
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BoardController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String url = request.getServletPath();
		String path = request.getContextPath();
		request.setCharacterEncoding("UTF-8"); // post 타입의 요청을 인코딩 방법
		System.out.println(path + url);
		
		BoardService bsvc = new BoardService();

		switch (url) {
		case "/boardView" :
			System.out.println("글 상세보기 페이지 이동 요청");
			int viewBno =Integer.parseInt(request.getParameter("viewBno"));
			System.out.println("상세보기 글번호 : " + viewBno);
			// 1. 상세보기 할 글
			// SELECT * FROM BOARDS WHERE BNO = ?
			Board bo = bsvc.getBoardView(viewBno); // bsvc.aaaa();
			request.setAttribute("board", bo);
			request.getRequestDispatcher("BoardView.jsp").forward(request, response);
			break;
		case "/boardList":
			System.out.println("게시판 이동 요청");
			// 1.Board 게시글 목록 조회
			// SELECT * FROM BOARDS WHERE BSTATE = '1';
			 ArrayList<Board> blist = bsvc.getBoardList();	
			request.setAttribute("blist", blist);
//			response.sendRedirect(path + "/BoardList.jsp");

			// 2. 게시판 페이지로 응답
			request.getRequestDispatcher("BoardList.jsp").forward(request, response);
			break;
			
		case "/boardWriteForm":
			System.out.println("글작성 페이지 이동요청");
			response.sendRedirect("boraderWriteFrom.jsp");
			break;
		case "/boradWrite":
			System.out.println("글 등록 요청");
			String bwriter = (String) request.getSession().getAttribute("loginMemberID");
			String btitle = request.getParameter("btitle");
			String bcontents = request.getParameter("bcontents");
			if (bwriter == null) {
				response.sendRedirect(path + "/Success.jsp" + "?msg=" + URLEncoder.encode("로그인 후 이용가능 합니다", "UTF-8")
				+ "&url=" + URLEncoder.encode(path + "/memLoginForm", "UTF-8"));
			} else {
				System.out.println("제목 : " + btitle );
				System.out.println("내용 : " + bcontents);
				Board board = new Board();
				board.setBtitle(btitle);
				board.setBcontents(bcontents);
				board.setBwriter(bwriter);
				
				// 2. Service 글 등록 기능 호출
				int writeResult = bsvc.boardWrite(board);
			
				// 3. 등록 결과 확인 및 응답;
				if(writeResult > 0) {
					System.out.println("글 등록 성공");
					
					//게시판 페이지
					response.sendRedirect(path + "/Success.jsp" + "?msg=" + URLEncoder.encode("새 글이 등록 되었습니다", "UTF-8")
					+ "&url=" + URLEncoder.encode(path + "/boardList", "UTF-8"));
				}else {
					System.out.println("글 등록 실패");
					
					//글 작성 하기
					response.sendRedirect(path + "/Fail.jsp" + "?msg" + "=" + URLEncoder.encode("회원가입에 실패하였습니다", "UTF-8"));
				}
			}

			break;
			
		case "/boardDelete" :
			System.out.println("글 삭제 요청");
			int upadteBno =Integer.parseInt(request.getParameter("viewBno"));
			System.out.println("상세보기 글번호 : " + upadteBno);
			int result = bsvc.boardUpdate(upadteBno);
			
			if(result > 0) {
				System.out.println("삭제 성공");
				response.sendRedirect(path + "/Success.jsp" + "?msg=" + URLEncoder.encode(upadteBno+"번 글을 삭제하였습니다", "UTF-8")
				+ "&url=" + URLEncoder.encode(path + "/boardList", "UTF-8"));
				
			} else {
				System.out.println("삭제 실패");
				response.sendRedirect(path + "/Fail.jsp" + "?msg" + "=" + URLEncoder.encode("글 삭제에 실패하였습니다", "UTF-8"));
				
				
			}
			break;
			
		case "/boardSearch":
			System.out.println("게시글 검색요청");
			String searchTitle = request.getParameter("searchTitle");
			System.out.println("검색어 : " + searchTitle);
			/* SELECT * FROM BOARDS BESTATE = '1' AND BTITLE LIKE '%2023%'*/
			ArrayList<Board> searchBList = bsvc.getSerachBoard(searchTitle);
			request.setAttribute("blist", searchBList);

			// 2. 게시판 페이지로 응답
			request.getRequestDispatcher("BoardList.jsp").forward(request, response);

			break;
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
