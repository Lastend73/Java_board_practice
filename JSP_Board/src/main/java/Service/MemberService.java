package Service;

import dao.MemberDao;
import Dto.Member;

public class MemberService {
	
	MemberDao mdao = new MemberDao();

	// 아이디 중복 확인 기능
	public String memberIdCheck(String checkId) {
		System.out.println("service - memberIdCheck() 호출");
		String checkResult = "Y";
		
		// SELECT * FROM MEMBERS WHERE MID = ?
		Member mem = mdao.selctMemberInfo(checkId);
		if(mem != null) {
			System.out.println(mem);
			checkResult = "N";
			
		}
		
		return checkResult;
	}
	
// 로그인 - 회원정보 조회
	public int InsertInfo(Member joinMember) {
		System.out.println("회원정보 추가");
		int result = mdao.insertInfo(joinMember);
		return result;
	}

	public Member memberLogin(String inputID, String inputPW) {
		System.out.println("service - memberLogin()호출");
		Member memInfo = mdao.selectMemberLogin(inputID,inputPW);
		return memInfo;
	}

	public Member memberInfo(String infoId) {
		/*
		 1. SELECT * FROM MEMBERS WHERE MID = ?
		 
		 2. SELECT MID, MPW, MNAME, TO_CHAR('YYYY-MM-DD') FROM MEMBERS WHERE MID = ?
		 * */
		System.out.println("service - memberInfo()호출");
		Member meminfo = mdao.selctMemberInfo(infoId);
		String birthDate = meminfo.getMbirth().split(" ")[0];
		meminfo.setMbirth(birthDate);
		return meminfo;
	}
}
