<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>



<style type="text/css">
#view-detail{
  top:0;right:0;bottom:0;left:0;
  display:flex;
  align-items:center;
  justify-content:center;
 
  display:-webkit-flex;
  -webkit-align-item;center;
  -webkit-justify-content:center;
}
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
	/* $("#memberPhoneChk").on("click", function(){
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
		}/* else if(phoneDuplicationChk==false){
			$("#phoneMsg").empty();
			$("#phoneMsg").append("핸드폰번호 인증을 해 주세요.");
			$("#phoneMsg").show();
		} */
	});	
	//핸드폰번호 숫자만 받게
	 $("#memberPhone").keyup(function(event){
         if (!(event.keyCode >=37 && event.keyCode<=40)) {
             var inputVal = $(this).val();
             $(this).val(inputVal.replace(/[^0-9]/gi,''));
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
		 if($("#memberAddress1").val()==""){
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
	
	if(!$("#memberPwd").val()){
		alert("비밀번호를 입력하세요");
		$("#memberPwd").focus();
		result = false;
    }else if(!$("#memberPwdCheck").val()){
		alert("비밀번호 확인을 입력하세요");
		$("#memberPwdCheck").focus();
		result = false;
    }else if($("#memberPwd").val() != $("#memberPwdCheck").val()){
		$("#pwdMsg").empty();
		$("#pwdChkMsg").empty();
		$("#pwdChkMsg").append("비밀번호를 다시 확인해주세요.");
		alert("비밀번호를 다시 확인해 주세요");
		$("#pwdChkMsg").show();
		$("#memberPwd").focus();
		result = false;
    }else if($("#memberPwd").val().length<7 || $("#memberPwd").val().length>13){
 		alert("비밀번호는 8~12자리입니다");
 		result = false;
	}else if($("#memberPhone").val()==""){
		$("#phoneMsg").empty();
		$("#phoneMsg").append("핸드폰번호는 필수 입력값입니다.");
		$("#phoneMsg").show();
		$("#memberPhone").focus();
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
	}else if($("#memberEmail").val()==""){
		$("#emailMsg").empty();
		$("#emailMsg").append("이메일을 입력하세요.");
		$("#emailMsg").show();
		$("#memberEmail").focus();
		result = false;
	}
	return result;
}//formChk함수 끝

function formSubmit(){
    if(formChk()){ // formChk 값이 true일경우만 submit
    	//$("#memberEmail").val($("#memberEmail1").val() + "@" + $("#memberEmail2").val()); //이메일 @ 전후로 합쳐서 hidden태그에 넣기 
    	$("#register").submit();
    }
}

</script>
<section class="wrapper site-min-height">
		<h3><i class="fa fa-angle-right"></i> 회원정보 수정</h3>
<div id="view-detail">
 
	<form name="updateForm" id="register" action="/MMONG/member/info_member_update.do" method="post">
		<table>	
			<tr>
				<th>ID</th>
				<td><input type="text" id="memberId" name="memberId" readonly value="${requestScope.member.memberId}" style="background-color: #e2e2e2;"></td>
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
				<td><input type="text" id="memberName" name="memberName" readonly value="${requestScope.member.memberName}" style="background-color: #e2e2e2;"></td>
			</tr>
			<tr>
				<td></td>
				<td class="error">
				<div id="nameMsg" style="display:none"></div>
				</td>
			</tr>
					
			<tr>
			<th>닉네임</th>
				<td><input type="text" id="nickName" name="nickName" value="${requestScope.member.nickName}"></td>
			</tr>
			<tr>
				<td></td>
				<td class="error">
				<div id="nickNameMsg" style="display:none"></div>
				</td>
			</tr>
					
			<tr>
				<th>핸드폰번호</th>
				<td><input type="text" id="memberPhone" name="memberPhone" value="${requestScope.member.memberPhone}" maxlength="13"> 
					<!-- <input type="button" id="memberPhoneChk" value="인증"/></td> -->
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
				<td><input type="text" id="memberAddress" name="memberAddress" value="${requestScope.member.memberAddress}"></td>
			</tr>
			<tr>
				<td></td>
				<td class="error">
				<div id="addressMsg" style="display:none"></div>
				</td>
			</tr>
					
			<tr>
				<th>이메일</th>
				<td><input type="text" id="memberEmail" name="memberEmail" value="${requestScope.member.memberEmail }"> </td>
				<td><input type="hidden" name="memberPicture" value="tmp"></td>
			</tr>		
			<tr>
				<td></td>
				<td class="error">
				<div id="emailMsg" style="display:none"></div>
				</td>
			</tr>
		</table>
		<br>
				<input type="hidden" name="user.userAuthority" value="ROLE_1"/>
				<input class="btn btn-default btn-sm" type="button" value="수정" onClick="formSubmit(); return false;" />&nbsp;
				<input class="btn btn-default btn-sm" type="reset" value="다시 작성"/>
		<sec:csrfInput/>
	</form>
</div>
</section>