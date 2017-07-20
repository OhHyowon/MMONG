<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}
</script>

<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>고객센터
		</h3>

	<div class="btn-group btn-group-justified" style="margin-top:50px; margin-bottom:30px; width:450px; float:center;">
		<div class="btn-group">
			<%--공지사항 목록조회 메뉴 : selectAdminNoticeList.jsp로 가기 --%>
			<button class="btn btn-default" type="button" onclick="location.href='/MMONG/adminNotice/selectAdminNoticeList.do' ">공지사항 목록 조회</button>
		</div>
	
	</div>	
		
</section>
</div>








