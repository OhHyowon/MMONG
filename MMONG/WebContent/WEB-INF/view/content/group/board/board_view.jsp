<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>

<style type="text/css">
.error{
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
#button{
    position: absolute;
    right: 10px;
    margin-right:7px
}

</style>

<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}

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
		$(this).parent().parent().parent().find("div:nth-child(2)").next().show();
	}); // end of updateBtn (리플)
	$('.replyDeleteBtn').on('click',function(){		
		var replyNo=$(this).next().val();
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
});
</script>

<div id="total_div">
	<section class="wrapper site-min-height">


<%-- =============소모임 상세페이지 소메뉴 : 밑에 두메뉴안에도 이것 포함시키기! ================ --%>
	<div class="btn-group btn-group-justified" style="margin-top:50px; margin-bottom:30px;"">
	  <div class="btn-group">
	    <a href="/MMONG/group/groupDate/allGroupDateList.do"><button type="button" class="btn btn-theme">모임 일정 목록</button></a>
	  </div>
	  <div class="btn-group">
	    <a href="/MMONG/group/board/allBoardList.do"><button type="button" class="btn btn-theme">자유게시판</button></a>
	  </div>
	  <div class="btn-group">
	    <a href="/MMONG/group/mygroup.do"><button type="button" class="btn btn-theme">나의 소모임</button></a>
	  </div>
	</div>			

<%-- =============소모임 상세페이지 소메뉴 끝================ --%>

<hr>
	<input type="button"class="btn btn-default btn-sm" value="글쓰기" onclick="location.href='/MMONG/group/board/board_form.do'">
	<input type="button"class="btn btn-default btn-sm" value="내가 쓴 글" onclick="location.href='/MMONG/group/board/myBoardList.do'">
	<input type="button"class="btn btn-default btn-sm" value="내가 쓴 댓글" onclick="location.href='/MMONG/group/reply/myReplyList.do'">
<br><br>

	<sec:authentication property="principal.memberId" var="loginId"/>
	<sec:authentication property="principal.nickName" var="nickName"/>
	<div class="col-md-9" style="margin-left: 170px;">

			<table
				style="border-top: 1px solid gray; border-bottom: 1px dashed; width: 943px; margin-botton: 1px">
				<tr>
					<td style="padding: 10px;">${requestScope.board.title }</td>
					<td style="text-align: right;"><fmt:formatDate
							value="${requestScope.board.boardDate }"
							pattern="yyyy-MM-dd HH:mm" /></td>
				</tr>
			</table>


			<table style="border-bottom: 1px solid gray; width: 943px">
				<tr>
					<td class="messageGo" style="padding: 10px;">${requestScope.board.memberId }(${requestScope.boardNickname })
						&nbsp;|&nbsp; 조회수 ${requestScope.board.hit }
						<div class="messageGoTxt">
							쪽지보내기 <input type="hidden"
								value="${requestScope.board.memberId }" id="id"> <input
								type="hidden" value="${requestScope.boardNickname }"
								id="nickname">
						</div>
					</td>
				</tr>
				<tr>
					<td style="padding: 10px;">
						<div>${requestScope.board.content }<br>
							<c:forEach items="${requestScope.nameList }" var="fileName">
								<img src="/MMONG/up_image/${fileName }" width="400px">
								<input type="hidden" name="nameList" value="${fileName }">
							</c:forEach>
						</div>
					</td>
				</tr>
			</table>

			<br>


			<%-- 로그인된 아이디와 글쓴 아이디가 같을 때!!!!  --%>
			<div style="margin-left: 776px;">
				<form action="/MMONG/group/board/boardUpdate1.do" method="post"
					style="">
					<c:if test="${requestScope.board.memberId == loginId }">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
						<input type="hidden" name=nameList
							value="${requestScope.nameList }">
						<input type="hidden" id="boardNo" name="boardNo"
							value="${requestScope.board.no}">
						<input class="btn btn-default btn-sm" type="submit" value="수정하기">
						<input class="btn btn-default btn-sm" type="button"
							id="BoardDeleteBtn" value="삭제하기" />
					</c:if>
				</form>
			</div>
			<%--########################   댓글    #########################  --%>
			<br>
			<br>

			<div style="background: #DFDFDF; width: 943px">
				<div>&nbsp;</div>
				<c:forEach items="${requestScope.replyList }" var="reply"
					varStatus="idx">
					<c:choose>
						<c:when test="${ reply.memberId  == loginId}">
							<div>
								<div style="padding-left: 10px;position:relative">
									<div class="messageGo">
										<b> ${reply.memberId }(${requestScope.replyNickname[idx.index] })
										</b> &nbsp;&nbsp;&nbsp;
										<fmt:formatDate value="${reply.replyDate }"
											pattern="yyyy-MM-dd HH:mm" />
										<div class="messageGoTxt">
											쪽지보내기 <input type="hidden" value="${reply.memberId }" id="id">
											<input type="hidden"
												value="${requestScope.replyNickname[idx.index] }"
												id="nickname">
										</div>
									</div>
									<div style="position:absolute;top:5px;left:880px;display:flex;">
									<button class="updateBtn btn btn-primary btn-xs" value="댓글수정">
										<i class="fa fa-pencil"></i>
									</button>
									<button class="replyDeleteBtn btn btn-danger btn-xs" value="댓글삭제">
										<i class="fa fa-trash-o "></i>
									</button>
									</div>
									<input type="hidden" name="replyNo" value="${reply.no }">
								</div>
								<div style="padding: 7px">
									<span>${reply.content}</span>
								</div>
								<div id="updateForm" style="display: none">
									<form action="/MMONG/group/reply/replyUpdate.do" method="post">
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" /> <input type="hidden" name="no"
											value="${reply.no }"> <input type="hidden"
											name="boardNo" value="${reply.boardNo }"> <input
											type="text" name="content" value="${reply.content} "
											size="100"> <input type="button" value="취소"
											class="cancleBtn"> <input type="submit" value="수정완료">
									</form>
								</div>
								<div>
									<hr style="border: 0; border-bottom: 1px dashed #ccc;">
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<%-- 로그인된 아이디와 댓글 쓴 아이디가 같지 않을 때 --%>
							<div>
								<div style="padding-left: 10px;">
									<span><b>${reply.memberId }(${requestScope.replyNickname[idx.index] })</b></span>&nbsp;&nbsp;&nbsp;<span><fmt:formatDate
											value="${reply.replyDate }" pattern="yyyy-MM-dd HH:mm" /></span>
								</div>
								<div style="padding: 7px">
									<span>${reply.content}</span>
								</div>
								<div>
									<hr style="border: 0; border-bottom: 1px dashed #ccc;">
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<form action="/MMONG/group/reply/register.do" method="post"
					style="padding: 10px">
					<div>
						<b>${loginId }(${nickName})</b>
					</div>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <span class="error"><form:errors
							path="reply.content" deilimiter="&nbsp;&nbsp;" /></span>
					<textarea cols="120" name="content"></textarea>
					<input type="hidden" name="boardNo"
						value="${requestScope.board.no }">
					<div style="float: right">
						<input type="submit" value="댓글등록" class="btn btn-default"
							style="margin-right: 24px">
					</div>
					<br>
				</form>
			</div>


		</div>
		<%-- 댓글 end --%>
	</section>
</div>
