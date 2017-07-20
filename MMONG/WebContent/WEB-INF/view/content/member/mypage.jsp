<%@ page contentType="text/html;charset=UTF-8"%>
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
#view-menu{
   text-align: center;
}
form{
   display: inline;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
window.onload=function(){
   $("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}//맨 아래 footer 보정

$(document).ready(function(){
   $("#withdrawalBtn").on("click", function(){
      if(confirm("정말 탈퇴하시겠습니까?")){
         return true;
      }else{
         alert("탈퇴가 취소되었습니다.");
         return false;
      }
   });
});//ready 함수 끝
</script>

<div id="total_div">
   <section class="wrapper site-min-height">
      <h3><i class="fa fa-angle-right"></i> 회원 마이페이지</h3>
<div id="view-detail">

   
<div style="height:auto; min-width: 350px; text-align:center;">
      <div>
         <h5>회원정보</h5>
      </div>
      <p><img src="/MMONG/up_image/profilePicture.PNG" class="img-circle" width="100"></p> 
      <p><b>ID : <sec:authentication property="principal.memberId"/></b></p>
            <p><b>이름</b> : ${requestScope.member.memberName }</p>
            <p><b>전화번호</b> : ${requestScope.member.memberPhone }</p>
            <p><b>이메일</b> : ${requestScope.member.memberEmail}</p>
            <p><b>주소</b> : ${requestScope.member.memberAddress}</p>
   </div>
</div>
<div id="view-menu">
   <form action="/MMONG/member/info_member_update_form.do" method="post">
      <input type="hidden" name="memberId" value="${requestScope.member.memberId }">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <input type="submit" class="btn btn-default btn-sm" value="회원정보 수정">
   </form>&nbsp;
   <form action="/MMONG/member/memberWithdrawal.do" method="post">
      <input type="hidden" name="memberId" value="${requestScope.member.memberId }">
      <input class="btn btn-default btn-sm" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <input class="btn btn-default btn-sm" id="withdrawalBtn" type="submit" value="회원탈퇴">
</form>
</div>
 </section>
</div>