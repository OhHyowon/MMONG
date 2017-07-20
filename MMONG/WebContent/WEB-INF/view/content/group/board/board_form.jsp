<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}

$(function() {
    $('#title').keyup(function (e){
        var content = $(this).val();
        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
    });
    $('#title').keyup();
});

$(function() {
    $('#content').keyup(function (e){
        var content = $(this).val();
        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
        $('#counter').html(content.length + '/1000');
    });
    $('#content').keyup();
});

</script>
<style type="text/css">
.error{
	color: red;
}
/*글자수 카운트*/
/* .wrap {
    width: 500px;
    height: auto;
    position: relative;
    display: inline-block;
}
.wrap textarea {
    width: 100%;
    resize: none;
    min-height: 4.5em;
    line-height:1.6em;
    max-height: 9em;
}
.wrap span {
    position: absolute;
    bottom: 5px;
    right: 5px;
}
#content {
  border-radius: 0.5em;
  padding: 0 .5em 0 .5em;
  font-size: 0.75em;
} */
</style>
</head>
<body>
<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>게시물 등록
		</h3>
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
<div class="col-lg-10">
<input type="button"class="btn btn-default btn-sm" value="내가 쓴 글" onclick="location.href='/MMONG/group/board/myBoardList.do'">
<input type="button"class="btn btn-default btn-sm" value="내가 쓴 댓글" onclick="location.href='/MMONG/group/reply/myReplyList.do'">
</div>
<br>

<div class="col-lg-10">
	<div class="form-panel">
		<h4 class="mb">글쓰기</h4>
		
<form action="/MMONG/group/board/register.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data" onsubmit="return confirm('등록하시겠습니까?');" class="form-horizontal style-form">
제목 : <input type="text" name="title" class="form-control" maxlength="50"><span class="error"><form:errors path="board.title" deilimiter="&nbsp;&nbsp;"/></span><br>
내용 : <br>
<textarea rows='20' cols='100' name="content" class="form-control" maxlength="1000">${param.content }</textarea>
<span class="error"><form:errors path="board.title" deilimiter="&nbsp;&nbsp;"/></span><br>
<input class="btn btn-default btn-sm" type="file" name="upImage" multiple><br>
<div style="float:right; position:relative; bottom:30px">
<input class="btn btn-default btn-sm" type="submit" value="등록"> <input class="btn btn-default btn-sm" type="button" value="취소" onclick="location.href='/MMONG/group/board/allBoardList.do?gourpNo=${sessionScope.groupNo}'"/>
</div>
</form>
	</div>
</div>
</section>
</div>