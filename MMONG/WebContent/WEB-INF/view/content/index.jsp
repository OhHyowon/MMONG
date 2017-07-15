<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>




	<section class="wrapper site-min-height">
		<h3>
			<i class="fa fa-angle-right"></i> 메인페이지
		</h3>


		<div class="row mt">
			<div class="col-lg-12">
				<p>
					<sec:authorize access="hasRole('ROLE_1')">
						<sec:authentication property="principal.memberId" /> 님 환영합니다.<br>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_0')">
						<sec:authentication property="principal.adminId" /> 님 환영합니다.<br>
					</sec:authorize>
				</p>
			</div>
		</div>

	</section>

