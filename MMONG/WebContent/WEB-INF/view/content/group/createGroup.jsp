
<%@ page contentType="text/html;charset=UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


<style>

.head{
				text-align: center;
			}

</style>



</head>
<body>

	<center>
		<h2>회원 가입</h2>
	</center>

 

	<center>
	
		<form>
			<table width="700" bgcolor="#d0d4dd" border="0" cellpadding="5"
				cellspacing="1">
				<tr bgcolor="fffff">
					<td bgcolor="f5f5f5">ID:</td>
					<td><input type="text" id="id" name="memberId" size="25"><button type="button" id="idDupCheck">중복확인</button></td>					
				</tr>
				<tr bgcolor="fffff">
					<td bgcolor="f5f5f5">패스워드:</td>
					<td><input type="password" id="pw" name="password" size="25"></td>
				</tr>
				<tr bgcolor="fffff">
					<td bgcolor="f5f5f5">패스워드 확인:</td>
					<td><input type="password" id="pw_check" name="password" size="25"></td>
				</tr>
				<tr bgcolor="fffff">
					<td bgcolor="f5f5f5">이름:</td>
					<td><input type="text" id="name" name="memberName" size="25"></td>
				</tr>
				<tr bgcolor="fffff">
					<td bgcolor="f5f5f5">핸드폰번호:<br>
					<font size="2em" color="green"> - 없이 숫자만 입력해주세요.</font> </td>
					<td><input type="text" id="phone_number" name="phoneNumber" size="25"></td>
				</tr>
				<tr bgcolor="fffff">
					<td bgcolor="f5f5f5">email:</td>
					<td><input type="text" id="email" name="email" size="25"></td>
				</tr>
				<tr bgcolor="fffff">
					<td bgcolor="f5f5f5">point:</td>
					<td><input type="text" id="point" name="point" size="25" readonly/></td>
				</tr>
				<tr>
					<td><input type="button" id="join" value="가입">&nbsp; 
						<input type="reset" value="다시 작성하기">&nbsp;</td>
				</form>
				</tr>

			</table>
		</form>
		
	</center>



</body>
</html>