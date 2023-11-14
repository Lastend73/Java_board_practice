<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>BoardView</title>
        </head>
        <meta charset="UTF-8">
        <title>로그인</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
        <style>
            .formWrap {
                width: 400px;
                border: 3px solid black;
                margin-bottom: 8px;
                padding: 10px;
                border-radius: 10px;
                background-color: white;
                margin-left: auto;
                margin-right: auto;
            }

            .formInput {
                margin-bottom: 0px;
                border: 1px solid #dfdfdf;
                padding: 7px;
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                /*안애서 기록된 내용을 그대로 사용하겠습니다*/
            }


            .formSubmit {
                border: none;
                margin-top: 5px;
                text-align: right;
            }

            .formSubmit>input {
                background-color: lightsalmon;
                width: 100%;
                padding: 10px;
                border-radius: 10px;
                font-weight: bold;
                cursor: pointer;
                /*마우스가 올라가면 커서가 포인터 형식으로 변환*/
            }

            .in {
                padding: 0px;
                padding-right: 10px;
                border: none;
                font-size: 15px;
            }

            .btn {
                border-radius: 5px;
                padding: 7px;
            }

            #title {
                font-size: 30px;
                font-weight: bold;
            }

            #third {
                padding-top: 25px;
                padding-bottom: 25px;
            }

            textarea{
                width: 100%;
                height: 200px;
                border: none;
                outline: none;
				resize: none;
            }
        </style>

        </head>

        <body>
            <div id="header">
                <h1>BoardView.jsp</h1>
            </div>

            <%@ include file="/Menu.jsp" %>


                <div id="contents">
                    <div class="formWrap">
                        <div class="formInput" id="title">
                            ${board.btitle}
                        </div>
                        <div class="formInput" id="secondline">
                            <div class="formInput in">
                               <p> 작성자 :<span>${board.bwriter}</span></p>
                            </div>

                            <div class="formInput in">
                                <p> 조회수 :<span>${board.bhits}</span></p>
                            </div>
                        </div>
                        <div class="formInput" id="third">
                           <textarea readonly="readonly">${board.bcontents}</textarea>
                        </div>
                        <div class="formSubmit" >
                        
                        	<c:if test="${sessionScope.loginMemberID == board.bwriter}">                   
                            	<button class="btn" style="background-color: aquamarine;">글수정</button>
                             
                                <%-- BSTATE = '1' >> '0' 으로 수정 
                                1. 요청URL  : /boardDelete
                                2. 글삭제 처리후
                                   '??번 글을 삭제하였습니다' 출력
                                   게시판(글목록페이지)로 이동
                                --%>
                            	<button class="btn" onclick="location.href ='${pageContext.request.contextPath}/boardDelete?viewBno=${board.bno}'" style="background-color: crimson;">글삭제</button>                        	
                        	</c:if>
                            
                            <button class="btn" onclick="location.href ='${pageContext.request.contextPath}/boardList' "style="background-color: lightsalmon;">글목록</button>
                        </div>
                    </div>
                </div>
        </body>
        <script src="${pageContext.request.contextPath}/JS/Main.js"></script>

        </html>