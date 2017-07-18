<%@ page contentType="text/html;charset=UTF-8"%>

<style type="text/css">
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


	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 회원 찾기
		</h3>
<div id="content">
	<form action="/MMONG/admin/searchMemberById.do" method="post">
		<table>
			<tr>
				<th>회원 ID&nbsp;</th>
				<td><input type="text" name="memberId" value="${param.memberId }">&nbsp;</td>
				<td>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<input class="btn btn-default btn-sm" type="submit" value="조회">
				</td>
			</tr>
		</table>
	</form>
</div>
</section>
