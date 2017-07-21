<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
a:link{
	/*방문하지 않은 링크 설정.*/
	text-decoration:none; /*밑줄 안나오도록 처리.*/
}
a:visited{
	/*방문한 링크 설정*/
	text-decoration: none;
}
a:hover{
	/*마우스 포인터가 올라간 시점의 설정.*/
}
a:active{
	/*마우스를 링크에 클릭하는 시점*/
}
#result, #tr, #td {
	border:1px solid black;
	padding: 10px;
}
#result {
	border-collapse: collapse;
}

table{
	text-align:center;
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
							location.href="/MMONG/message/selectReceiveMsg.do";
						}
					}
				}); 
			}
		}
 	});
});

window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}

</script>
<body>
	<div id="total_div">
	<section class="wrapper site-min-height">
	
	<div class="btn-group btn-group-justified" style="margin-top:50px; margin-bottom:30px;"">
	  <div class="btn-group">
	    <a href="/MMONG/message/selectReceiveMsg.do"><button type="button" class="btn btn-theme">받은 쪽지함</button></a>
	  </div>
	  <div class="btn-group">
	    <a href="/MMONG/message/selectSendMsg.do"><button type="button" class="btn btn-theme">보낸 쪽지함</button></a>
	  </div>
	</div>		
	
	<br>
		<h2>　받은 쪽지함</h2>

<hr>
<br>
<div align="center">
	<table class="table">
		<thead>
			<tr>
				<td style="width: 30px;padding:10px 0px 10px 40px;"><input type="checkbox" id="allCheck"></td>
				<td style="width: 150px;padding:10px 0px 10px 0px;">보낸이</td>
				<td style="width: 200px;padding:10px 0px 10px 0px;">제목</td>
				<td style="width: 200px;padding:10px 0px 10px 0px;">내용</td>
				<td style="width: 100px;padding:10px 40px 10px 0px;">날짜</td>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty requestScope.receiveList }">
					<c:forEach items="${requestScope.receiveList }" var="list">
						<tr>
							<td style="width: 30px;padding:10px 0px 10px 40px;"><input type="checkbox" name="message" class="check" value="${list.no }"></td>
							<td style="width: 150px;padding:10px 0px 10px 0px;">${list.sendId } (${list.member.nickName })</td>
							<td style="width: 200px;padding:10px 0px 10px 0px;">
							 	<a href="#" onclick="window.open('/MMONG/message/viewReceiveMsg.do?no=${list.no }', '받은쪽지상세보기', 'height=480px, width=480px, left=400, top=100')">${list.title }</a> 
							</td> 
							<td style="width: 200px;padding:10px 0px 10px 0px;">
								<a href="#" onclick="window.open('/MMONG/message/viewReceiveMsg.do?no=${list.no }', '받은쪽지상세보기', 'height=480px, width=480px, left=400, top=100')">${list.content }</a>
							</td>
							<td style="width: 100px;padding:10px 40px 10px 0px;"><fmt:formatDate type="date" value="${list.messageDate }"/></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p>받은 쪽지가 없습니다.<p>
				</c:otherwise>	
			</c:choose>
		</tbody>
	</table>
<br>
	<p>
<%-- ####################################
										페이징 처리
###################################### --%>


						<!-- 첫페이지로 이동 -->
<a href="/MMONG/message/selectReceiveMsg.do?page=1">첫페이지</a>

<!-- 
			이전 페이지 그룹 처리
			이전 페이지 그룹이 있으면 링크 처리하고 없으면 화살표만 나오도록
-->
		 <c:choose >
			<c:when test="${requestScope.pageBean.previousPageGroup }">
			<a href="/MMONG/message/selectReceiveMsg.do?page=${requestScope.pageBean.beginPage-1 }">◀</a>
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
			<a href="/MMONG/message/selectReceiveMsg.do?page=${page}">${page }</a>
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
			<a href="/MMONG/message/selectReceiveMsg.do?page=${requestScope.pageBean.endPage+1}">▶</a>
		</c:when>
		<c:otherwise>
			▶
		</c:otherwise>
	</c:choose>
		 
						<!-- 마지막 페이지로 이동 -->

<a href="/MMONG/message/selectReceiveMsg.do?page=${requestScope.pageBean.totalPage}">마지막페이지</a>

</p>
</div>

<div align="left" style="padding:0px 0px 0px 30px;">
		<input type="button" class="btn btn-default" value="삭제" id="delete"> 
	</div>
	<br><br>
	<div align="center">
	<form action="/MMONG/message/searchReceiveMsg.do">
		<select name="searchOpt">
			<option value="ID">보낸사람의 ID</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
		</select>
		<input type="text" name="search">
		<input type="submit" class="btn btn-default btn-sm" value="검색">
	</form>
	<br><br><br>
	</div>
	</section>
	</div>
</body>
