<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
                border: 1px solid black;
                border-radius: 7px;
                padding: 7px;
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                /*안애서 기록된 내용을 그대로 사용하겠습니다*/
            }

            .formInput>input[type='text'],
            .formInput>input[type='date'] {
                box-sizing: border-box;
                width: 100%;
                border: none;
                outline: none;
                padding: 3px;
                font-size: 20px;
            }

            .formInput>input[type='button'] {
                width: 100%;
                padding: 3px;
                border-radius: 10px;
                background-color: bisque;
                cursor: pointer;
                margin-bottom: 3px;
            }

            .formSubmit {
                border: none;
                margin-top: 5px;
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

            input[type='date'] {
                font-family: auto;
                /*폰트 설정을 자동으로 해준다*/
            }

            .formInputON {
                border: 2px solid green;
            }
            
            .formInputErr{
                border: 2px solid red !important;
            }

            .checkMsg {
                font-size: 13px;
                margin-top: 5px;
                margin-bottom: 5px;
                margin-left: 5px;
            }
</style>
<title>MyInfo</title>
</head>
<body>
	<div id="header">
        <h1>MyInfo.jsp</h1>
    </div>

    <%@ include file="/Menu.jsp" %>

    <div id="contents">
        <div class="formWrap">
            <form action="${pageContext.request.contextPath}/memJoin" method="post"
                onsubmit="return joinCheckForm(this) ">

                <%-- ${전달받은 response 이름.이름의 위치이름} --%>
                <div class="formInput">
                    <input type="text" placeholder="아이디" name="joinId" value="${minfo.mid}" disabled>
                </div>

                <div class="formInput">
                    <input type="text"  placeholder="비밀번호" name="joinPw" value="${minfo.mpw}" disabled>
                </div>

                <div class="formInput">
                    <input type="text" placeholder="이름" name="joinName" value="${minfo.mname}" disabled>
                </div>

                <%-- 받아온 생년월일 시분초 까지 받아오기 떄문에 잘라줘야함 --%>
                <div class="formInput">
                    <input type="date" placeholder="생년월일" name="joinBirth" value="${minfo.mbirth}" disabled>
                </div>

                <div class="formInput">
                    <input type="text"  name="extraAddress" value="${minfo.maddr}" disabled>
                </div>

              
            </form>
        </div>
    </div>
</body>

<script src="${pageContext.request.contextPath}/JS/Main.js"></script>
</html>