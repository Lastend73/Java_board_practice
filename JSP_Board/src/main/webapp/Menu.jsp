<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="nav">
	<ul>
		<%-- boardList >> 요청 Boardcontroller --%>
		<li><a href="${pageContext.request.contextPath}/boardList">게시판</a></li>

		<c:choose>
							<%-- sessionScope.세션이름 --%>
			<c:when test="${sessionScope.loginMemberID == null }">
				<%-- 조건이 참일 경우 실행되는 코드 --%>
				<%-- 로그인이 되어 있지 않으면 적용 --%>
				
				<li><a href="${pageContext.request.contextPath}/memJoinForm">회원가입</a></li>
				<li><a href="${pageContext.request.contextPath}/memLoginForm">로그인</a></li>
			</c:when>

			<c:otherwise>
				<%-- 모든 조건이 일치하지 않으면 실행 --%>
				<%-- 로그인이 되어 있으면 적용 --%>
				<li><a href="${pageContext.request.contextPath}/myInfo">${sessionScope.loginMemberID}</a></li>
				<li><a href="${pageContext.request.contextPath}/memLogOut">로그아웃</a></li>
			</c:otherwise>

		</c:choose>

	</ul>
</div>