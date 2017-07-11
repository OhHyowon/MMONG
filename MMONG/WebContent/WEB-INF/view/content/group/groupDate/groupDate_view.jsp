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
		}
	}); // end of deleteBtn
});

</script>





<h3>일정 상세보기</h3>

<%-- 일정 상세보기 페이지가 열릴 때 마다 groupDateNo 세션에 저장 --%>
<%
	int groupDateNo = ((GroupDate)request.getAttribute("groupDate")).getNo();
	session.setAttribute("groupDateNo",groupDateNo);
%>
	<sec:authentication property="principal.memberId" var="loginId"/>


<table>
	<thead>
		<tr>일정이름</tr>
		<tr>
			<td>시간</td>
			<td>장소(지도)</td>
		</tr>
	</thead>
	<tbody>
		<tr>${requestScope.groupDate.title}</tr>
		<tr>
			<td><fmt:formatDate value="${requestScope.groupDate.groupDate}" pattern="yyyy-MM-dd HH:mm"/></td>
			<td>${requestScope.groupDate.place }</td>
		</tr>
	</tbody>	
</table>

<!-- 로그인된 아이디가 일정 작성자와 같다면 -->

	<c:if test="${requestScope.groupDate.memberId == loginId }">
	<form action="/MMONG/group/groupDate/updateGroupDate1.do" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<%-- 		
		<input type="hidden" name="title" value="${requestScope.groupDate.title }">
		<input type="hidden" name="place" value="${requestScope.groupDate.place }">
		<input type="hidden" name="groupDate" value="${requestScope.groupDate.groupDate }"> --%>
		<input type="hidden" name="groupDateNo" value="${requestScope.groupDate.no }">
	
		<input type="submit" value="수정하기" id="updateBtn">
		<input type="button" value="삭제하기" id="deleteBtn">
		</form>
	</c:if>


	
	
<hr>
<table>
<tr>일정 참여자 목록</tr>
<c:choose>
 		<c:when test="${empty requestScope.memberIdList}"> <%-- 멤버아이디가 없을 때 --%>
				<li>일정 참여자가 없습니다!</li>
			<input type="button" value="참여 하기" id="insertBtn">
		</c:when> 

		<c:otherwise>
	<c:forEach items="${requestScope.memberIdList }" var="memberId" varStatus="idx">
			<c:choose>
			<c:when test="${memberId == loginId }"> <%-- 로그인된 아이디와 참여자 아이디가 같다면 --%>
					<li>
					${memberId }(${requestScope.nickNameList[idx.index] })<input type="button" value="참여 취소" id="cancelBtn">
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
</table>
