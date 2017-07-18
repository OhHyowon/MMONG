<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
a:link{
	/*방문하지 않은 링크 설정.*/
	text-decoration:none; /*밑줄 안나오도록 처리.*/
	color:green;
}
a:visited{
	/*방문한 링크 설정*/
	text-decoration: none;
	color:green;
}
a:hover{
	/*마우스 포인터가 올라간 시점의 설정.*/
	text-decoration: underline;
	color:red;
}
a:active{
	/*마우스를 링크에 클릭하는 시점*/
	color:blue;
}
#result, #tr, #td {
	border:1px solid black;
	padding: 10px;
}
#result {
	border-collapse: collapse;
}
</style>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#allCheck").on("click", function(){
		$("input[name='message']").prop("checked", this.checked);
	});
	
	$("input[class='check']").on("click",function(){
		if($("input[class='check']").not(':checked').length>0){
			$("#allCheck").prop("checked",false);
		}
	}); 
	
	$("#delete").on("click", function(){
		var cnt = $("input[name='message']:checked").length;
		if(cnt == 0){
			alert("삭제할 쪽지를 선택해주세요.");
		}else{
			if(!confirm("삭제시 복구할 수 없습니다. 삭제하시겠습니까?")){
				return;
			}else{
				var list = new Array();
				list[0] = "receiveList";
				var i = 1;
				$("input[name='message']:checked").each(function(){
					var no = $(this).val();
					list[i] = no;
					i++;
				});
				
				jQuery.ajaxSettings.traditional = true;
		 		$.ajax({
					url:"/MMONG/message/deleteMsg.do",
					type:"post",
					data:{"no":list, "${_csrf.parameterName}":"${_csrf.token}"},
					success:function(val){
						if(val=='1'){
							alert("삭제되었습니다"); 
							location.href="/MMONG/message/searchReceiveMsg.do?&searchOpt=${requestScope.search_opt}&search=${requestScope.search_txt}";
						}
					}
				}); 
			}
		}
 	});
});

</script>

</head>
<body>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 받은 쪽지함
		</h3>

	<table>
		<thead>
			<tr>
				<td><input type="checkbox" id="allCheck"></td>
				<td>보낸이</td>
				<td>제목</td>
				<td>내용</td>
				<td>날짜</td>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty requestScope.searchReceiveList }">
					<c:forEach items="${requestScope.searchReceiveList }" var="list">
						<tr>
							<td><input type="checkbox" name="message" class="check" value="${list.no }"></td>
							<td>${list.sendId } (${list.member.nickName })</td>
							<td><a href="/MMONG/message/viewReceiveMsg.do?no=${list.no }">${list.title }</a></td>
							<td><a href="/MMONG/message/viewReceiveMsg.do?no=${list.no }">${list.content }</a></td>
							<td><fmt:formatDate type="date" value="${list.messageDate }"/></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p>받은 쪽지가 없습니다.<p>
				</c:otherwise>	
			</c:choose>
		</tbody>
	</table>
	
	<input type="button" value="삭제" id="delete"> 
	
	<p>
<%-- ####################################
										페이징 처리
###################################### --%>


						<!-- 첫페이지로 이동 -->
<a href="/MMONG/message/searchReceiveMsg.do?page=1&searchOpt=${requestScope.search_opt}&search=${requestScope.search_txt}">첫페이지</a>

<!-- 
			이전 페이지 그룹 처리
			이전 페이지 그룹이 있으면 링크 처리하고 없으면 화살표만 나오도록
-->
		 <c:choose >
			<c:when test="${requestScope.pageBean.previousPageGroup }">
			<a href="/MMONG/message/searchReceiveMsg.do?page=${requestScope.pageBean.beginPage-1 }&searchOpt=${requestScope.search_opt}&search=${requestScope.search_txt}">◀</a>
		 </c:when>
		 <c:otherwise>
			 ◀
		 </c:otherwise>
		 </c:choose>
		 
<!-- 	
			현재 page가 속한 page 그룹내의 페이지들 링크
			현재 pageGroup의 시작page~끝page
			현재 page가 현재페이지이면 링크 처리를 하지 않고 page가 현재 페이지가 아니라면 링크처리
 -->
 	<c:forEach begin="${requestScope.pageBean.beginPage }" end="${requestScope.pageBean.endPage }" var="page">
		<c:choose>
			<c:when test="${requestScope.pageBean.page!=page }">
				<!-- 현재 페이지가 아니라면 -->
			<a href="/MMONG/message/searchReceiveMsg.do?page=${page}&searchOpt=${requestScope.search_opt}&search=${requestScope.search_txt}">${page }</a>
			</c:when>
			<c:otherwise>
				&nbsp;[${page }]&nbsp;
			</c:otherwise>
		</c:choose>
	</c:forEach>
 
<!-- 
			다음페이지 그룹으로 이동
			만약에 다음페이지 그룹이 있으면 링크 처리 없으면 화살표만 나오도록 처리
-->
	
	<c:choose>
		<c:when test="${requestScope.pageBean.nextPageGroup }">
			<a href="/MMONG/message/searchReceiveMsg.do?page=${requestScope.pageBean.endPage+1}&searchOpt=${requestScope.search_opt}&search=${requestScope.search_txt}">▶</a>
		</c:when>
		<c:otherwise>
			▶
		</c:otherwise>
	</c:choose>
		 
						<!-- 마지막 페이지로 이동 -->

<a href="/MMONG/message/searchReceiveMsg.do?page=${requestScope.pageBean.totalPage}&searchOpt=${requestScope.search_opt}&search=${requestScope.search_txt}">마지막페이지</a>

</p>


	<form action="/MMONG/message/searchReceiveMsg.do">
		<select name="searchOpt">
			<option value="ID">보낸사람의 ID</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
		</select>
		<input type="text" name="search">
		<input type="submit" value="검색">
	</form>
	</section>
