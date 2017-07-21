<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style type="text/css">
.wrap {
    width: 500px;
    height: auto;
    position: relative;
    display: inline-block;
}
.wrap span {
    position: absolute;
    bottom: 5px;
    right: 5px;
}
.wrap textarea {
    width: 100%;
    resize: none;
    min-height: 1.5em;
    line-height:1.6em;
    max-height: 9em;
}
.wrap input {
    width: 100%;
    resize: none;
    min-height: 1.0em;
    line-height:1.0em;
    max-height: 5em;
}
#counter {
  border-radius: 0.5em;
  padding: 0 .5em 0 .5em;
  font-size: 0.75em;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">

/// textarea 글자수 체크
$(function() {
    $('#content').keyup(function (e){
        var content = $(this).val();
        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
        $('#counter').html(content.length + '/150');
    });
    $('#content').keyup();
});

$(function() {
    $('#title').keyup(function (e){
        var content = $(this).val();
        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
        $('#title').html(content.length + '/50');
    });
    $('#title').keyup();
});



window.onload=function(){
	$("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}

$(document).ready(function(){
	$("#updateBtn").on("click",function(){
		if(!$("#title").val()){
			alert("제목을 입력하세요");
			return false;
		}
		if(!$("#content").val()){
			alert("내용을 입력하세요");
			return false;
		}
		if(confirm("수정하시겠습니까?")){
			alert("수정 완료");
		}else{
			alert("수정 취소");
			return false;
		}
	});
});

</script>

<div id="total_div">
<section id="main-content">
	<section class="wrapper site-min-height">
		<h3>
			공지사항 수정 폼
		</h3>




<div class="col-lg-10">
	<div class="form-panel">
		<h4 class="mb">공지사항 수정하기</h4>
				
        <form action="/MMONG/adminNotice/updateAdminNotice.do?adminNoticeNo=${requestScope.adminNotice.no}" method="post" >
        		
                작성자: <sec:authentication property="principal.adminId"/>
                		<input type="hidden" id="adminId" placeholder="작성자" name="adminId" value="<sec:authentication property="principal.adminId"/>"/><br><br>
                <div class="wrap">
                제목:
           	   			<input class="form-control" type="text" id="title" maxlength="50" name="title" value="${requestScope.adminNotice.title}"/><br>
                </div>
                <div class="wrap">
                내용: 
	              	 	<textarea class="form-control" cols="80" rows="10" id="content" maxlength="150" name="content">${requestScope.adminNotice.content}</textarea>
	              	 	<span id="counter">###</span>
              	</div>
	                <div id="view-menu">
	                   	<input type="hidden" name="no" value="${requestScope.adminNotice.no}"/><br>
	                	<input type="hidden" name="adminDate" value='<fmt:formatDate value="${requestScope.adminNotice.adminDate }" pattern="yyyy-MM-dd HH:mm"/>'/><br>
	                    <input class="btn btn-default btn-sm" type="submit" id="updateBtn" value="저장">&nbsp;
	                   <input class="btn btn-default btn-sm" type="reset" value="되돌리기">&nbsp;
	                    <input class="btn btn-default btn-sm" type="button" value="목록" onclick="location.href='/MMONG/adminNotice/selectAdminNoticeList.do'"/>
	                  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                </div>
        </form>
	</div>
</div>
	</section>
</section>
</div>