<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
#errMsg{
	font-size : 8px;
	color : red;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//로그인 안했을 때 소모임 생성 버튼 누르면 처리
	$("#createNone").on("click", function(){
		alert("먼저 로그인 해주세요.");
		return;
	});
	
	//소모임 하나 클릭했을 때 소모임 상세페이지로 이동 
	$("#groupResult").on("click", "form", function(){
/*  	var test = $(this).attr('id'); //클릭된 form의 아이디 가져옴
		alert(test); */ 
		$(this).submit(); //선택된 form전송
	});
	
	//소모임 이름으로 검색
	$("#searchNameBtn").on("click", function(){		
		if($("#searchName").val()=="" || $("#searchName").val()=="이름으로 소모임 검색"){
			$("#errMsg").empty();
			$("#errMsg").append("검색할 소모임 이름을 입력하세요.");
			$("#errMsg").show();
			$("#searchName").focus();
			return;
		}
		$.ajax({
			"url" : "/MMONG/group/searchGroupName.do",
			"data" : {"groupName":$("#searchName").val()},
			"dataType" : "JSON",
			"success":function(response) {
				$("#groupResult").empty();
				var txt = "";
				$.each(response, function(){					
					$("#groupResult").append("<form action='/MMONG/group/groupDetail.do'>"
										 	+	"<div class='allGroup' style='border:1px solid; padding:10px; margin:10px; width:300px;'>"
										 	+		"소모임 이름 : "+this.name+" <br> "
										 	+		"모임 설명 : "+this.content
										 	+	"</div>"
										 	+	'<input type="hidden" name="groupNo" value="'+this.no+'"> <sec:csrfInput/>'
										    +"</form>");
				});
			}
		});//ajax 끝
	});

});
</script>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 소모임 페이지
		</h3>

<!-- 소모임 검색창 : 이름으로 검색 -->
<p><b>소모임 찾기</b></p>
<input type="text" id="searchName" name="searchName" value='이름으로 소모임 검색' onfocus="this.value=''">
<input type="button" id="searchNameBtn" value="검색"> <br>
<div id="errMsg" style="display:none"></div>



<!-- 소모임 전체리스트 뿌리기  --> 
<p><b>전체 소모임</b></p>
<div id="groupResult">  
<c:forEach var="allGroup" items="${allGroup }">
	<form action="/MMONG/group/groupDetail.do">
		<div class="allGroup" style="border:1px solid; padding:10px; margin:10px; width:300px;">
			소모임 이름 : ${allGroup.name } <br>
			모임 설명 : ${allGroup.content }
		</div>
		<input type="hidden" name="groupNo" value="${allGroup.no }">
		<sec:csrfInput/>
	</form>
</c:forEach>
</div>  



<!-- 나의 소모임으로 돌아가기 버튼 -->
<input type="button" value="나의 소모임" onClick="self.location='/MMONG/group/mygroup.do';">

