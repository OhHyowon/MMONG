<%@ page contentType="text/html;charset=UTF-8"%>

	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 관리자 등록 성공
		</h3>
관리자 ID : ${requestScope.administrator.adminId }<br>
이름 : ${requestScope.administrator.adminName}<br>
전화번호 : ${requestScope.administrator.adminPhone }<br>
이메일 : ${requestScope.administrator.adminEmail }<br>

<a href="/MMONG/index.do">메인페이지</a>
</section>