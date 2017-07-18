<%@page import="com.mmong.vo.GroupDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#insertBtn").on("click",function(){
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
		}c
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
		일정 : ${requestScope.groupDate.title}
		<br>
		날짜 : <fmt:formatDate value="${requestScope.groupDate.groupDate}" pattern="yyyy-MM-dd HH:mm"/>
	</div>
	<div class="form-panel" style="background:#E8F1EE">
		<div>
			<c:choose>
 		<c:when test="${empty requestScope.memberIdList}"> <%-- 멤버아이디가 없을 때 --%>
				<li>일정 참여자가 없습니다!</li>
			<input class="btn btn-default btn-xs" type="button" value="참여하기" id="insertBtn">
		</c:when> 

		<c:otherwise>
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
			<input type="button" value="참여 하기">
			</c:when>
			</c:choose>
			</c:forEach>
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





<%-- 

<div class="col-sm-8" style="text-align:center;">
<img src="/MMONG/resource/assets/img/left.png"><span>　</span>${requestScope.groupDate.title}<span>　</span><img src="/MMONG/resource/assets/img/right.png"><br>
날짜 : <fmt:formatDate value="${requestScope.groupDate.groupDate}" pattern="yyyy-MM-dd HH:mm"/><br>
<textarea rows='auto' cols='50'>지도 들어갈 자리</textarea>


<!-- 로그인된 아이디가 일정 작성자와 같다면 -->

</div>




<div class="col-sm-4">
	<table>
	<br><br><br>
<tr>일정 참여자 목록</tr>
<c:choose>
 		<c:when test="${empty requestScope.memberIdList}"> 멤버아이디가 없을 때
				<li>일정 참여자가 없습니다!</li>
			<input type="button" value="참여 하기" id="insertBtn">
		</c:when> 

		<c:otherwise>
	<c:forEach items="${requestScope.memberIdList }" var="memberId" varStatus="idx">
			<c:choose>
			<c:when test="${memberId == loginId }"> 로그인된 아이디와 참여자 아이디가 같다면
					<li>
					${memberId }(${requestScope.nickNameList[idx.index] })<input type="button" value="참여 취소" id="cancelBtn" style="margin-left:5px">
					</li>
			</c:when>
			
			<c:when test="${memberId != loginId }"> 로그인된 아이디와 참여자 아이디가 다르다면
					<li>
					${memberId }(${requestScope.nickNameList[idx.index] })
					</li>			
			<input type="button" value="참여 하기">
			</c:when>
			</c:choose>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>
</div>
	
	
<hr> --%>


</section>
