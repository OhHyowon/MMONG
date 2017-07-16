<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#updateImg").on("click", function(){
		$("#file").empty();
		$("#file").append("<input type='file' name='upImage'><br>");
	});

	 $("#deleteImg").on("click",function(){
		$("#pic").empty();
		$("#pic").append("현재 이미지　없음");
		$("#file").empty();
		$("#file").append("<input type='hidden' name='delete' value=1>");
	 });
});

</script>

<style type="text/css">
span.error{
	font-size:small; /* 1em : 기본 크기의 1배수 크기 */
	color: red;
}
</style>

</head>
<body>
<h2>일정 수정하기</h2>

<form action="/MMONG/calendar/update.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data" onsubmit="return confirm('수정하시겠습니까?');">
<table>
	<tr>
		<th>일정</th>
		<td>
			<c:choose>
				<c:when test="${requestScope.updateInfo.type eq 0}">
					<div>
						<label>개인 <input type="radio" name="schedule" value=0 checked="true"></label>
		  				<label>진료 <input type="radio" name="schedule" value=1></label>
		  				<label>소모임 <input type="radio" name="schedule" value=2></label>
		  			</div>
				</c:when>
				<c:when test="${requestScope.updateInfo.type eq 1}">
					<div>
						<label>개인 <input type="radio" name="schedule" value=0></label>
		  				<label>진료 <input type="radio" name="schedule" value=1 checked="true"></label>
		  				<label>소모임 <input type="radio" name="schedule" value=2></label>
		  			</div>
				</c:when>
				<c:otherwise>
					<div>
						<label>개인 <input type="radio" name="schedule" value=0></label>
		  				<label>진료 <input type="radio" name="schedule" value=1></label>
		  				<label>소모임 <input type="radio" name="schedule" value=2 checked="true"></label>
		  			</div>
				</c:otherwise>
			</c:choose>
		</td> 
	</tr>
	<tr>
		<th>기분</th>
		<td> <!-- 이모티콘으로 변환 필요!!! -->
			<c:choose>
				<c:when test="${requestScope.updateInfo.emotion eq 1}">
					<div>
						<label>기쁨 <input type="checkbox" name="emotion" value=1 checked="checked"></label>
			  			<label>슬픔 <input type="checkbox" name="emotion" value=2></label>
			  			<label>화남 <input type="checkbox" name="emotion" value=3></label>
			  			<label>보통 <input type="checkbox" name="emotion" value=4></label>
			  			<label>우울 <input type="checkbox" name="emotion" value=5></label>
		  			</div>
				</c:when>
				<c:when test="${requestScope.updateInfo.emotion eq 2}">
					<div>
						<label>기쁨 <input type="checkbox" name="emotion" value=1></label>
			  			<label>슬픔 <input type="checkbox" name="emotion" value=2 checked="checked"></label>
			  			<label>화남 <input type="checkbox" name="emotion" value=3></label>
			  			<label>보통 <input type="checkbox" name="emotion" value=4></label>
			  			<label>우울 <input type="checkbox" name="emotion" value=5></label>
		  			</div>
				</c:when>
				<c:when test="${requestScope.updateInfo.emotion eq 3}">
					<div>
						<label>기쁨 <input type="checkbox" name="emotion" value=1></label>
			  			<label>슬픔 <input type="checkbox" name="emotion" value=2></label>
			  			<label>화남 <input type="checkbox" name="emotion" value=3 checked="checked"></label>
			  			<label>보통 <input type="checkbox" name="emotion" value=4></label>
			  			<label>우울 <input type="checkbox" name="emotion" value=5></label>
		  			</div>
				</c:when>
				<c:when test="${requestScope.updateInfo.emotion eq 4}">
					<div>
						<label>기쁨 <input type="checkbox" name="emotion" value=1></label>
			  			<label>슬픔 <input type="checkbox" name="emotion" value=2></label>
			  			<label>화남 <input type="checkbox" name="emotion" value=3></label>
			  			<label>보통 <input type="checkbox" name="emotion" value=4 checked="checked"></label>
			  			<label>우울 <input type="checkbox" name="emotion" value=5></label>
		  			</div>
				</c:when>
				<c:when test="${requestScope.updateInfo.emotion eq 5}">
					<div>
						<label>기쁨 <input type="checkbox" name="emotion" value=1></label>
			  			<label>슬픔 <input type="checkbox" name="emotion" value=2></label>
			  			<label>화남 <input type="checkbox" name="emotion" value=3></label>
			  			<label>보통 <input type="checkbox" name="emotion" value=4></label>
			  			<label>우울 <input type="checkbox" name="emotion" value=5 checked="checked"></label>
		  			</div>
				</c:when>
				<c:otherwise>
					<div>
						<label>기쁨 <input type="checkbox" name="emotion" value=1></label>
			  			<label>슬픔 <input type="checkbox" name="emotion" value=2></label>
			  			<label>화남 <input type="checkbox" name="emotion" value=3></label>
			  			<label>보통 <input type="checkbox" name="emotion" value=4></label>
			  			<label>우울 <input type="checkbox" name="emotion" value=5></label>
		  			</div>
				</c:otherwise>
			</c:choose>
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="title"  value="${requestScope.updateInfo.title }">
				<span class="error"><form:errors path="calendar.title"/></span></td> 
	</tr>
	<tr>
		<td>시작 일시</td>
		<td><input type="datetime-local" name="startDate" value="<fmt:formatDate value="${requestScope.updateInfo.startDate }" pattern="yyyy-MM-dd'T'HH:mm"/>">
				<span class="error"><form:errors path="calendar.startDate"/></span></td>
	</tr>
	<tr> <!-- 시작일시 이전꺼 선택못하게 하기 -->
		<td>종료 일시</td>
		<td><input type="datetime-local" name="endDate"  value="<fmt:formatDate value="${requestScope.updateInfo.endDate }" pattern="yyyy-MM-dd'T'HH:mm"/>">
				<span class="error"><form:errors path="calendar.endDate"/></span></td> 
	</tr>
	<tr>
		<th>메모</th>
		<td><input type="text" name="content"  value="${requestScope.updateInfo.content }">
		<span class="error"><form:errors path="calendar.content"/></span></td>
	</tr>
	<tr>
		<th>이미지</th>
		<td>
			<div id="pic">
				<c:choose>
					<c:when test="${not empty requestScope.updateInfo.picture}">
						현재 이미지　${requestScope.updateInfo.picture }
					</c:when>
					<c:otherwise>
						현재 이미지　없음
					</c:otherwise>
				</c:choose>
			</div>
			<label>이미지 수정<input type="radio" id="updateImg" name="imgCheck" value="updateImg"></label> 
			<label>이미지 삭제<input type="radio" id="deleteImg" name="imgCheck" value="deleteImg"></label><br>
			<div id="file"></div>
		</td>
	</tr>
</table>
	<input type="hidden" value="${requestScope.updateInfo.picture }" name="savedImg">

	<input type="submit" value="확인">
	<input type="button" value="취소" onclick="javascript:history.back(-1)">
	<input type="hidden" name="no" value="${requestScope.updateInfo.no }">
</form>

</body>
</html>