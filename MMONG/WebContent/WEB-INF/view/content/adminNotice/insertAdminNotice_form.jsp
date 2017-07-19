<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<style type="text/css">

#view-menu{
	text-align: center;
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
	/* 	alert($("#adminId").val());
		alert($("#title").val().length);
		alert($("#content").val());
		alert($("#no").val());
		alert($("#adminDate").val()); */
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
			<i class="fa fa-angle-right"></i> 공지사항 글쓰기
		</h3>
		
<table>
        <form id="insert" action="/MMONG/adminNotice/insertAdminNotice.do" method="post" >
        		
        	<tr>
                <th>작성자: </th>
                <td>&nbsp;<sec:authentication property="principal.adminId"/>
                	<input type="hidden" id="adminId" placeholder="작성자" name="adminId" value="<sec:authentication property="principal.adminId"/>"/></td>
            </tr>
            <tr>
                <th>제목: </th>
                <td><input type="text" id="title" placeholder="제목을 입력하세요." name="title"/></td>
            </tr>
            <tr>
                <th>내용: </th>
                <td><textarea cols="80" rows="10" id="content" placeholder="내용을 입력하세요." name="content"></textarea></td>
            </tr>
            <tr>
                <td colspan="2">
	                <div id="view-menu">
	                   	<input type="hidden" id="no" name="no" value="-1"/>
	                	<input type="hidden" id="adminDate" name="adminDate" value="2000-01-01"/>
	                    <input class="btn btn-default btn-sm" type="reset" value="초기화"/>&nbsp;
	                  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                    <input class="btn btn-default btn-sm" type="button" id="insertBtn" value="등록" >&nbsp;
	                    <input class="btn btn-default btn-sm" type="button" value="목록" onclick="location.href='/MMONG/adminNotice/selectAdminNoticeList.do'"/>
	                </div>
                </td>
            </tr>
        </form>
</table>
</section>
</div>