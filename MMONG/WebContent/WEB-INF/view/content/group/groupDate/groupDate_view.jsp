<%@page import="com.mmong.vo.GroupDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}

$(document).ready(function(){
	$(".insertBtn").on("click",function(){
		alert("일정 참여");
		$.ajax({
			url:"/MMONG/group/groupDate/registerMeet.do",
			type:"post",
			data:{"${_csrf.parameterName}":"${_csrf.token}"},
			dataType:"json",
			success:function(txt){
				if(txt=='1'){
					alert("일정 참여 되었습니다.");
					location.href="/MMONG/group/groupDate/groupDateView.do?groupDateNo=${requestScope.groupDate.no}"
				}else{
					alert("일정 참여 실패");
				}
			}
		});
	}); // end of insertBtn
	$("#cancelBtn").on("click",function(){
		$.ajax({
			url:"/MMONG/group/groupDate/cancelMeet.do",
			type:"post",
			data:{"${_csrf.parameterName}":"${_csrf.token}"},
			dataType:"json",
			success:function(txt){
				if(txt=='1'){
					alert("일정 참여 취소 되었습니다.");
					location.href="/MMONG/group/groupDate/groupDateView.do?groupDateNo=${requestScope.groupDate.no}"
				}else{
					alert("에러");
				}
			}
		});
	}); // end of cancelBtn
	$("#deleteBtn").on("click",function(){
		if(!confirm("삭제하시겠습니까?")){
			return;
		}else{
			$.ajax({
				url:"/MMONG/group/groupDate/groupDateDelete.do",
				type:"post",
				data:{"${_csrf.parameterName}":"${_csrf.token}"},
				dataType:"json",
				success:function(txt){
					if(txt=="1"){
						alert("삭제되었습니다.");
						location.href="/MMONG/group/groupDate/allGroupDateList.do"
					}else{
						alert("삭제 실패");
					}
				}
			});
		}
	}); // end of deleteBtn
});

</script>
<style>
.groupDate{
	text-align:left;
}
.Btn{
	float:right;
}
</style>
<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 일정 상세보기
		</h3>

<%-- 일정 상세보기 페이지가 열릴 때 마다 groupDateNo 세션에 저장 --%>
<%
	int groupDateNo = ((GroupDate)request.getAttribute("groupDate")).getNo();
	session.setAttribute("groupDateNo",groupDateNo);
%>
	<sec:authentication property="principal.memberId" var="loginId"/>
<div class="col-lg-8">
	<div class="form-panel">

<div class="col-lg-4">
	<div class="form-panel" style="background:#E8F1EE">
		<div>&nbsp;</div>
		이름 : ${requestScope.groupDate.title}
		<br>
		일정 : <fmt:formatDate value="${requestScope.groupDate.groupDate}" pattern="yyyy-MM-dd HH:mm"/>
	</div>
	<div class="form-panel" style="background:#E8F1EE">
		<div>
	<c:choose>
 		<c:when test="${empty requestScope.memberIdList}"> <%-- 멤버아이디가 없을 때 --%>
				<li>일정 참여자가 없습니다!</li>
			<input class="btn btn-default btn-xs insertBtn" type="button" value="참여하기">
		</c:when> 
	
		<c:otherwise> <%-- 일정 참여자가 있을 때 --%>
	<div style="text-align:center">일정 참여자</div>
	<c:forEach items="${requestScope.memberIdList }" var="memberId" varStatus="idx">
			<c:choose>
			<c:when test="${memberId == loginId }"> <%-- 로그인된 아이디와 참여자 아이디가 같다면 --%>
					<li>
					${memberId }(${requestScope.nickNameList[idx.index] })<input type="button" value="참여 취소" id="cancelBtn" style="margin-left:5px" class="btn btn-default btn-xs">
					</li>
			</c:when>
			
			<c:when test="${memberId != loginId }"> <%-- 로그인된 아이디와 참여자 아이디가 다르다면 --%>
					<li>
					${memberId }(${requestScope.nickNameList[idx.index] })
					</li>			
			</c:when>
					
			</c:choose>
			</c:forEach>
			
		<% int i =1; %> <%-- 1이면 memberList에 본인 없음, 2이면 본인 있음 --%>
			<c:forEach items= "${requestScope.memberIdList }" var="memberId">
				<c:if test="${memberId==loginId }"> 
					<% i=2; %>
				</c:if>
			</c:forEach>
		<% if (i==1){%>
			<input type="button" value="참여 하기" class="btn btn-default btn-xs insertBtn">
		<%}%>
		
		</c:otherwise>
	</c:choose>
		</div>
	</div>
	
</div>


<div class="col-lg-4">
	<div class="form-panel" style="background:#E8F1EE"><div>지도 들어갈 자리</div></div>
</div>

	<c:if test="${requestScope.groupDate.memberId == loginId }">
	<form action="/MMONG/group/groupDate/updateGroupDate1.do" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="hidden" name="groupDateNo" value="${requestScope.groupDate.no }">
<div style="position:relative; top:210px;">
		<input class="btn btn-default btn-sm" type="submit" value="수정하기" id="updateBtn" class="Btn" style="float:right;">
		<input class="btn btn-default btn-sm" type="button" value="삭제하기" id="deleteBtn" class="Btn" style="margin-left:120px">
		</div>
		</form>
	</c:if>
<br><br><br><br><br><br><br><br><br><br><br><br><br>
	</div>
</div>

</section>
</div>