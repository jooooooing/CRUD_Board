<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*, java.io.*"%>

<%@ page import="java.util.Calendar"%>
<html>
<head>
<title>글 수정</title>
<style type="text/css">
textarea {
	width: 100%;
	text-align: left;
	resize: none;
}
</style>
<SCRIPT LANGUAGE="JavaScript">
	function submitForm() {
		if (mode == "write") {
			fm.action = "notice_write.jsp";
		} else if (mode == "delete") {
			fm.action = "notice_delete.jsp";
		}
		fm.submit();
	}
	//특수문자 금지 (이름)
	function characterCheck(obj) {
		var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
		if (regExp.test(obj.value)) {
			alert("특수문자는 입력하실 수 없으셔요.");
			obj.value = obj.value.substring(0, obj.value.length - 1); // 입력한 특수문자 한자리 지움
		}
	}
</SCRIPT>
</head>
<%
String today = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopoctc", "root", "koposw31");
Statement stmt = conn.createStatement(); //객체생성
String id_from_view = request.getParameter("key");
ResultSet rset = stmt.executeQuery("select * from notice where id='" + id_from_view + "';");

request.setCharacterEncoding("UTF-8"); // 한글 처리
rset.next();
int id = rset.getInt(1);
String title = rset.getString(2);
String content = rset.getString(4);

//response.Redirection("gongji_list.jsp");
%>
<FORM METHOD="POST" action="notice_updateData.jsp">
	<table width=650 border=1 cellspacing=0 cellpadding=5>
		<tr>
			<td><b>번호</b></td>
			<td><%=id%><input type=hidden name=id value=<%=id%>></td>
			<!--hidden 은 사용자가 변경해선 안되는 데이터를 보낼 때 사용-->
		</tr>
		<tr>
			<td><b>제목</b></td>
			<td><input type=text name=title size=70 maxlength=70
				value=<%=title%> onkeyup="characterCheck(this)"
				onkeydown="characterCheck(this)" required></td>
		</tr>
		<tr>
			<td><b>일자</b></td>
			<td><%=today%></td>
		</tr>
		<tr>
			<td><b>내용</b></td>
			<td><textarea
					style='width: 500px; height: 250px; overflow-y: scroll'
					name=content cols=70 row=600 required><%=content%></textarea></td>
		</tr>


	</table>

	<table width=650>
		<tr>
			<td width=600></td>
			<td><input type=button value="취소"
				OnClick="window.location='notice_list.jsp'"></td>
			<td><input type=submit value="저장"></td>
			<td><input type=button value="삭제"
				OnClick="location.href='notice_delete.jsp?key=<%=id%>'"></td>
		</tr>
	</table>
</FORM>
		<%
		rset.close();
		stmt.close();
		conn.close();
		%>


</body>
</html>
