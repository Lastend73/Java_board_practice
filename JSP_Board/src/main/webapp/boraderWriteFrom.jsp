<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Main.css">
        <title>boraderWriteFrom</title>
    </head>
    <style>
        #border{
            width: 500px;
            border: 3px solid black;
            padding: 20px;
            background-color: white;
            margin-left: auto;
            margin-right: auto;
            border-radius: 10px;
            box-sizing: border-box;
        }
        .forminput{
            width: 100%;
            border: 0px;
            align-items: center;
        }
        input,textarea{
            width: 100%;
            border: 1px solid black;
            outline: none;
            padding: 3px;    
            border-radius: 10px;
            box-sizing: border-box;
        } 

        textarea{
            height: 300px;
        }

        input[type='submit']{
            background-color: bisque;
        }
    </style>
    <body>

        <div id="header" onclick="moveMain()">
            <h1>boraderWriteFrom.jsp</h1>
        </div>

        <%@ include file="/Menu.jsp" %>
            <div id="contents">
                <h1>boraderWriteFrom</h1>
                <form action="${pageContext.request.contextPath}/boradWrite" method="post">
                    <div id="border">

                        <div class="forminput">    
                            <input type="text" placeholder="글제목" name="btitle">
                        </div>
                        
                        <div class="forminput">
                            <textarea  placeholder="글내용" name="bcontents"></textarea>
                        </div>
                     
                        <div class="forminput">
                            <input type="submit" value="글등록">
                        </div>

                    </div>
                        
                </form>
            </div>
    </body>

    </html>