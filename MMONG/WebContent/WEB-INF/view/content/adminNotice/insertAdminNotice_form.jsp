<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>공지사항 글쓰기</h2>
<table>
        <form action="/MMONG/adminNotice/insertAdminNotice.do" method="post" >
        		
        	<tr>
                <th>작성자: </th>
                <td><input type="text" placeholder="작성자" name="adminId"/></td>
            </tr>
            <tr>
                <th>제목: </th>
                <td><input type="text" placeholder="제목을 입력하세요." name="title"/></td>
            </tr>
            <tr>
                <th>내용: </th>
                <td><textarea cols="80" rows="10" placeholder="내용을 입력하세요." name="content"></textarea></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="reset" value="초기화"/>
                   <input type="hidden" name="no" value="-1"/><br>
                	<input type="hidden" name="adminDate" value="2000-01-01"/>
                  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="submit"  value="등록">
                    <input type="button" value="목록 " onclick="location.href='/MMONG/adminNotice/selectAdminNoticeList.do'"/>
                </td>
            </tr>
        </form>
</table>








</body>
</html>