<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MAIN</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
<style>
</style>

</head>
<body>
    <div id="header" onclick="moveMain()">
        <h1>Main.jsp</h1>
    </div>

    <%@ include file="/Menu.jsp" %>

    <div id="contents">
        <h1>컨텐츠 영역</h1>
        <!-- sessionScope.세션 영역의 값이름 (세션영역의 값을 불러온다) -->
        <h2>로그인 아이디 : ${sessionScope.loginMemberID}</h2>
    </div>
</body>


</html>