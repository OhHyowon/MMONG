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

var sizeChk = true; //아이디 길이 체크값
var idDuplicationChk = false; //아이디 중복검사 체크값
var pwdChk = false; //비밀번호 값 검사 체크값
var phoneDuplicationChk = false; //핸드폰번호 중복검사 체크값 

$(document).ready(function() {
	
	////////////////////아이디 길이 값 검사 
	$("#memberId").focus(function(){
		$("#idMsg").empty();
		$("#idMsg").append("8-12글자의 영/소문자/숫자 사용.");
		$("#idMsg").show();
		sizeChk = false;
	});
	//아이디 중복검사 
	$("#idChk").on("click", function(){
		$.ajax({
			"url" : "/MMONG/member/checkMemberId.do",
			"data" : {"memberId":$("#memberId").val()},
			"dataType" : "text",
			"beforeSend":function(){
				if(sizeChk==false){
					$("#idMsg").empty();
					$("#idMsg").append("8-12글자의 영/소문자/숫자 사용.");
					$("#idMsg").show();
					$("#memberId").focus();
					return false;
				}
			},
			"success":function(response) {
				sizeChk = true; //아이디 길이 값은 제대로 된 값이 넘어올때 ajax를 호출하므로 true로 변경
				if(response==1) {
					$("#idMsg").empty();
					$("#idMsg").append("'"+$("#memberId").val()+"'은(는) 이미 사용중인 아이디입니다.");
					$("#idMsg").show();
				} else {
					$("#idMsg").empty();
					$("#idMsg").append("사용가능한 아이디입니다.");
					$("#idMsg").show();
					idDuplicationChk = true;
				}
			}
		});
	});
	//길이 값, 중복 검사
	$("#memberId").blur(function(){
		if($("#memberId").val().length>7 && $("#memberId").val().length<13){
			sizeChk = true;
		}	
		if(idDuplicationChk==false){
			$("#idMsg").empty();
			$("#idMsg").append("아이디 중복확인을 해 주세요.");
			$("#idMsg").show();
		}
	});	
	

	////////////////////비밀번호 값 검사 
	$("#memberPwd").focus(function(){
		$("#pwdMsg").empty();
		$("#pwdMsg").append("8-12자의 영문대소문자, 숫자, 특수문자만 가능.");
		$("#pwdMsg").show();
	});
	$("#memberPwd").blur(function(){
		if($("#memberPwd").val().length>7 && $("#memberPwd").val().length<13){
			$("#pwdMsg").hide();
			pwdChk = true;
		}
	});	
	//비밀번호확인 검사 
	$("#memberPwdCheck").change(function(){
		if($("#memberPwd").val() != $("#memberPwdCheck").val()){
			$("#pwdChkMsg").empty();
			$("#pwdChkMsg").append("비밀번호를 다시 확인해주세요."); //비밀번호 폼을 바꿨을경우도.. 
			$("#pwdChkMsg").show();		
		}else{
			$("#pwdChkMsg").hide();
		}
	});
	
	
	////////////////////핸드폰번호 인증
	$("#memberPhoneChk").on("click", function(){
		$.ajax({
			"url" : "/MMONG/member/checkMemberPhone.do",
			"data" : {"memberPhone":$("#memberPhone").val()},
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
	});
	$("#memberPhone").blur(function(){
		if($("#memberPhone").val()==""){
			$("#phoneMsg").empty();
			$("#phoneMsg").append("핸드폰번호는 필수 입력값입니다.");
			$("#phoneMsg").show();
		}else if(phoneDuplicationChk==false){
			$("#phoneMsg").empty();
			$("#phoneMsg").append("핸드폰번호 인증을 해 주세요.");
			$("#phoneMsg").show();
		}
	});	
	//핸드폰번호 숫자만 받게
	 $("#memberPhone").keyup(function(event){
         if (!(event.keyCode >=37 && event.keyCode<=40)) {
             var inputVal = $(this).val();
             $(this).val(inputVal.replace(/[^0-9]/gi,''));
         }
     });
	
	
	////////////////////이름 비었는지 체크 
	 $("#memberName").blur(function(){
		 if($("#memberName").val()==""){
			$("#nameMsg").empty();
			$("#nameMsg").append("이름을 입력하세요.");
			$("#nameMsg").show();
		 }else{
			 $("#nameMsg").hide();
		 }
	 });	
	////////////////////닉네임 비었는지 체크 
	 $("#nickName").blur(function(){
		 if($("#nickName").val()==""){
			$("#nickNameMsg").empty();
			$("#nickNameMsg").append("닉네임을 입력하세요.");
			$("#nickNameMsg").show();
		 }else{
			 $("#nickNameMsg").hide();
		 }
	 });
	////////////////////주소 비었는지 체크 
	 $("#memberAddress").blur(function(){
		 if($("#memberAddress").val()==""){
			$("#addressMsg").empty();
			$("#addressMsg").append("주소를 입력하세요.");
			$("#addressMsg").show();
		 }else{
			 $("#addressMsg").hide();
		 }
	 });
	////////////////////이메일 비었는지 체크 
	 $("#memberEmail1").blur(function(){
		 if($("#memberAddress1").val()==""){
			$("#emailMsg").empty();
			$("#emailMsg").append("이메일을 입력하세요.");
			$("#emailMsg").show();
		 }else{
			 $("#emailMsg").hide();
		 }
	 });
	 $("#memberEmail2").blur(function(){
		 if($("#memberAddress2").val()==""){
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
	if($("#memberId").val()==""){
		$("#idMsg").empty();
		$("#idMsg").append("아이디를 입력하세요.");
		$("#idMsg").show();
		$("#memberId").focus();
		result = false;
	}else if(sizeChk==false){
		$("#idMsg").empty();
		$("#idMsg").append("8-12글자의 영/소문자/숫자 사용.");
		$("#idMsg").show();
		$("#memberId").focus();
		sizeChk = true;
		result = false;
	}else if(idDuplicationChk==false){	
		$("#idMsg").empty();
		$("#idMsg").append("'"+$("#memberId").val()+"'은(는) 이미 사용중인 아이디입니다.");
		$("#idMsg").show();
		result = false;
	}else if(pwdChk==false){
		$("#pwdMsg").empty();
		$("#pwdMsg").append("8-12자의 영문대소문자, 숫자, 특수문자만 가능.");
		$("#pwdMsg").show();
		$("#memberPwd").focus();
		pwdChk = true;
		result = false;
	}else if($("#memberPwd").val() != $("#memberPwdCheck").val()){
		$("#pwdMsg").empty();
		$("#pwdChkMsg").empty();
		$("#pwdChkMsg").append("비밀번호를 다시 확인해주세요.");
		$("#pwdChkMsg").show();
		$("#memberPwd").focus();
		result = false;
	}else if($("#memberName").val()==""){
		$("#nameMsg").empty();
		$("#nameMsg").append("이름을 입력하세요.");
		$("#nameMsg").show();
		$("#nameMsg").focus();
		result = false;
	}else if($("#memberPhone").val()==""){
		$("#phoneMsg").empty();
		$("#phoneMsg").append("핸드폰번호는 필수 입력값입니다.");
		$("#phoneMsg").show();
		$("#memberPhone").focus();
		result = false;
	}else if(phoneDuplicationChk==false){
		$("#phoneMsg").empty();
		$("#phoneMsg").append("핸드폰번호 인증을 해 주세요.");
		$("#phoneMsg").show();
		result = false;
	}else if($("#memberAddress").val()==""){
		$("#addressMsg").empty();
		$("#addressMsg").append("주소를 입력하세요.");
		$("#addressMsg").show();
		$("#addressMsg").focus();
		result = false;
	}else if($("#nickName").val()==""){
		$("#nickNameMsg").empty();
		$("#nickNameMsg").append("닉네임을 입력하세요.");
		$("#nickNameMsg").show();
		$("#nickName").focus();
		result = false;
	}else if($("#memberEmail1").val()==""){
		$("#emailMsg").empty();
		$("#emailMsg").append("이메일을 입력하세요.");
		$("#emailMsg").show();
		$("#memberEmail1").focus();
		result = false;
	}else if($("#memberEmail2").val()==""){
		$("#emailMsg").empty();
		$("#emailMsg").append("이메일을 입력하세요.");
		$("#emailMsg").show();
		$("#memberEmail2").focus();
		result = false;
	}
	return result;
}//formChk함수 끝

function formSubmit(){
    if(formChk()){ // formChk 값이 true일경우만 submit
    	$("#memberEmail").val($("#memberEmail1").val() + "@" + $("#memberEmail2").val()); //이메일 @ 전후로 합쳐서 hidden태그에 넣기
    	$("#register").submit();
    }
}

</script>

<h3>회원가입</h3>
<form name="registerForm" id="register" action="/MMONG/member/registerMember.do" method="post">
	<table>	
		<tr>
			<th>ID</th>
			<td><input type="text" id="memberId" name="memberId" value="${param['user.userId'] }">
				<input type="button" id="idChk" value="중복확인"/></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
				<form:errors path="member.user.userId" delimiter="<br>"/>
				<div id="idMsg" style="display:none"></div>
			</td>
		</tr>
		
		<tr>
			<th>비밀번호</th>
			<td><input type="password" id="memberPwd" name="user.userPwd" value="${param['user.userPwd'] }"></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
				<form:errors path="member.user.userPwd" delimiter="<br>"/>
				<div id="pwdMsg" style="display:none"></div>
			</td>
		</tr>
				
		<tr>
			<th>비밀번호 확인</th>
			<td><input type="password" id="memberPwdCheck"></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
			<div id="pwdChkMsg" style="display:none"></div>
			</td>
		</tr>
		
		<tr>
			<th>이름</th>
			<td><input type="text" id="memberName" name="memberName" value="${param.memberName }"></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
			<div id="nameMsg" style="display:none"></div>
			</td>
		</tr>
				
		<tr>
		<th>닉네임</th>
			<td><input type="text" id="nickName" name="nickName" value="${param.nickName }"></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
			<div id="nickNameMsg" style="display:none"></div>
			</td>
		</tr>
				
		<tr>
			<th>핸드폰번호</th>
			<td><input type="text" id="memberPhone" name="memberPhone" value="${param.memberPhone }" maxlength="13"> 
				<input type="button" id="memberPhoneChk" value="인증"/></td>
		</tr>		
		<tr>
			<td></td>
			<td class="error">
				<form:errors path="member.memberPhone" delimiter="<br>"/>
				<div id="phoneMsg" style="display:none"></div>
			</td>
		</tr>
		
		<tr>
			<th>주소</th>
			<td><input type="text" id="memberAddress" name="memberAddress" value="${param.memberAddress }"></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
			<div id="addressMsg" style="display:none"></div>
			</td>
		</tr>
				
		<tr>
			<th>이메일</th>
			<td><input type="text" id="memberEmail1" name="memberEmail1" value="${param.memberEmail1 }"> @ 
				<input type="text" id="memberEmail2" name="memberEmail2" value="${param.memberEmail2 }">
				<input type="hidden" id="memberEmail" name="memberEmail" value="${param.memberEmail }"> </td>
			<td><input type="hidden" name="memberPicture" value="tmp"></td>
		</tr>		
		<tr>
			<td></td>
			<td class="error">
			<div id="emailMsg" style="display:none"></div>
			</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<input type="button" value="가입" onClick="formSubmit(); return false;" />
			</td>
		</tr>
	</table>
	<sec:csrfInput/>
</form>
