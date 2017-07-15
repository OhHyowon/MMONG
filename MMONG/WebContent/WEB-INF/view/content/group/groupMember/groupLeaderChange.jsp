<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".memberId").on("click",function(){
		var newLeader=$(this).text();
		if(!confirm($(this).text()+"로 모임장을 변경 하시겠습니까?")){
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
    <h2>어떤 멤버로 변경 할꺼야?</h2>

   	<c:forEach var="groupMember" items="${requestScope.groupMemberList }">
   		<p class="memberId">${groupMember.memberId}</p>
   	</c:forEach>

   