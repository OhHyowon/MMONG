<%@page import="com.mmong.vo.Group"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}
$(document).ready(function() {
	$("#leaveBtn").on("click", function() {
		var leader = $("#leader").val();
		var loginId = $("#loginId").val();

		if (leader == loginId) {
			alert("모임장은 모임을 탈퇴 할 수 없습니다!!!");
		} else {
			if (!confirm("정말 모임을 탈퇴 하시겠습니까?")) {
				return;
			} else {
				$.ajax({
					url : "/MMONG/groupMember/leaveGroup.do",
					type : "post",
					data : {
						"${_csrf.parameterName}" : "${_csrf.token}"
					},
					dataType : "json",
					success : function(txt) {
						if (txt == '1') {
							alert("탈퇴 하였습니다.");
							location.href = "/MMONG/group/mygroup.do"
						} else {
							alert("탈퇴 불가");
						}
					}
				}); // ajax 끝
			}
		}
	});
	
	//아이디로 검색 (모달에서)시 검색결과 뿌리기
	$("#searchBtn").on("click", function(){
		if($("#searchMemberId").val()==""){
			$("#inputForm").attr('class', 'form-group has-error');
			return;
		}
		$.ajax({
			"url" : "/MMONG/groupMember/searchAllMember.do",
			"data" : {"memberId":$("#searchMemberId").val()},
			"dataType" : "JSON",
			"success":function(response) {
				$("#searchMemberList").empty();
				if(response==""){
					$("#searchMemberList").append("검색된 아이디는 존재하지 않습니다.");
				}else{
					$.each(response, function(){
						$("#searchMemberList").append("<li id='searchedId' value='"+this.memberId+"'><button type='button' class='btn btn-default btn-xs' style='margin-right:10px'>초대</button>"+this.memberId+"</li>");
					});
				}
			}
		});//ajax 끝
	});
	
	//초대버튼 누를 시 
	$("#searchMemberList").on("click", "button", function(){
		$.ajax({
			"url" : "/MMONG/groupMember/inviteGroupMember.do",
			"data" : {"memberId" : $(this).parent().attr('value'), "groupNo":$("#groupNo").val()},
			"dataType" : "text",
			"success":function(response) {
				alert("초대메시지를 보냈습니다.");
			}
		});//ajax 끝		
	});
});
</script>

<div id="total_div">
	<section class="wrapper site-min-height">

<%-- =============소모임 상세페이지 소메뉴 : 밑에 두메뉴안에도 이것 포함시키기! ================ --%>
	<div class="btn-group btn-group-justified" style="margin-top:50px; margin-bottom:30px;"">
	  <div class="btn-group">
	    <a href="/MMONG/group/groupDate/allGroupDateList.do"><button type="button" class="btn btn-theme">모임 일정 목록</button></a>
	  </div>
	  <div class="btn-group">
	    <a href="/MMONG/group/board/allBoardList.do"><button type="button" class="btn btn-theme">자유게시판</button></a>
	  </div>
	  <div class="btn-group">
	    <a href="/MMONG/group/mygroup.do"><button type="button" class="btn btn-theme">나의 소모임</button></a>
	  </div>
	</div>			
<%-- =============소모임 상세페이지 소메뉴 끝================ --%>


<!-- 참여자 목록 -->
<sec:authorize access="!isAuthenticated()">
		로그인 해주세요. 
	</sec:authorize>
<sec:authorize access="isAuthenticated()">
	<!-- 참여멤버 조회 -->

	<c:choose>
		<c:when test="${groupMemberList == null}">
				참여 멤버 목록 조회는 모임 멤버만 가능합니다. 
			</c:when>
		<c:otherwise>
	
		<div class="col-md-4" style="text-align:center;">
					<table class="table">
						<thead>
							<tr>
								<td>참여자 ID</td>
							</tr>
						</thead>
						<tbody>
								<c:forEach var="groupMember" items="${groupMemberList }">
							<tr>
									<td>${groupMember.memberId }</td>
							</tr>
								</c:forEach>
						</tbody>
					</table>
			</div>
		</c:otherwise>
	</c:choose>



	<c:choose>
		<c:when test="${groupMemberList != null}"> <!-- 멤버초대랑 모임탈퇴는 내가 그룹에 가입되어있을때만 -->
	<!-- 멤버초대 -->	   
	<div class="col-md-9"> 					
			<button class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModal">invite</button>
				<!-- 모임탈퇴 -->	
			<button class="btn btn-default btn-sm" id="leaveBtn" >모임 탈퇴</button>
			<sec:authentication property="principal.memberId" var="loginId" />
			<c:if test="${requestScope.leader eq loginId}">
					<input type="button" value="모임장 변경하기" class="btn btn-default btn-sm"
						onclick="window.open('/MMONG/groupMember/searchGroupMember2.do', '모임장 변경하기', 'top=100px, left=100px, height=220px, width=500px')">
			</c:if>
		</div>
	

		
			<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			        <h4 class="modal-title" id="myModalLabel">Invite Member</h4>
			      </div>
			      <div class="modal-body">
			       	 <!-- INLINE FORM ELELEMNTS -->
			          	<div class="row mt">
			          		<div class="col-lg-12">
			                      <form class="form-inline" role="form">
			                          <div id=inputForm class="form-group">
			                              <!-- <label class="sr-only" for="exampleInputEmail2">Email address</label> -->
			                              <input class="form-control" id="searchMemberId" placeholder="아이디 검색">
			                          </div>
			                          <button type="button" class="btn btn-theme" id="searchBtn">search</button> <br>
			                          <input type="hidden" id="groupNo" value="${requestScope.groupNo }"> <!-- 모임 초대 시 groupNo보내기 위해 -->
									  <br>
									  <div id="searchMemberList"></div> <!-- 검색된 아이디 뿌려줌 -->									  
			                      </form>
			          		</div><!-- /col-lg-12 -->
			          	</div><!-- /row -->
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">cancel</button>
			      </div>
			    </div>
			  </div>
			</div>  
		</c:when>
	</c:choose>
</sec:authorize>

<input type="hidden" id="leader" value="${requestScope.leader }">
<input type="hidden" id="loginId" value="${loginId }">

</section>
</div>