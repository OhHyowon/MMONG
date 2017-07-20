<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style type="text/css">
.error{
	font-size : 8px;
	color : red;
}
th, td {
	padding: 5px;
}
#register_form{
	width:34%; height:30%; 
	position: relative;
	top:-10px;
	left:395px;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}


var sizeChk = true; //아이디 길이 체크값
var idDuplicationChk = false; //아이디 중복검사 체크값
var pwdChk = false; //비밀번호 값 검사 체크값
var emailChk = false; //이메일인증 검사 체크값 
var phoneDuplicationChk = false;//휴대전화 인증 검사 체크값


$(document).ready(function() {///가입 버튼 누르기 전에 폼 이동 시 에러메시지 뿌리기 
	
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
	//아이디 영어, 숫자만 입력되게
	$("input[name=memberId]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^a-z0-9]/gi,''));
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
	$("#memberPwd").change(function(){
		if($("#memberPwd").val() != $("#memberPwdCheck").val()){
			$("#pwdChkMsg").empty();
			$("#pwdChkMsg").append("비밀번호를 다시 확인해주세요."); 
			$("#pwdChkMsg").show();		
		}else{
			$("#pwdChkMsg").hide();
		}
	});
	$("#memberPwdCheck").change(function(){
		if($("#memberPwd").val() != $("#memberPwdCheck").val()){
			$("#pwdChkMsg").empty();
			$("#pwdChkMsg").append("비밀번호를 다시 확인해주세요."); 
			$("#pwdChkMsg").show();		
		}else{
			$("#pwdChkMsg").hide();
		}
	});
	
	////////////////////이메일 중복확인  
	$("#emailAuth").on("click", function(){
		$.ajax({
			"url" : "/MMONG/member/checkMemberEmail.do",
			"data" : {"memberEmail":$("#memberEmail").val()},
			"dataType" : "text",
			"beforeSend":function(){
				if($("#memberEmail").val()==""){
					$("#emailMsg").empty();
					$("#emailMsg").append("이메일을 입력하세요.");
					$("#emailMsg").show();
					return false;
				 }
			},
			"success":function(response) {
				if(response==1) {
					$("#emailMsg").empty();
					$("#emailMsg").append("이미 가입된 이메일입니다.");
					$("#emailMsg").show();
				} else {
					$("#emailMsg").hide();
					emailAuthOpen();
				}
			}
		});
	});

/* 	////////////////////핸드폰번호 인증
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
	}); */
	 $("#memberPhone").blur(function(){
		 if($("#memberPhone").val()==""){
			$("#phoneMsg").empty();
			$("#phoneMsg").append("핸드폰번호는 필수 입력값입니다.");
			$("#phoneMsg").show();
		 }else if($("#memberPhone").val().length<10 || $("#memberPhone").val().length>11){
				$("#phoneMsg").empty();
				$("#phoneMsg").append("10~11자리 번호를 입력해주세요.");
				$("#phoneMsg").show();
			}/* else if(phoneDuplicationChk==false){
				$("#phoneMsg").empty();
				$("#phoneMsg").append("핸드폰번호 인증을 해 주세요.");
				$("#phoneMsg").show();
			} */else{
				 $("#phoneMsg").hide();
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
	 $("#memberEmail").blur(function(){
		 if($("#memberEmail").val()==""){
			$("#emailMsg").empty();
			$("#emailMsg").append("이메일을 입력하세요.");
			$("#emailMsg").show();
		 }else{
			 $("#emailMsg").hide();
		 }
	 });
});//ready fucntion끝



function emailAuthOpen(){ //이메일 인증컨트롤러 부르는 함수
	if($("#memberEmail").val()==""){
		$("#emailMsg").empty();
		$("#emailMsg").append("이메일을 입력하세요.");
		$("#emailMsg").show();
		return;
	}else{
		var memberEmail = $("#memberEmail").val();
		window.open("/MMONG/sendMail/auth.do?memberEmail="+$("#memberEmail").val(), '소모임 만들기', 'top=100px, left=100px, height=220px, width=500px');
	}	
}


//가입 버튼 누르기 전 값 유효성 검사하기 위한 함수들 
function formChk() {
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
		$("#memberName").focus();
		result = false;
	}else if($("#nickName").val()==""){
		$("#nickNameMsg").empty();
		$("#nickNameMsg").append("닉네임을 입력하세요.");
		$("#nickNameMsg").show();
		$("#nickName").focus();
		result = false;
	}else if($("#memberPhone").val()==""){
		$("#phoneMsg").empty();
		$("#phoneMsg").append("핸드폰번호는 필수 입력값입니다.");
		$("#phoneMsg").show();
		$("#memberPhone").focus();
		result = false;
	}else if($("#memberPhone").val().length<10 || $("#memberPhone").val().length>11){
		$("#phoneMsg").empty();
		$("#phoneMsg").append("10~11자리 번호를 입력해주세요.");
		$("#phoneMsg").show();
		$("#memberPhone").focus();
		result = false;
	}else if($("#memberAddress").val()==""){
		$("#addressMsg").empty();
		$("#addressMsg").append("주소를 입력하세요.");
		$("#addressMsg").show();
		$("#memberAddress").focus();
		result = false;
	}else if($("#memberEmail").val()==""){
		$("#emailMsg").empty();
		$("#emailMsg").append("이메일을 입력하세요.");
		$("#emailMsg").show();
		$("#memberEmail").focus();
		result = false;
	}else if($("#emailSuccessMsg").text()!="인증완료"){
		$("#emailMsg").empty();
		$("#emailMsg").append("이메일 인증을 해주세요.");
		$("#emailMsg").show();
		result = false;
	}else{
		result = true;
	}
	return result;
}//formChk함수 끝 


function formSubmit(){
    if(formChk()){ // formChk 값이 true일경우만 submit
    	$("#register").submit();
    }
}

</script>
<div id="total_div">

	<section class="wrapper site-min-height">
		<h3><i class="fa fa-angle-right"></i> 회원가입</h3>
		
<div id="register_form">	
<form name="registerForm" id="register" action="/MMONG/member/registerMember.do" method="post">
	<table>	
		<tr>
			<th>ID</th>
			<td><input class="form-control" placeholder="ID" type="text" id="memberId" name="memberId" value="${param['user.userId'] }"></td>
			<td><input class="btn btn-default btn-sm" type="button" id="idChk" value="중복확인"/></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
				<form:errors path="member.user.userId" delimiter="<br>"/>
				<div id="idMsg" style="display:none"></div>
			</td>
			<td></td>
		</tr>
		
		<tr>
			<th>비밀번호</th>
			<td><input class="form-control" placeholder="패스워드" type="password" id="memberPwd" name="user.userPwd" value="${param['user.userPwd'] }"></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
				<form:errors path="member.user.userPwd" delimiter="<br>"/>
				<div id="pwdMsg" style="display:none"></div> 
			</td>
			<td></td>
		</tr>
				
		<tr>
			<th>비밀번호 확인</th>
			<td><input class="form-control" placeholder="패스워드 확인" type="password" id="memberPwdCheck"></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
				<div id="pwdChkMsg" style="display:none"></div>
			</td>
			<td></td>
		</tr>
		
		<tr>
			<th>이름</th>
			<td><input class="form-control" placeholder="이름" type="text" id="memberName" name="memberName" value="${param.memberName }"></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
				<div id="nameMsg" style="display:none"></div>
			</td>
			<td></td>
		</tr>
				
		<tr>
		<th>닉네임</th>
			<td><input class="form-control" placeholder="닉네임" type="text" id="nickName" name="nickName" value="${param.nickName }"></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
				<div id="nickNameMsg" style="display:none"></div>
			</td>
			<td></td>
		</tr>
				
		<tr>
			<th>휴대전화 번호</th>
			<td><input class="form-control" placeholder="휴대전화 번호" type="text" id="memberPhone" name="memberPhone" value="${param.memberPhone }" maxlength="13"></td>
			<td></td>
		</tr>		
		<tr>
			<td></td>
			<td class="error">
				<form:errors path="member.memberPhone" delimiter="<br>"/>
				<div id="phoneMsg" style="display:none"></div>
			</td>
			<td></td>
		</tr>
		
		<tr>
			<th>주소</th>
			<td><input class="form-control" placeholder="주소" type="text" id="memberAddress" name="memberAddress" value="${param.memberAddress }"></td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
				<div id="addressMsg" style="display:none"></div>
			</td>
			<td></td>
		</tr>
				
		<tr>
			<th>이메일</th>
			<td>
					<input class="form-control" placeholder="Email" type="email" id="memberEmail" name="memberEmail" value="${param.memberEmail }"></td>
					<!-- <input type="button" id="emailAuth" value="이메일 인증하기" onClick="emailAuthOpen(); return false;"/> -->
			<td><input class="btn btn-default btn-sm" type="button" id="emailAuth" value="이메일 인증"/></td>				
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td class="error">
				<div id="emailMsg" style="display:none"></div>
				<div id="emailSuccessMsg"></div>
			</td>
		</tr>
		
		<tr>
			<td><input type="hidden" name="memberPicture" value="tmp"></td>
			<td>
				<input class="btn btn-default btn-sm" type="button" value="가입" onClick="formSubmit(); return false;"/>
			</td>
			<td></td>
		</tr>
	</table>
	<sec:csrfInput/>
</form>
</div>
</section>
</div>
