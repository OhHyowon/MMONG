<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.error{
	font-size:.8em;
	color: red;
}
.messageGo {
    position: relative;
}

.messageGo .messageGoTxt {
    visibility: hidden;
    width: 120px;
    background-color: black;
    color: #fff;
    text-align: center;
    border-radius: 6px;
    padding: 5px 0;

    /* Position the tooltip */
    position: absolute;
    z-index: 1;
}

.messageGo:hover .messageGoTxt {
    visibility: visible;
}
</style>
<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#BoardDeleteBtn").on("click",function(){
			if(!confirm("삭제하시겠습니까?")){
				return;
			}else{
		$.ajax({
			url:"/MMONG/group/board/boardDelete.do", 
			type:"post",
			data:{"boardNo":$("#boardNo").val(),"${_csrf.parameterName}":"${_csrf.token}"},
			dataType:"json",
			success:function(txt){
				if(txt=='1'){
				alert('삭제되었습니다.');   
				location.href="/MMONG/group/board/allBoardList.do"
				}else{
					alert('삭제실패');
				}
			}
		});
			}
	}); // end of deleteBtn
	$('.updateBtn').on("click",function(){
		$(this).parent().parent().find("td:nth-child(6)").find("div").show();
	}); // end of updateBtn (리플)
	$('.replyDeleteBtn').on('click',function(){
		var replyNo=$(this).parent().parent().find("td:nth-child(7)").find("input").val();
		if(!confirm("댓글 삭제하시겠습니까?")){
			return;
		}else{
			$.ajax({
				url:"/MMONG/group/reply/deleteReply.do",
				type:"post",
				data:{"replyNo":replyNo,"${_csrf.parameterName}":"${_csrf.token}","boardNo":$('#boardNo').val()},
				dataType:"json",
				success:function(txt){
					if(txt=='1'){
						alert("삭제되었습니다.");
						location.href="/MMONG/group/board/board_view.do?boardNo="+${requestScope.board.no}
				}else{
					alert("삭제실패");
				}
				}
			});
		}
	}); // end of .replyDeleteBtn
	$('.messageGoTxt').on("click",function(){
		alert("올ㅋ 되는뎅ㅋ 여기서 세연이한테 쪽지 주소 받고, 아이디, 닉네임 넘겨 주면 됩니다!");
	});
});

</script>
</head>
<body>

<jsp:include page="/group/board/board_menu.do"/>

	<sec:authentication property="principal.memberId" var="loginId"/>
	<h2>게시글 보기</h2>
	<hr>
	<table>
	
		<tr>
			<td>제목</td>
			<td>${requestScope.board.title }</td>
		</tr>
		<tr>
			<td>작성자(닉네임)</td>
			<td class="messageGo">${requestScope.board.memberId }(${requestScope.boardNickname })
				<div class="messageGoTxt">쪽지보내기</div>
			</td>
		</tr>
		<tr>
			<td>작성일자</td>
			<td><fmt:formatDate value="${requestScope.board.boardDate }" pattern="yyyy-MM-dd HH:mm"/> </td>
		</tr>
		<tr>
			<td>내용</td>
			<td>${requestScope.board.content }<br>
			<c:forEach items="${requestScope.nameList }" var="fileName">
				<img src="/MMONG/up_image/${fileName }" width="400px">
				<input type="hidden" name="nameList" value="${fileName }">
			</c:forEach></td>
		</tr>
		<tr>
			<td>조회수</td>
			<td>${requestScope.board.hit }</td>
		</tr>
	
	</table> 
	<%-- 로그인된 아이디와 글쓴 아이디가 같을 때!!!!  --%>
	<form action="/MMONG/group/board/boardUpdate1.do" method="post">
	<c:if test="${requestScope.board.memberId == loginId }">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="hidden" name=nameList value="${requestScope.nameList }">
		<input type="hidden" id="boardNo" name="boardNo" value="${requestScope.board.no}">
		<input type="submit" value="수정하기" >
		<input type="button" id="BoardDeleteBtn" value="삭제하기"/>
	</c:if>
		</form>

<%--########################   댓글    #########################  --%>

<form action="/MMONG/group/reply/register.do" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="text" name="content">
	<input type="hidden" name="boardNo" value="${requestScope.board.no }">
	<input type="submit" value="댓글등록"><span class="error"><form:errors path="reply.content" deilimiter="&nbsp;&nbsp;"/></span>
	<br>
</form>

<table id="replyTable">

	<c:forEach items="${requestScope.replyList }" var="reply" varStatus="idx">
		<c:choose>  
		<c:when test="${ reply.memberId  == loginId}">  <%-- 로그인된 아이디와 댓글 작성자가 같지 않을 때 --%>
				<tr>
					<td>${reply.content} </td>
					<td>${reply.memberId }(${requestScope.replyNickname[idx.index] })</td>
					<td><fmt:formatDate value="${reply.replyDate }" pattern="yyyy-MM-dd HH:mm"/></td>
					<td><input type="button" value="댓글수정" class="updateBtn"></td>
					<td><input type="button" class="replyDeleteBtn" value="댓글삭제"></td>
					<td>
						<div id="updateForm"  style="display:none" >
							<form action="/MMONG/group/reply/replyUpdate.do" method="post" >
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<input type="hidden" name="no" value="${reply.no }">
								<input type="hidden" name="boardNo" value="${reply.boardNo }">
								<input type="text" name="content" value="${reply.content} ">
								<input type="submit" value="수정완료">
							</form>
						</div>
					</td>
					<td><input type="hidden" name="replyNo" value="${reply.no}"></td>
					</tr>
			</c:when>
			<c:otherwise>  <%-- 로그인된 아이디와 댓글 쓴 아이디가 같지 않을 때 --%>
				<tr>
					<td>${reply.content }</td>
					<td>${reply.memberId }(${requestScope.replyNickname[idx.index] })</td>
					<td><fmt:formatDate value="${reply.replyDate }" pattern="yyyy-MM-dd HH:mm"/></td>
					<td></td>
					<td></td>
				</tr>
			</c:otherwise>
		 </c:choose> 
		 
	</c:forEach>
	
</table>




</body>
</html>