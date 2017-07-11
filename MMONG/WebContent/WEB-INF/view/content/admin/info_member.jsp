<%@ page contentType="text/html;charset=UTF-8"%>

<h3>회원(member) 정보</h3>
회원 ID : ${requestScope.member.memberUser.userId}<br>
회원 이름 : ${requestScope.member.memberName}<br>
닉네임 : ${requestScope.member.nickName}<br>
권한 : ${requestScope.member.memberUser.userAuthority}<br>
전화번호 :${requestScope.member.memberPhone}<br>
이메일 : ${requestScope.member.memberEmail}<br>
주소 :${requestScope.member.memberAddress}<br>
사진 : ${requestScope.member.memberPicture}<br>


<a href="/MMONG/index.do">메인페이지</a>

<form action="/MMONG/admin/changeAuthorityMember.do" method="post">
	<input type="hidden" name="memberId" value="${requestScope.member.memberUser.userId}">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<input type="submit" value="권한 변경하기">
</form>
<br>
