<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- memberEnrollForm.jsp 태그리브 지시어 추가 0604 - 무진 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <!-- jQuery library -->
    <!-- 온라인 방식 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css" />
    <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
    <!-- 부트스트랩 및 각종 연동구문 추가 0603 -무진 -->
     <!-- alertify 연동 구문 -->
     <!-- 부트스트랩에서 제공하고 있는 스타일 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- 부트스트랩에서 제공하고 있는 스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- JavaScript -->
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
	
	<!-- CSS -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
	<!-- Default theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
	<!-- Semantic UI theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>
</head>
<body>
	<!-- myPage.jsp 일회성 알람문구 처리 script 0604 - 무진 -->
		<c:if test="${not empty sessionScope.alertMsg }">
			<script>
			alertify.alert('알림', '${sessionScope.alertMsg}', function(){ alertify.success('Ok'); });
			</script>
			<c:remove var="alertMsg" scope="session"/>
		</c:if>
    <!-- 회원가입 폼(임시)  0604 - 무진 -->
    <!-- 메뉴바 -->
    <jsp:include page="" />

    <div class="content">
        <br><br>
        <div class="innerOuter">
            <h2>회원가입</h2>
            <br>

            <form action="insert.me" method="post" id="enrollForm">
                <div class="form-group">
                    <label for="userId">* ID : </label>
                    <input type="text" class="form-control" id="userId" placeholder="Please Enter ID" name="userId" required> <br>

					<div id="checkResult" style="font-size: 0.8em; display: none;"></div>
					<br>
					
                    <label for="userPwd">* Password : </label>
                    <input type="password" class="form-control" id="userPwd" placeholder="Please Enter Password" name="userPwd" required> <br>

                    <label for="checkPwd">* Password Check : </label>
                    <input type="password" class="form-control" id="checkPwd" placeholder="Please Enter Password" required> <br>

                    <label for="userName">* Name : </label>
                    <input type="text" class="form-control" id="userName" placeholder="Please Enter Name" name="userName" required> <br>

                    <label for="email"> &nbsp; Email : </label>
                    <input type="text" class="form-control" id="email" placeholder="Please Enter Email" name="email"> <br>

                    <label for="age"> &nbsp; Age : </label>
                    <input type="number" class="form-control" id="age" placeholder="Please Enter Age" name="age"> <br>

                    <label for="phone"> &nbsp; Phone : </label>
                    <input type="tel" class="form-control" id="phone" placeholder="Please Enter Phone (-없이)" name="phone"> <br>
                    
                    <label for="address"> &nbsp; Address : </label>
                    <input type="text" class="form-control" id="address" placeholder="Please Enter Address" name="address"> <br>
                    
                    <label for=""> &nbsp; Gender : </label> &nbsp;&nbsp;
                    <input type="radio" id="Male" value="M" name="gender" checked>
                    <label for="Male">남자</label> &nbsp;&nbsp;
                    <input type="radio" id="Female" value="F" name="gender">
                    <label for="Female">여자</label> &nbsp;&nbsp;
                </div> 
                <br>
                <div class="btns" align="center">
                    <button type="submit" class="btn btn-primary" disabled="disabled">회원가입</button>
                    <button type="reset" class="btn btn-danger">초기화</button>
                </div>
            </form>
        </div>
        <br><br>
        
        <script>
        	$(function() {
				
        		// 아이디를 입력할 수 있는 input 요소 객체를 변수에 담아두기
        		const $idInput = $("#enrollForm input[name=userId]");
        		
        		// 아이디를 입력할 때마다 실시간으로 아이디 중복 체크
        		// > "keyup" 이벤트 활용
        		$idInput.keyup(function() {
        			
        			// > 사용자가 실시간으로 입력한 아이디 값을 중복체크 시 요청값으로 넘기기
        			// 우선, 아이디값이 최소 5글자 이상으로 입력되었을 때만
        			// ajax 를 요청해서 중복 체크 하기!!
        			// 유료 DB 제품은 실행하는 쿼리문의 갯수가 몇개냐에 따라 요금제가 지정됨
        			if($idInput.val().length >= 5){
        				// 5글자 이상일떄 ajax 로 아이디 중복확인 요청 보내기
        				$.ajax({
        					
        					url : "idCheck.me",
        					type : "get",
        					data : {
        						checkId : $idInput.val()
        					},
        					success : function(result) {
        						//console.log(result);
        						
        						if(result == "NNNNN"){
        							// 사용 불가한 아이디일 경우
        							
        							// 빨간색 메세지로 출력
        							$("#checkResult").show()
        							.css("color", "red")
        							.text("이미 사용중이거나 탈퇴한 회원의 아이디입니다. 다시 입력해 주세요.");
        							
        							// 혹시 모를 상황에 대비해서
        							// 회원가입 버튼 비활성화
        							$("#enrollForm button[type=submit]").attr("disabled", true);
        						}else {
									// 사용 가능한 아이디인 경우
									// 초록색 메세지로 출력
									$("#checkResult").show().css("color", "green").text("멋진 아이디네요!");
									
									// 회원 가입 버튼 활성화
									$("#enrollForm button[type=submit]").attr("disabled", false);
								}
        						
							},
							error : function() {
								console.log("아이디 중복 체크용 ajax 통신 실패!!");
							}
        				});
        			}else {
						// 5글자 미만일 때
						
						// 메세지 숨김처리하고 회원가입버튼 비활성화
        				$("#enrollForm button[type=submit]").attr("disabled", true);
        				$("#checkResult").hide();
					}
        		});
        		
        		
			});
        </script>

    </div>

    <!-- 푸터바 -->
    <jsp:include page="" />

</body>
</html>