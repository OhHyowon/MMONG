<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
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
		alert($("#title").val());
		$.ajax({
			"url":"/MMONG/adminNotice/insertAdminNotice.do",
			"type":"post",
			"data":{"adminId":$("#adminId").val(), "title":$("#title").val(),
						"content":$("#content").val(), "no":$("#no").val(), 
						"adminDate":$("#adminDate").val(), "${_csrf.parameterName}":"${_csrf.token}"},
			"dataType":"text",
			"beforeSend":function(){
				if($("#title").val()==null){
					alert("제목을 입력하세요");
					return false;
				}else if($("#content").val()==null){
					alert("내용을 입력하세요");
					return false;
				}
			},
			"success":function(response){
				alert("등록 성공");
				location.reload();
			}
		});
	});
}); 
</script>-->


<h3>공지사항 글쓰기</h3>
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
                <td><textarea cols="80" rows="10" id="co ntent" placeholder="내용을 입력하세요." name="content"></textarea></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="reset" value="초기화"/>
                   	<input type="hidden" id="no" name="no" value="-1"/><br>
                	<input type="hidden" id="adminDate" name="adminDate" value="2000-01-01"/>
                  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="submit" id="insertBtn" value="등록" >
                    <input type="button" value="목록" onclick="location.href='/MMONG/adminNotice/selectAdminNoticeList.do'"/>
                </td>
            </tr>
        </form>
</table>

