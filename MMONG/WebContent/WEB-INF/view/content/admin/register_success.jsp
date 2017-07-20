<%@ page contentType="text/html;charset=UTF-8"%>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}
</script>

<div id="total_div">
	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 관리자 등록 성공
		</h3>
 '${requestScope.administrator.adminId }'님을 관리자로 등록하였습니다<br>

</section>
</div>