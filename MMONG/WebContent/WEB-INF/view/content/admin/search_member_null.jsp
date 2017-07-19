<%@ page contentType="text/html;charset=UTF-8"%>


<style>
#content{
  top:0;right:0;bottom:0;left:0;
  display:flex;
  align-items:center;
  justify-content:center;
 
  display:-webkit-flex;
  -webkit-align-item;center;
  -webkit-justify-content:center;
}

</style>

<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height",(document.body.scrollHeight-38.4)+"px");
}
</script>

<div id="total_div">
<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i>&nbsp;'${param.memberId}'인 회원이 없습니다.
		</h3>
<div id="content">
	<button class="btn btn-default btn-sm" type="button" onclick="location.href='/MMONG/admin/search_member_form.do'">회원 다시 조회</button>
</div>
</section>
</div>