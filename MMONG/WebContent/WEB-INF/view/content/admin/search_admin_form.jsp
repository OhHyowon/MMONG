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
		<h3><i class="fa fa-angle-right"></i> 관리자 찾기 폼</h3>
	<div id="content">
	<form action="/MMONG/admin/searchAdmindById.do" method="post">
		<table>
			<tr>
				<th>관리자 ID&nbsp;</th>
				<td><input type="text" name="adminId" value="${param.adminId }">&nbsp;</td>
				<td>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<input class="btn btn-default btn-sm" type="submit" value="조회">
				</td>
			</tr>
		</table>
	</form>
	</div>
</section>