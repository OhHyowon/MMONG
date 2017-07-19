<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

    <!-- Bootstrap core CSS -->
    <link href="/MMONG/resource/assets/css/bootstrap.css?var=1" rel="stylesheet">
    
    <!--external css-->
    <link href="/MMONG/resource/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/js/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="/MMONG/resource/assets/lineicons/style.css">        
   
    <!-- Custom styles for this template -->
    <link href="/MMONG/resource/assets/css/style.css?var=2" rel="stylesheet">
    <link href="/MMONG/resource/assets/css/style-responsive.css" rel="stylesheet">

<style type="text/css">

body{
	font-size: 17px;
}

.viewName{
	background-color: #F2F2F2;
}

</style>


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
<div class="viewName" align="center"><br><h2>일정 상세 보기</h2><br></div>
<br><br>
<div align="center">
<table>
	<tr>
		<th>일정</th>
		<td style="width: 300px;padding:0px 0px 0px 20px;">
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
 		<c:when test="${requestScope.eventInfo.emotion ne 0}">
			<tr style="line-height:30px;">
				<th>기분</th>
				<td style="width: 300px;padding:0px 0px 0px 20px;">
					<c:choose>
						<c:when test="${requestScope.eventInfo.emotion eq 1}">
							<img src="/MMONG/resource/calendar/emoticon/happy.png" width="20" height="20">
						</c:when>
						<c:when test="${requestScope.eventInfo.emotion eq 2}">
							<img src="/MMONG/resource/calendar/emoticon/sad.png" width="20" height="20">
						</c:when>
						<c:when test="${requestScope.eventInfo.emotion eq 3}">
							<img src="/MMONG/resource/calendar/emoticon/upset.png" width="20" height="20">
						</c:when>
						<c:when test="${requestScope.eventInfo.emotion eq 4}">
							<img src="/MMONG/resource/calendar/emoticon/soso.png" width="20" height="20">
						</c:when>
						<c:when test="${requestScope.eventInfo.emotion eq 5}">
							<img src="/MMONG/resource/calendar/emoticon/gloomy.png" width="20" height="20">
						</c:when>
					</c:choose>
				</td>
			</tr>
 		</c:when>
 	</c:choose>
	<tr style="line-height:30px;">
		<th>제목</th>
		<td style="width: 300px;padding:0px 0px 0px 20px;">${requestScope.eventInfo.title }</td>
	</tr>
	<tr style="line-height:30px;">
		<th>일시</th>
		<td style="width: 310px;padding:0px 0px 0px 20px;"><fmt:formatDate value="${requestScope.eventInfo.startDate }" pattern="yyyy/MM/dd HH:mm"/> ~ 
				<fmt:formatDate value="${requestScope.eventInfo.endDate }" pattern="yyyy/MM/dd HH:mm"/>
		</td>
	</tr>
	<tr style="line-height:20px;">
		<th>메모</th>
		<td style="width: 300px;padding:20px 0px 0px 20px;">${requestScope.eventInfo.content }<br><br>
			<c:choose>
				<c:when test="${not empty requestScope.eventInfo.picture}">
					<img src="/MMONG/up_image/${requestScope.eventInfo.picture }" width="300px" height="300px">
				</c:when>
			</c:choose>
		</td>
	</tr>
</table><br><br><br><br>
	<input type="button" class="btn btn-default" value="수정" id="update" onclick="location.href='/MMONG/calendar/selectScheduleInfo.do?no=${requestScope.eventInfo.no }'">
	<input type="button" class="btn btn-default" value="삭제" id="delete"> 
	<input type="button" class="btn btn-default" value="확인" id="ok">

</div>
	<input type="hidden" id="no" value="${requestScope.eventInfo.no }">
</body>
</html>