<%@page import="com.mmong.vo.GroupMember"%>
<%@page import="java.util.List"%>
<%@page import="com.mmong.vo.Member"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.mmong.vo.Group"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	$("#total_div").css("min-height", (document.body.scrollHeight-38.4)+"px");
}
$(document).ready(function(){
	//로그인 안했을 때 소모임 가입 버튼 누르면 처리
	$("#createNone").on("click", function(){
		alert("먼저 로그인 해주세요.");
		return;
	});
	
	//소모임 가입 처리
	$("#create").on("click", function(){
		if(confirm("소모임에 가입하시겠습니까?")){
			$.ajax({
				"url" : "/MMONG/groupMember/insertGroupMember.do",
				"data" : {"no":0, "groupNo":$("#groupNo").val(), "memberId":$("#memberId").val(), "${_csrf.parameterName}":"${_csrf.token}"},
				"dataType" : "text",
				"success":function(response) {
					if(response=="1"){
						alert("가입이 완료되었습니다.");
						opener.parent.location.reload();
					}else{
						alert("이미 가입된 소모임 입니다.");
					}
				}
			});//ajax 끝
		}
	});
	
	//주인장이 소모임 수정 버튼 클릭시
	$("#editGroupBtn").on("click", function(){
		alert("수정하기");
		window.open("/MMONG/group/updateGroup1.do","모임 수정하기","top=100px, left=100px, height=220px, width=500px");
	});
	
	$("#deleteBtn").on("click",function(){
		var groupName=$("#groupName").val();
	
		if(!confirm("'"+groupName+"'"+" 소모임을 삭제하시겠습니까?")){
			return
		}else{
			$.ajax({
				url:"/MMONG/group/deleteGroup.do",
				type:"post",
				data:{"${_csrf.parameterName}":"${_csrf.token}"},
				dataType:"text",
				success:function(txt){
					if(txt=="1"){
						alert("삭제되었습니다.");
						location.href="/MMONG/group/mygroup.do"
					}else{
						alert("소모임에 참여중인 멤버가 있습니다. 삭제 불가");
					}
				}
			}); //ajax 끝
		}
	});
	
	
	//소모임 하나 클릭했을 때 소모임 상세페이지로 이동 
	$(".myGroup").on("click", function(){
		$(this).parent().submit();
	});
	
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
		<h3>
			<i class="fa fa-angle-right"></i> 소모임 페이지
		</h3>

<%-- =============소모임 상세페이지 소메뉴 : 밑에 세메뉴안에도 이것 포함시키기! ================ --%>
  <sec:authorize access="hasRole('ROLE_1')"> 
<ul>
	<li><a href="/MMONG/group/groupDate/allGroupDateList.do">모임 일정 목록</a></li> 
	<li><a href="/MMONG/group/board/allBoardList.do">자유게시판</a></li>
</ul>
</sec:authorize>
<%-- =============소모임 상세페이지 소메뉴 끝================ --%>


<!-- 그룹 상세페이지가 열릴 때마다 해당 소모임NO를 세션에 담음 -->
<%
	int groupNo = ((Group)request.getAttribute("group")).getNo();
	session.setAttribute("groupNo", groupNo);	
%>
<!-- 그룹 가입 시 그룹멤버 객체 만들어주기위해 넘겨줄 값 : 이건 예전에 만든거라 세션처리 못함 - 이주현 -->
<input type="hidden" id="groupNo" value="${requestScope.group.no}">
<sec:authorize access="hasRole('ROLE_1')">
	<input type="hidden" id="memberId" value="<sec:authentication property="principal.memberId"/>">
</sec:authorize>
<input type="hidden" id="groupName" value="${requestScope.group.name }">

<!-- 소모임 정보 -->
<p><b>모임 정보</b></p>
모임 이름 : ${requestScope.group.name } <br>
모임 장 : ${requestScope.group.leader } <br>

<!-- 가입하기 버튼 -->
<sec:authorize access="!isAuthenticated()"> <!-- 로그인 안했을시  -->       
   <button type="button" id="createNone" class='btn btn-default'>가입하기</button>
</sec:authorize>
<sec:authorize access="isAuthenticated()"> <!-- 로그인 했을시 -->
   <%
   //관리자, 주인장, 새로온 사람 별 버튼 달기 로직 --이주현
   List authList = (List)SecurityContextHolder.getContext().getAuthentication().getAuthorities(); //로그인한 사용자 권한정보 리스트
   String au = String.valueOf(authList.get(0));
   if(au.equals("ROLE_1")){//관리자인 경우 아무것도 안뜸 
      Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();      
      if(((Group)request.getAttribute("group")).getLeader().equals(member.getMemberId())){ //주인장은 가입하기 버튼 대신 소모임 정보수정 버튼 필요
         out.println("<button type='button' id='editGroupBtn' class='btn btn-default'>소모임 수정하기</button>");
      	 out.println("<button type='button' id='deleteBtn' class='btn btn-default'>소모임 삭제하기</button>");
      }else{//주인장이 아닌경우 그룹멤버에 이미 내가 포함되어있는지 검사후 안되어있으면 가입하기버튼
    	  List<GroupMember> groupMemberList = (List)(request.getAttribute("groupMemberList"));
    	  boolean flag = false;
    	  for(GroupMember gm : groupMemberList){
    		  if(gm.getMemberId().equals(member.getMemberId())){
    			  flag = true; //내가 가입되어있음 
    			  break;
    		  }
    	  }
    	  if(flag==false){ //가입 안되어있는 경우 - 가입하기 버튼 
    		  out.println("<button type='button' id='create' class='btn btn-default'>가입하기</button>");
    	  }
      }
   }
   %>
</sec:authorize>
<br>


<hr>

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
	<div class="col-md-12" style="margin-left:450px;">
		<div class="col-md-4" style="text-align:center;">
					<table class="table">
						<thead>
							<tr>
								<td><b>참여자 ID</b></td>
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
			</div>
		</c:otherwise>
	</c:choose>



	<c:choose>
		<c:when test="${groupMemberList != null}"> <!-- 멤버초대랑 모임탈퇴는 내가 그룹에 가입되어있을때만 -->
	<!-- 멤버초대 -->	   
	<div class="col-md-12" style="text-align:center;margin-left:34px"> <!-- 버튼 모아놓음 -->			
		<button class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModal">invite</button>
				<!-- 모임탈퇴 -->	
		<button class="btn btn-default btn-sm" id="leaveBtn" >모임 탈퇴</button>
			<sec:authentication property="principal.memberId" var="loginId" />
		<c:if test="${group.leader eq loginId}">
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

<input type="hidden" id="leader" value="${group.leader }">
<input type="hidden" id="loginId" value="${loginId }">
 

</section>
</div>