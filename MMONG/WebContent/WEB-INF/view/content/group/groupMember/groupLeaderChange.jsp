<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  	<!-- Bootstrap core CSS -->
 <link href="/MMONG/resource/assets/css/bootstrap.css?var=1" rel="stylesheet">
    
	<!--external css-->
<link href="/MMONG/resource/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/js/gritter/css/jquery.gritter.css" />
<link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/lineicons/style.css">        
   
	<!-- Custom styles for this template -->
<link href="/MMONG/resource/assets/css/style.css?var=2" rel="stylesheet">
<link href="/MMONG/resource/assets/css/style-responsive.css" rel="stylesheet">
<link href="/MMONG/resource/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".memberId").on("click",function(){
		var newLeader=$(this).text();
		if(!confirm($(this).text()+"(으)로 모임장을 변경 하시겠습니까?")){
			return;
		}else{
			$.ajax({
				url:"/MMONG/groupMember/LeaderChange.do",
				data:{"newLeader":newLeader,"${_csrf.parameterName}":"${_csrf.token}"},
				success:function(txt){
					if(txt=="1"){
						alert("모임장이 변경되었습니다.");
						opener.parent.location.reload();
						window.close();
					}else if(txt=="2"){
						alert("현재 모임장 입니다.");
					}
				}
			})
		}
	});
});

</script>
<style type="text/css">
p:hover{
	text-decoration: underline;
	color: purple;
	cursor:pointer;
}
</style>
    <!-- 참여자 목록 --> 
    <div class="col-md-6">
    	<div class="form-panel">
    <h4 style="text-align:center;">어떤 멤버로 변경하시겠습니까?</h4>
    <div style="text-align:center; border:1px">
   	<c:forEach var="groupMember" items="${requestScope.groupMemberList }">
   		<p class="memberId">${groupMember.memberId}</p>
   	</c:forEach>
   		</div>
   	</div>
</div>
   