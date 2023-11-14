package Controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Dto.Member;
import Service.MemberService;

/**
 * Servlet implementation class MemberController
 */
@WebServlet({ "/main", "/memJoinForm", "/memLoginForm", "/memJoin", "/menIdCheck", "/memLogin", "/memLogOut",
		"/myInfo" })
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public MemberController() {
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
		
		// 회원 관련 기능 Service
		MemberService msvc = new MemberService();

		System.out.println("path : " + path);
		System.out.println("url : " + url);
		System.out.println(path + url);

		HttpSession session = request.getSession();
		
		switch (url) {
		case "/main":
			System.out.println("메인페이지 이동요청");
			response.sendRedirect(path + "/Main.jsp");
			break;

		case "/memJoinForm":
			System.out.println("회원가입 페이지 이동 요청");
			response.sendRedirect(path + "/JoinForm.jsp");
			break;

		case "/menIdCheck":
			System.out.println("아이디 중복 확인 요청");
			String checkId = request.getParameter("inputId");
			System.out.println("확인할 아이디 : " + checkId);

			// 2. 아이디 중복 확인 가능(service) 호출
			String res = msvc.memberIdCheck(checkId);
			response.getWriter().print(res); // 응답
			break;

		case "/memLoginForm":
			System.out.println("로그인 페이지 이동 요청");
			response.sendRedirect(path + "/LoginForm.jsp");
			break;

		case "/memJoin":
			System.out.println("회원가입 요청");
			// 1. 파라미터 확인
			String joinId = request.getParameter("joinId");
			System.out.println("입력한 아이디 : " + joinId);
			Member joinMember = new Member();
			// 각종 정보 입력
			joinMember.setMid(joinId);
			joinMember.setMpw(request.getParameter("joinPw"));
			joinMember.setMname(request.getParameter("joinName"));
			joinMember.setMbirth(request.getParameter("joinBirth"));

			// 주소코드 합치기
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailAddress = request.getParameter("detailAddress");
			String extraAddress = request.getParameter("extraAddress");

			String maddr = postcode + "_" + address + "_" + detailAddress + "_" + extraAddress;
			joinMember.setMaddr(maddr);
			System.out.println(joinMember);

			String joinPw = request.getParameter("joinPw");
			System.out.println("입력한 비밀번호 : " + joinPw);

			String joinName = request.getParameter("joinName");
			System.out.println("입력한 성함 : " + joinName);

			// 2. 회원가입 처리 서비스 호출
			int result = msvc.InsertInfo(joinMember);
			// 3. 회원가입결과 확인
			if (result > 0) {
				// 4. 회원가입 성공 >> "회원가입에 성공하였습니다"|메인페이지로
				System.out.println("회원가입에 성공했습니다");
				// /Success.jsp?변수명=값&변수명 = 값"
				String joinMsg = "회원 가입에 성공하였습니다";
				String joinUrl = path + "/main";
				response.sendRedirect(path + "/Success.jsp" + "?" + "msg" + "=" + URLEncoder.encode(joinMsg, "UTF-8")
						+ "&" + "url" + "=" + URLEncoder.encode(joinUrl, "UTF-8"));
			} else {
				// 회원가입 실패 >> "회원가입에 실패하였습니다"|회원가입 페이지로
				System.out.println("회원가입에 실패했습니다");
				String joinMsg = "회원 가입에 실패하셨습니다";
				String joinUrl = path + "/main";
				response.sendRedirect(path + "/Fail.jsp" + "?msg" + "=" + URLEncoder.encode("회원가입에 실패하였습니다", "UTF-8"));

			}
			break;

		case "/memLogin":
			System.out.println("로그인 요청");
			// 1. 아이디, 비밀번호 파라미터 확인
			String inputID = request.getParameter("loginId");
			String inputPW = request.getParameter("loginPw");
			System.out.println("입력한 아이디 : " + inputID);
			System.out.println("입력한 비밀번호 : " + inputPW);
			// 2. SERVICE - 회원정보를 조회 SELECT * FROM MEMBERS WHERE MID = ? AND MPW =?
			Member memInfo = msvc.memberLogin(inputID, inputPW);

			if (memInfo == null) {
				System.out.println("로그인 실패");
				response.sendRedirect(
						path + "/Fail.jsp" + "?msg=" + URLEncoder.encode("아이디 또는 비밀번호가 일치하지 않습니다.", "UTF-8"));
			} else {
				System.out.println("로그인 성공");

				// 세션 영역에 저장하는 명령어 session.setAttribute("이름","넣어줄 값")
				session.setAttribute("loginMemberID", memInfo.getMid());

				response.sendRedirect(path + "/Success.jsp" + "?msg=" + URLEncoder.encode("로그인에 성공하였습니다", "UTF-8")
						+ "&url=" + URLEncoder.encode(path + "/main", "UTF-8"));

				// 로그인 처리 - 세션
			}
			break;

		case "/memLogOut":
			System.out.println("로그아웃 요청");
			session.removeAttribute("loginMemberID");
			response.sendRedirect(path + "/Success.jsp" + "?msg=" + URLEncoder.encode("로그아웃 되었습니다.", "UTF-8") + "&url="
					+ URLEncoder.encode(path + "/main", "UTF-8"));
			break;

		case "/myInfo":
			System.out.println("내 정보 확인 페이지 이동 요청");
			String infoId = (String) session.getAttribute("loginMemberID");
			System.out.println(infoId);
			if (infoId == null) {
				response.sendRedirect(path + "/Success.jsp" + "?msg=" + URLEncoder.encode("로그인 후 이용가능 합니다", "UTF-8")
						+ "&url=" + URLEncoder.encode(path + "/memLoginForm", "UTF-8"));

//				response.sendRedirect(path + "/Fail.jsp" + "?msg" + "=" + URLEncoder.encode("로그인 후 이용가능 합니다", "UTF-8"));
			} else {

				// SERVICE - 회원 정보 조회

				// SELECT * FROM MEMBERS WHERE MID = 로그인된 아이디.
				Member memberInfo = msvc.memberInfo(infoId);
				System.out.println(memberInfo);
				
//				request.setAttribute("이름", 값);
				request.setAttribute("minfo", memberInfo);
				
				// request.getRequestDispatcher("넘어갈 페이지").forward(request, response);
				request.getRequestDispatcher("myInfo.jsp").forward(request, response);
			}

			// myInfo.jsp 응답
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
