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
%>

<%
request.setCharacterEncoding("UTF-8"); // 한글 처리
int id = Integer.parseInt(request.getParameter("id"));
String title = request.getParameter("title");
String content = request.getParameter("content");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/kopoctc", "root", "koposw31");

String sql = "update notice set title=?, content=? where id=?";

PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setString(1, title);
pstmt.setString(2, content);
pstmt.setInt(3, id);
pstmt.executeUpdate();

pstmt.close();
conn.close();

%>
	<script>
		alert("수정완료");
		window.location.href = "notice_list.jsp"; //특정페이지로의 이동
	</script>


</body>
</html>
