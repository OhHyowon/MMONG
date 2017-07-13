<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#ok").on("click", function(){
		self.close();		
	});
	
	$("#delete").on("click", function(){
		if(!confirm("삭제시 복구할 수 없습니다. 삭제하시겠습니까?")){
			return;
		}else{
			var no =  $("#no").val();
			$.ajax({
				url:"/MMONG/calendar/delete.do",
				type:"post",
				data:{"no":no, "${_csrf.parameterName}":"${_csrf.token}"},
				success:function(val){
					if(val=='1'){
						alert("삭제되었습니다");
						opener.parent.location.reload();
						self.close();					
					}
				},
				error:function(){
					alert("error");
				}
			});
		}
	});
	
});

</script>
</head>
<body>
<h2>일정 상세 보기</h2>

<table>
	<tr>
		<th>일정</th>
		<td>
			<c:choose>
				<c:when test="${requestScope.eventInfo.type eq 0}">
					개인 일정
				</c:when>
				<c:when test="${requestScope.eventInfo.type eq 1}">
					진료 일정
				</c:when>
				<c:otherwise>
					모임 일정
				</c:otherwise>
			</c:choose>
		</td> 
	</tr>
	<c:choose> 
 		<c:when test="${requestScope.eventInfo.emotion ne 5}">
			<tr>
				<th>기분</th>
				<td> <!-- 이모티콘으로 변환 필요!!! -->
					<c:choose>
						<c:when test="${requestScope.eventInfo.emotion eq 0}">
							기쁨
						</c:when>
						<c:when test="${requestScope.eventInfo.emotion eq 1}">
							슬픔
						</c:when>
						<c:when test="${requestScope.eventInfo.emotion eq 2}">
							화남
						</c:when>
						<c:when test="${requestScope.eventInfo.emotion eq 3}">
							보통
						</c:when>
						<c:when test="${requestScope.eventInfo.emotion eq 4}">
							우울
						</c:when>
					</c:choose>
				</td>
			</tr>
 		</c:when>
 	</c:choose>
	<tr>
		<th>제목</th>
		<td>${requestScope.eventInfo.title }</td>
	</tr>
	<tr>
		<th>일시</th>
		<td><fmt:formatDate value="${requestScope.eventInfo.startDate }" pattern="yyyy/MM/dd HH:mm"/> ~ 
				<fmt:formatDate value="${requestScope.eventInfo.endDate }" pattern="yyyy/MM/dd HH:mm"/>
		</td>
	</tr>
	<tr>
		<th>메모</th>
		<td>${requestScope.eventInfo.content }<br><br>
			<c:choose>
				<c:when test="${not empty requestScope.eventInfo.picture}">
					<img src="/MMONG/up_image/${requestScope.eventInfo.picture }" width="300px" height="300px">
				</c:when>
			</c:choose>
		</td>
	</tr>
</table>

	<input type="button" value="수정" id="update" onclick="location.href='/MMONG/calendar/selectScheduleInfo.do?no=${requestScope.eventInfo.no }'">
	<input type="button" value="삭제" id="delete"> 
	<input type="button" value="확인" id="ok">

	<input type="hidden" name="no" value="${requestScope.eventInfo.no }">
</body>
</html>