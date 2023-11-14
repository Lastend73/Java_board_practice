<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
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
                margin-bottom: 5px;
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

            .chkMsg {
                font-family: auto;
                font-size: 15px;
                margin-bottom: 0px;
                margin-top: 3px;
                color: red;
                font-weight: bold;
            }
            .checkMsg{
                color: red;
                font-size: 15px;
                margin: 0;
            }
            .d-none {
                display: none;
            }
        </style>

    </head>

    <body>
        <div id="header">
            <h1>LoginForm.jsp</h1>
        </div>

        <%@ include file="/Menu.jsp" %>

            <!-- 연습

            <div class="formWrap">
                <form action="${pageContext.request.contextPath}/memLogin" method="post"
                    onsubmit="return joinCheckForm(this) ">

                    <div class="formInput">
                        <input type="text" class="a" id="mid" placeholder="아이디" name="joinId">
                    </div>
                    <div class="formInput">
                        <input type="text" class="a" id="mpw" placeholder="비밀번호" name="joinPw">
                    </div>
                    <p id="chkMsg0" class="chkMsg"></p>
                    <p id="chkMsg1" class="chkMsg"></p>
                    <div class="formSubmit">
                        <input type="submit" value="로그인">
                    </div>
                </form>
            </div> -->

            <div id="contents">
                <div class="formWrap">
                    <form action="${pageContext.request.contextPath}/memLogin" method="post" onsubmit="return loginCheckForm(this) ">

                        <div class="formInput">
                            <input type="text" class="a" id="mid" placeholder="아이디" name="loginId">
                        </div>
                        <div class="formInput">
                            <input type="text" class="a" id="mpw" placeholder="비밀번호" name="loginPw">
                        </div>

                        <p class="checkMsg d-none" id="idMsg">아이디를 입력 해주세요!</p>
                        <p class="checkMsg d-none" id="pwMsg">비밀번호를 입력 해주세요!</p>

                       <div class="formSubmit">
                        <input type="submit" value="로그인">
                    </div>
                    </form>
                </div>
            </div>
    </body>
    <script src="${pageContext.request.contextPath}/JS/Main.js"></script>
    <!--  연습 스크립트
    <script>
        function joinCheckForm(idobj) {
            check = document.querySelectorAll(".a")
            console.log(check.length);
            for (let i = 0; i < check.length; i++) {
                if (check[i].value == "") {
                    document.getElementById("chkMsg" + i).textContent = check[i].getAttribute("placeholder") + "를 입력 해주세요!";
                } else {
                    document.getElementById("chkMsg" + i).textContent = "";
                }
            }
            return false;
        }

    </script> -->

    <script>
        function loginCheckForm(formobj){
            let idEl = formobj.loginId;
            let pwEl = formobj.loginPw;
            let checkForm = true;

            if(idEl.value == ""){
                document.getElementById("idMsg").classList.remove("d-none");
                checkForm = false;
            }else{
                document.getElementById("idMsg").classList.add("d-none");
            }

            if(pwEl.value == ""){
                document.getElementById("pwMsg").classList.remove("d-none");
                checkForm = false;
            }else{
                document.getElementById("pwMsg").classList.add("d-none");
            }

            return checkForm;
        }
    </script>

    </html>