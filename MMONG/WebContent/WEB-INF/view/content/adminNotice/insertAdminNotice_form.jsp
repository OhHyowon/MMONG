<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style type="text/css">
#view-menu{
	text-align: center;
}
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
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}
</script>

<div id="total_div">
<script type="text/javascript" src="/MMONG/resource/jquery/jquery-3.2.1.min.js"></script>
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

function formChk(){
	var titleSize = true; //제목 체크값
	var contentSize = true; //내용 체크값

	if($("title").val()==""){
		titleSize = false;
		alert("제목을 입력해 주세요");
	}
	if($("content").val()==""){
		contentSize = false;
		alert("내용을 입력해 주세요");
	}

}//form check 함수 끝


$(document).ready(function(){
	$("#insertBtn").on("click", function(){
		$.ajax({
			"url":"/MMONG/adminNotice/insertAdminNoticeAjax.do",
			"type":"post",
			"data":{"adminId":$("#adminId").val(), "title":$("#title").val(),
						"content":$("#content").val(), "no":$("#no").val(), 
						"adminDate":$("#adminDate").val(), "${_csrf.parameterName}":"${_csrf.token}"},
			"dataType":"text",
			"beforeSend":function(){
				// alert($("#title").val()); 
				if(!$("#title").val()){
					alert("제목을 입력하세요");
					return false;
				}
				if(!$("#content").val()){
					alert("내용을 입력하세요");
					return false;
				}
				if(!confirm("등록 하시겠습니까?")){
					alert("등록 취소");
					return false;
				}
			},
			"success":function(response){
				alert("등록 성공");
				location.href='/MMONG/adminNotice/viewAdminNotice.do?adminNoticeNo='+response;
			}
		});//ajax 끝
	});//#insertBtn 끝
});//ready 끝
</script>

	<section class="wrapper site-min-height">
		<h3>
			공지사항 글쓰기
		</h3>
		
		
<div class="col-lg-10">
	<div class="form-panel">
		<h4 class="mb">글쓰기</h4>
				
        <form id="insert" action="/MMONG/adminNotice/insertAdminNotice.do" method="post" >
        		
                작성자: <sec:authentication property="principal.adminId"/>
                		<input type="hidden" id="adminId" placeholder="작성자" name="adminId" value="<sec:authentication property="principal.adminId"/>"/><br><br>
                <div class="wrap">
                제목:
           	   			<input class="form-control" type="text" id="title" maxlength="50" placeholder="제목을 입력하세요." name="title"/><br>
                </div>
                <div class="wrap">
                내용: 
	              	 	<textarea class="form-control" cols="80" rows="10" id="content" maxlength="150" placeholder="내용을 입력하세요." name="content"></textarea>
	              	 	<span id="counter">###</span>
              	</div>
	                <div id="view-menu">
	                   	<input type="hidden" id="no" name="no" value="-1"/>
	                	<input type="hidden" id="adminDate" name="adminDate" value="2000-01-01 01:01"/>
	                    <input class="btn btn-default btn-sm" type="button" id="insertBtn" value="등록" >&nbsp;
	                    <input class="btn btn-default btn-sm" type="reset" value="초기화"/>&nbsp;
	                    <input class="btn btn-default btn-sm" type="button" value="목록" onclick="location.href='/MMONG/adminNotice/selectAdminNoticeList.do'"/>
	                  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                </div>
        </form>
	</div>
</div>
</section>
</div>