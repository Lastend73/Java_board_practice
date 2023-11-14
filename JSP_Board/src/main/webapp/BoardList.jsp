<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>게시판</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
            <style>
                .boardWrap {
                    padding: 10px;
                    background-color: white;
                    border-radius: 10px;
                    margin-bottom: auto;
                    margin-left: auto;
                    margin-right: auto;
                    width: 1000px;
                }

                .boardWrap>table {
                    width: 100%;
                    text-align: center;
                    border-collapse: collapse;
                }


                table,
                th,
                td {
                    padding-top: 7px;
                    padding-bottom: 7px;
                }

                .bTitle {
                    text-align: left;
                    padding-left: 15px;
                }

                table {
                    border: 2px solid #dfdfdf;
                }

                td {
                    border-top: 2px solid black;
                    border-bottom: 2px solid black;
                }

                .boardutil {
                    border: 0px;
                    margin-top: 10px;
                }
                .left{
                    text-align: left;
                }
            </style>

        </head>

        <body>
            <div id="header">
                <h1>BoardList.jsp</h1>
            </div>

            <%@ include file="/Menu.jsp" %>

                <div id="contents">
                    <h1>게시판</h1>
                    <div class="boardWrap">

                        <table>
                            <thead>
                                <tr>
                                    <th style="width: 66px" class="bTitle">번호</th>
                                    <th>제목</th>
                                    <th style="width: 115px">작성자</th>
                                    <th style="width: 80px">조회수</th>
                                </tr>
                            </thead>

                            <tbody>
                                <%-- bList 반복시작 --%>
                                <c:forEach items="${blist}" var="b">
                                    <tr>
                                        <td style="width: 66px" class="bTitle">${b.bno}</td>
                                        <td class="left"> <a href="${pageContext.request.contextPath}/boardView?viewBno=${b.bno}">${b.btitle}</a></td>
                                        <td>${b.bwriter}</td>
                                        <td>${b.bhits}</td>
                                    </tr>
                                </c:forEach>
                                    <%-- bList 반복 끝 --%>
                            </tbody>
                        </table>

                        <div class="boardutil">
                        
                            <c:if test="${sessionScope.loginMemberID != null }">
                                <button onclick="location.href ='${pageContext.request.contextPath}/boardWriteForm'">글작성</button>
                            </c:if>
                            <form action=${pageContext.request.contextPath}/boardSearch method="get">
                                <input type="text" name="searchTitle" placeholder="제목 검색...">
                                <input type="submit" value="검색">
                            </form>
                            
                        </div>

                    </div>
                </div>
        </body>
        <script src="${pageContext.request.contextPath}/JS/Main.js"></script>
        <script>

        </script>

        </html>