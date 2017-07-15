<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style type="text/css">
.error{
	font-size : 8px;
	color : red;
}
th, td {
	padding-right : 5px;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">

var pwdChk = false; //비밀번호 값 검사 체크값
var phoneDuplicationChk = false; //핸드폰번호 중복검사 체크값 

$(document).ready(function() {
	
	////////////////////비밀번호 값 검사 
	$("#adminPwd").focus(function(){
		$("#pwdMsg").empty();
		$("#pwdMsg").append("8-12자의 영문대소문자, 숫자, 특수문자만 가능.");
		$("#pwdMsg").show();
	});
	$("#adminPwd").blur(function(){
		if($("#adminPwd").val().length>7 && $("#adminPwd").val().length<13){
			$("#pwdMsg").hide();
			pwdChk = true;
		}
	});
	//비밀번호확인 검사 
	$("#adminPwdCheck").change(function(){
		if($("#adminPwd").val() != $("#adminPwdCheck").val()){
			$("#pwdChkMsg").empty();
			$("#pwdChkMsg").append("비밀번호를 다시 확인해주세요."); 
			$("#pwdChkMsg").show();		
		}else{
			$("#pwdChkMsg").hide();
		}
	});
	
	
	////////////////////핸드폰번호 인증
	/* $("#adminPhoneChk").on("click", function(){
		$.ajax({
			"url" : "/MMONG/admin/checkadminPhone.do",
			"data" : {"adminPhone":$("#adminPhone").val()},
			"dataType" : "text",
			"success":function(response) {
				if(response==1) {
					$("#phoneMsg").empty();
					$("#phoneMsg").append("이미 가입된 핸드폰번호입니다.");
					$("#phoneMsg").show();
				} else {
					$("#phoneMsg").empty();
					$("#phoneMsg").append("사용 가능합니다.");
					$("#phoneMsg").show();
					phoneDuplicationChk = true;
				}
			}
		});	
	}); */
	$("#adminPhone").blur(function(){
		if($("#adminPhone").val()==""){
			$("#phoneMsg").empty();
			$("#phoneMsg").append("핸드폰번호는 필수 입력값입니다.");
			$("#phoneMsg").show();
		}/* else if(phoneDuplicationChk==false){
			$("#phoneMsg").empty();
			$("#phoneMsg").append("핸드폰번호 인증을 해 주세요.");
			$("#phoneMsg").show();
		} */
	});	
	//핸드폰번호 숫자만 받게
	 $("#adminPhone").keyup(function(event){
         if (!(event.keyCode >=37 && event.keyCode<=40)) {
             var inputVal = $(this).val();
             $(this).val(inputVal.replace(/[^0-9]/gi,''));
         }
     });
	////////////////////이메일 비었는지 체크 
	 $("#adminEmail").blur(function(){
		 if($("#adminAddress1").val()==""){
			$("#emailMsg").empty();
			$("#emailMsg").append("이메일을 입력하세요.");
			$("#emailMsg").show();
		 }else{
			 $("#emailMsg").hide();
		 }
	 });
	 


});//ready fucntion끝

//가입 버튼 누르기 전 값 유효성 검사하기 위한 함수들
function formChk() {
	var result = true;
	
	//비밀번호 비었는지 검사
	 if(!$("#adminPwd").val()){
		alert("비밀번호를 입력하세요");
		$("#adminPwd").focus();
		result = false;
     }else if(!$("#adminPwdCheck").val()){
		alert("비밀번호 확인을 입력하세요");
		$("#adminPwdCheck").focus();
		result = false;
	 }else if($("#adminPwd").val() != $("#adminPwdCheck").val()){
		$("#pwdMsg").empty();
		$("#pwdChkMsg").empty();
		$("#pwdChkMsg").append("비밀번호를 다시 확인해주세요.");
		alert("비밀번호를 다시 확인해 주세요");
		$("#pwdChkMsg").show();
		$("#adminPwd").focus();
		result = false;
	}else if($("#adminPwd").val().length<7 || $("#adminPwd").val().length>13){
		alert("비밀번호는 8~12자리입니다");
		result = false;
	}else if($("#adminPhone").val()==""){
		$("#phoneMsg").empty();
		$("#phoneMsg").append("핸드폰번호는 필수 입력값입니다.");
		$("#phoneMsg").show();
		$("#adminPhone").focus();
		result = false;
	}else if($("#adminEmail").val()==""){
		$("#emailMsg").empty();
		$("#emailMsg").append("이메일을 입력하세요.");
		$("#emailMsg").show();
		$("#adminEmail").focus();
		result = false;
	}
	return result;
}//formChk함수 끝

function formSubmit(){
    if(formChk()){ // formChk 값이 true일경우만 submit
    	//$("#adminEmail").val($("#adminEmail1").val() + "@" + $("#adminEmail2").val()); //이메일 @ 전후로 합쳐서 hidden태그에 넣기 
    	$("#insert").submit();
    }
}
</script>


	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 관리자 정보 수정하기
		</h3>

	<form name="updateFrom" id="insert" action="/MMONG/admin/info_admin.do" method="post">
		<table>
			<tr>
				<td>ID :</td>
				<td><input type="text" id="adminId" name="adminId" readonly value="${requestScope.administrator.adminId}" style="background-color: #e2e2e2;"><br></td>
			</tr>
			<tr>
				<td>새 비밀번호 :</td>
				<td><input type="password" id="adminPwd" name="user.userPwd">
				<td>
			</tr>
			<tr>
				<td></td>
				<td class="error">
					<form:errors path="administrator.user.userPwd" delimiter="<br>"/>
					<div id="pwdMsg" style="display:none"></div>
				</td>
			</tr>
			<tr>
				<td>새 비밀번호 확인 :</td>
				<td><input type="password" id="adminPwdCheck" name="userPwd2"></td>
			</tr>
			<tr>
				<td></td>
				<td class="error">
				<div id="pwdChkMsg" style="display:none"></div>
				</td>
			</tr>
			<tr>
				<td>이름 :</td>
				<td><input type="text" id="adminName" name="adminName" readonly value="${requestScope.administrator.adminName}" style="background-color: #e2e2e2;"></td>
			</tr>
			<tr>
				<td></td>
				<td class="error">
				<div id="nameMsg" style="display:none"></div>
				</td>
			</tr>			
			<tr>
				<td>핸드폰번호 :<br> <font size="2em" color="green"> - 없이 숫자만 입력해주세요.</font>
				</td>
				<td><input type="number" id="adminPhone" name="adminPhone" value="${requestScope.administrator.adminPhone}"></td>
						<!-- <input type="button" id="memberPhoneChk" value="인증"/></td> -->
			</tr>
			<tr>
				<td></td>
				<td class="error">
					<form:errors path="administrator.adminPhone" delimiter="<br>"/>
					<div id="phoneMsg" style="display:none"></div>
			</td>			
			<tr>
				<td>이메일 :</td>
				<td><input type="text" id="adminEmail" name="adminEmail" value="${requestScope.administrator.adminEmail}"></td>
			</tr>
			<tr>
				<td></td>
				<td class="error">
				<div id="emailMsg" style="display:none"></div>
				</td>
			</tr>			
			<tr>
				<td>권한 :</td>
				<td><input type="text" name="user.userAuthority" readonly value="${requestScope.administrator.user.userAuthority}" style="background-color: #e2e2e2;"></td>
			</tr>
			<tr>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<input type="button" value="수정" onClick="formSubmit(); return false;" />&nbsp;
				<input type="reset" value="다시 작성">
			</tr>
		</table>
	</form>

	</section>