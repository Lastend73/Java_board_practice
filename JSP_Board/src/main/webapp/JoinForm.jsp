<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>회원가입</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
        <style type="text/css">
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


    </head>

    <body>
        <div id="header">
            <h1>JoinForm.jsp</h1>
        </div>

        <!--jsp 파일을 통째로 쓸때  -->
        <%@ include file="/Menu.jsp" %>


            <hr>

            <%-- 아이디(중복확인 - ajax), 비밀번호, 이름, 생년월일, 주소( 다음 우편 서비스) --%>

                <div id="contents">
                    <div class="formWrap">
                        <form action="${pageContext.request.contextPath}/memJoin" method="post"
                            onsubmit="return joinCheckForm(this) ">

                            <div class="formInput">
                                <input type="text" class="a" id="mid" placeholder="아이디" name="joinId"
                                    onblur="idCheck(this)">
                            </div>
                            <P class="checkMsg" id="idMsg"></P>
                            <div class="formInput">
                                <input type="text" class="a" id="mpw" placeholder="비밀번호" name="joinPw">
                            </div>

                            <div class="formInput">
                                <input type="text" class="a" id="mname" placeholder="이름" name="joinName">
                            </div>
                            <div class="formInput">
                                <input type="date" class="a" id="mbirth" placeholder="생년월일" name="joinBirth">
                            </div>

                            <div class="formInput">
                                <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                                <input type="text"  name="postcode" id="sample6_postcode" placeholder="우편번호">
                                <input type="text"  name="address" id="sample6_address" placeholder="주소"><br>
                                <input type="text"  name="detailAddress" id="sample6_detailAddress"
                                    placeholder="상세주소">
                                <input type="text" class="a" name="extraAddress" id="sample6_extraAddress"
                                    placeholder="참고항목">
                            </div>

                            <div class="formSubmit">
                                <input type="submit" value="회원가입" onclick="success()">
                            </div>
                        </form>
                    </div>

                    <!-- <div style="border: none;">
                            <form action="${pageContext.request.contextPath}/memJoin" method="post">
                                <table>
                                    <tr>
                                        <th> 아이디 </th>
                                        <td> <input type="text" name="joinId"></td>
                                    </tr>

                                    <tr>
                                        <th> 비밀번호 </th>
                                        <td> <input type="text" name="joinPw"></td>
                                    </tr>

                                    <tr>
                                        <th> 이름 </th>
                                        <td> <input type="text" name="joinName"></td>
                                    </tr>

                                    <tr>
                                        <th> 생년월일 </th>
                                        <td> <input type="date" name="joinBirth"></td>
                                    </tr>

                                    <tr>
                                        <th> 주소 </th>
                                        <td>
                                            <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호">
                                            <input type="button" onclick="sample6_execDaumPostcode()"
                                                value="우편번호 찾기"><br>
                                            <input type="text" name="address" id="sample6_address" placeholder="주소"><br>
                                            <input type="text" name="detailAddress" id="sample6_detailAddress"
                                                placeholder="상세주소">
                                            <input type="text" name="extraAddress" id="sample6_extraAddress"
                                                placeholder="참고항목">
                                        </td>
                                    </tr>

                                    <tr>
                                        <th colspan="2"><input type="submit" value="회원가입"></th>
                                    </tr>

                                </table>
                            </form>
                        </div> -->
                    <!-- div contents end-->
                </div>
    </body>
    <!-- JQuery 참조문-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

    
    <!-- 아이디 중복 확인 시작-->
    <script>
        function idCheck(idTag) {
            console.log("입력한 아이디 : " + idTag.value);
            // ajax - 아이디 중복 확인 요청
            $.ajax({
                type: "get",  // method랑 같은거 (get, post)
                url: "menIdCheck", /*요청 url*/
                data: { "inputId": idTag.value }, // 요청을 보내줄 데이터 (송신 데이터)
                // -------------- controller 이후 돌아온 답변으로 실헹 ----------------

                success: function (result) { //요청이 되면 실행이 될 함수 function (result)의 result 는 결과값
                    if (result == "Y") {
                        console.log("사용가능한 아이디");
                        $("#idMsg").css("color","green").text('사용가능한 아이디입니다.');
                        $(idTag).parent().removeClass('formInputErr');
                    } else {
                        console.log("중복된 아이디");
                        $("#idMsg").css("color","red").text('이미 가입된 아이디입니다');
                        $(idTag).parent().addClass('formInputErr');
                    }
                }
            });
            // error : function(){ //전송에 실패하면 전동 될 함수
            // dataType = "text", // 서버에서 응답받은 데이터 타입(수신데이터)
        }
        
    </script>
   

    <!-- 회원가입 양식 JS 시작-->
    <script type="text/javascript">
        let inputEls = document.querySelectorAll(".formInput>input");
        console.log(inputEls.length);

        // let classcheck = document.querySelectorAll(".a")
        // console.log(classcheck.length);

        // console.log(classcheck[0]);
        // console.log(classcheck[0].getAttribute('class'));


        for (let obj of inputEls) {
            obj.addEventListener("focus", function () {
                obj.parentElement.classList.add("formInputON");
            });

            obj.addEventListener("blur", function () {
                obj.parentElement.classList.remove("formInputON");
            });
        }


        function joinCheckForm(formObj) {
            // 아이디 - 주소 모두 입력되어 있으면 submit 실행
            // 하나 라도 미빕력 되어있므녀 submit 중지
            // 미입력된 항목으로 포커스

            // formObj.[name 과 id 둘다 구별 가능 추가 X]
            if (formObj.mid.value == "") {
                alert("아이디가 입력되지 않았습니다!");
                console.log(formObj.a.length);
                formObj.mid.focus()
                return false;
            }

            if (formObj.mpw.value == "") {
                alert("비밀번호가 입력되지 않았습니다!");
                formObj.mpw.focus()
                return false;
            }

            if (formObj.mname.value == "") {
                alert("성함이 입력되지 않았습니다!");
                formObj.mname.focus()
                return false;
            }

            if (formObj.mbirth.value == "") {
                alert("생년월일이 입력되지 않았습니다!");
                formObj.mbirth.focus()
                return false;
            }

            // 연습
            // for(let i = 0; i < classcheck.length; i++){
            //     if(classcheck[i].value == ""){
            //         alert(classcheck[i].placeholder +"(을/를) 입력해주세요");
            //         classcheck[i].focus();
            //         return false;
            //     }
            // }

            // return true;
        }

    </script>

    <script src="${pageContext.request.contextPath}/JS/Main.js"></script>

    <!--다음 우편 서비스-->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
    
                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수
    
                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }
    
                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if(data.userSelectedType === 'R'){
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        document.getElementById("sample6_extraAddress").value = extraAddr;
                    
                    } else {
                        document.getElementById("sample6_extraAddress").value = '';
                    }
    
                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById("sample6_address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }
    </script>

    </html>